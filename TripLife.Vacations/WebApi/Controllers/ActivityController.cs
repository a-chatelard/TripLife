﻿using Application.Activities.AddParticipation;
using Application.Activities.CreateActivity;
using Application.Activities.DeleteActivity;
using Application.Activities.RemoveParticipation;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using TripLife.Foundation.WebApi.Extension;
using WebApi.Models.Request.Activities;

namespace WebApi.Controllers;

[ApiController]
[Route("Vacation")]
public class ActivityController : ControllerBase
{
    private readonly IMediator _mediator;

    public ActivityController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpPost("{vacationId:guid}/Activity")]
    public async Task<ActionResult<Guid>> AddActivity(Guid vacationId, [FromBody] ActivityRequest request, CancellationToken cancellationToken)
    {
        var command = new CreateActivityCommand(HttpContext.GetRequesterId(), vacationId, request);
        var result = await _mediator.Send(command, cancellationToken);

        return CreatedAtAction(nameof(AddActivity), result);
    }

    [HttpDelete("{vacationId:guid}/Activity/{activityId:guid}")]
    public async Task<IActionResult> DeleteActivity(Guid vacationId, Guid activityId, CancellationToken cancellationToken)
    {
        var command = new DeleteActivityCommand(HttpContext.GetRequesterId(), vacationId, activityId);
        await _mediator.Send(command, cancellationToken);
        return Ok();
    }

    [HttpPost("{vacationId:guid}/Activity/{activityId:guid}/Participation")]
    public async Task<IActionResult> AddParticipation(Guid vacationId, Guid activityId, CancellationToken cancellationToken)
    {
        var command = new AddParticipationCommand(HttpContext.GetRequesterId(), vacationId, activityId);
        await _mediator.Send(command, cancellationToken);
        return Ok();
    }


    [HttpDelete("{vacationId:guid}/Activity/{activityId:guid}/Participation")]
    public async Task<IActionResult> RemoveParticipation(Guid vacationId, Guid activityId, CancellationToken cancellationToken)
    {
        var command = new RemoveParticipationCommand(HttpContext.GetRequesterId(), vacationId, activityId);
        await _mediator.Send(command, cancellationToken);

        return Ok();
    }
}
