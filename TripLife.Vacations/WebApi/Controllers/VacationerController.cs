using Application.Vacationers.DeleteVacationer;
using Application.Vacationers.GetVacationers;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WebApi.Models.Result.Vacationers;

namespace WebApi.Controllers;

[Authorize]
[ApiController]
[Route("Vacation")]
public class VacationerController : ControllerBase
{
    private readonly IMediator _mediator;

    public VacationerController(IMediator mediator)
    {
        _mediator = mediator;
    }

    /// <summary>
    /// Retourne les participants aux vacances.
    /// </summary>
    /// <param name="vacationId">Identifiant des vacances.</param>
    /// <param name="cancellationToken">Jeton d'annulation.</param>
    /// <returns>Liste des participants aux vacances.</returns>
    [HttpGet("{vacationId:guid}/Vacationer")]
    public async Task<ActionResult<IEnumerable<VacationerResult>>> GetVacationers(Guid vacationId, CancellationToken cancellationToken)
    {
        var query = new GetVacationersQuery(vacationId);
        var result = await _mediator.Send(query, cancellationToken);

        return Ok(result);
    }

    /// <summary>
    /// Supprime un participant des vacances.
    /// </summary>
    /// <param name="vacationId">Identifiant des vacances.</param>
    /// <param name="vacationerId">Identifiant du vacancier.</param>
    /// <param name="cancellationToken">Jeton d'annulation.</param>
    /// <returns>204 si le participant a bien été supprimé.</returns>
    [HttpDelete("{vacationId:guid}/Vacationer/{vacationerId:guid}")]
    public async Task<IActionResult> DeleteVacationer(Guid vacationId, Guid vacationerId, CancellationToken cancellationToken)
    {
        var command = new DeleteVacationerCommand(vacationId, vacationerId);
        await _mediator.Send(command, cancellationToken);

        return NoContent();
    }
}
