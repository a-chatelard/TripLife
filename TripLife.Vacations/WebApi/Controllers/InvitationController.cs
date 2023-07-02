using Application.Invitations.AnswerInvitation;
using Application.Invitations.CancelInvitation;
using Application.Invitations.GetPendingVacationInvitation;
using Application.Invitations.InviteUser;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using TripLife.Foundation.WebApi.Extension;
using WebApi.Models.Request.Invitations;
using WebApi.Models.Request.Vacationers;
using WebApi.Models.Result.Invitations;

namespace WebApi.Controllers;

[ApiController]
public class InvitationController : ControllerBase
{
    private readonly IMediator _mediator;

    public InvitationController(IMediator mediator)
    {
        _mediator = mediator;
    }

    /// <summary>
    /// Invite un utilisateur à participer aux vacances.
    /// </summary>
    /// <param name="vacationId">Identifiant des vacances.</param>
    /// <param name="request">Requête contenant l'identifiant de l'utilisateur.</param>
    /// <param name="cancellationToken">Jeton d'annulation.</param>
    /// <returns>201 si l'invitation a bien été ajoutée.</returns>
    [HttpPost("Vacation/{vacationId:guid}/Invitation")]
    public async Task<IActionResult> InviteUser(Guid vacationId, [FromBody] VacationerRequest request, CancellationToken cancellationToken)
    {
        var command = new InviteUserCommand(HttpContext.GetRequesterId(), vacationId, request);
        var result = await _mediator.Send(command, cancellationToken);

        return CreatedAtAction(nameof(InviteUser), result);
    }

    /// <summary>
    /// Annule l'invitation envoyée à un utilisateur.
    /// </summary>
    /// <param name="vacationId">Identifiant des vacances.</param>
    /// <param name="vacationerId">Identifiant de l'invitation</param>
    /// <param name="cancellationToken">Jeton d'annulation.</param>
    /// <returns>204 si l'invitation a bien été annulée.</returns>
    [HttpDelete("Vacation/{vacationId:guid}/Invitation/{vacationerId:guid}")]
    public async Task<IActionResult> CancelInvitation(Guid vacationId, Guid vacationerId, CancellationToken cancellationToken)
    {
        var command = new CancelInvitationCommand(HttpContext.GetRequesterId(), vacationId, vacationerId);
        await _mediator.Send(command, cancellationToken);
        
        return NoContent();
    }

    /// <summary>
    /// Répond à une demande d'invitation à participer à des vacances.
    /// </summary>
    /// <param name="vacationId">Identifiant des vacances.</param>
    /// <param name="vacationerId">Identifiant de l'invitation.</param>
    /// <param name="request">Requête contenant la réponse à l'invitation.</param>
    /// <param name="cancellationToken">Jeton d'annulation.</param>
    /// <returns>200 si la réponse à l'invitation a bien été prise en compte.</returns>
    [HttpPatch("Vacation/{vacationId:guid}/Invitation/{vacationerId:guid}")]
    public async Task<IActionResult> AnswerInvitation(Guid vacationId, Guid vacationerId, [FromBody] InvitationAnswerRequest request, CancellationToken cancellationToken)
    {
        var command = new AnswerInvitationCommand(HttpContext.GetRequesterId(), vacationId, vacationerId, request);
        await _mediator.Send(command, cancellationToken);

        return Ok();
    }

    
    /// <summary>
    /// Récupère les invitations en attente des vacances concernées.
    /// </summary>
    /// <param name="vacationId">Identifiant des vacances.</param>
    /// <param name="cancellationToken">Jeton d'annulation.</param>
    /// <returns>Une liste d'invitations.</returns>
    [HttpGet("Vacation/{vacationId:guid}/Invitation")]
    public async Task<ActionResult<IEnumerable<InvitationResult>>> GetPendingInvitation(Guid vacationId, CancellationToken cancellationToken)
    {
        var query = new GetPendingVacationInvitationQuery(HttpContext.GetRequesterId(), vacationId);
        var result = await _mediator.Send(query, cancellationToken);

        return Ok(result);
    }
}
