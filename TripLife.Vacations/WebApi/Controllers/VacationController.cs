using Application.Vacations.CreateVacation;
using Application.Vacations.DeleteVacation;
using Application.Vacations.GetUserVacations;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using TripLife.Foundation.WebApi.Extension;
using WebApi.Models.Request.Vacations;

namespace WebApi.Controllers;

[ApiController]
[Route("[controller]")]
public class VacationController : ControllerBase
{
    private readonly IMediator _mediator;

    public VacationController(IMediator mediator)
    {
        _mediator = mediator;
    }

    /// <summary>
    /// Récupère les vacances auxquelles l'utilisateur connecté participe.
    /// </summary>
    /// <returns></returns>
    [HttpGet]
    public async Task<ActionResult> GetUserVacations(CancellationToken cancellationToken)
    {
        var query = new GetUserVacationsQuery(HttpContext.GetRequesterId());
        var result = await _mediator.Send(query, cancellationToken);

        return Ok(result);
    }

    [HttpPost]
    public async Task<ActionResult<Guid>> CreateVacation([FromBody] VacationRequest request)
    {
        var command = new CreateVacationCommand(HttpContext.GetRequesterId(), request);
        var result = await _mediator.Send(command);

        return CreatedAtAction(nameof(CreateVacation), result);
    }

    [HttpDelete("{vacationId:guid}")]
    public async Task<IActionResult> DeleteVacation(Guid vacationId, CancellationToken cancellationToken)
    {
        var command = new DeleteVacationCommand(HttpContext.GetRequesterId(), vacationId);
        await _mediator.Send(command, cancellationToken);
        
        return NoContent();
    }

}
