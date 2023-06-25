using Application.Vacations.CreateVacation;
using Application.Vacations.DeleteVacation;
using Application.Vacations.GetUserVacations;
using Application.Vacations.GetVacationDetails;
using MediatR;
using Microsoft.AspNetCore.Mvc;
using TripLife.Foundation.WebApi.Extension;
using WebApi.Models.Request.Vacations;
using WebApi.Models.Result.Vacations;

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
    /// <param name="cancellationToken">Jeton d'annulation.</param>
    /// <returns>Une liste de vacances.</returns>
    [HttpGet]
    public async Task<ActionResult<IEnumerable<VacationResult>>> GetUserVacations(CancellationToken cancellationToken)
    {
        var query = new GetUserVacationsQuery(HttpContext.GetRequesterId());
        var result = await _mediator.Send(query, cancellationToken);

        return Ok(result);
    }

    /// <summary>
    /// Retourne les informations détaillées des vacances demandée.
    /// </summary>
    /// <param name="vacationId">Identifiant des vacances.</param>
    /// <param name="cancellationToken">Jeton d'annulation</param>
    /// <returns></returns>
    [HttpGet("{vacationId:guid}")]
    public async Task<ActionResult<VacationResult>> GetVacationDetails(Guid vacationId, CancellationToken cancellationToken)
    {
        var query = new GetVacationDetailsQuery(vacationId);
        var result = await _mediator.Send(query, cancellationToken);
        return Ok(result);
    }

    /// <summary>
    /// Crée des vacances.
    /// </summary>
    /// <param name="request">Requête contenant les informations des vacances à créer.</param>
    /// <param name="cancellationToken">Jeton d'annulation.</param>
    /// <returns>L'identifiant des vacances créées.</returns>
    [HttpPost]
    public async Task<ActionResult<Guid>> CreateVacation([FromBody] VacationRequest request, CancellationToken cancellationToken)
    {
        var command = new CreateVacationCommand(HttpContext.GetRequesterId(), request);
        var result = await _mediator.Send(command, cancellationToken);

        return CreatedAtAction(nameof(CreateVacation), result);
    }

    /// <summary>
    /// Supprime des vacances, seul l'organisateur peut les supprimer.
    /// </summary>
    /// <param name="vacationId">Identifiant des vacances à supprimer.</param>
    /// <param name="cancellationToken">Jeton d'annulation.</param>
    /// <returns></returns>
    [HttpDelete("{vacationId:guid}")]
    public async Task<IActionResult> DeleteVacation(Guid vacationId, CancellationToken cancellationToken)
    {
        var command = new DeleteVacationCommand(HttpContext.GetRequesterId(), vacationId);
        await _mediator.Send(command, cancellationToken);
        
        return NoContent();
    }

}
