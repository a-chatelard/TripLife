using MediatR;
using Microsoft.AspNetCore.Mvc;

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
    /// Retourne les informations d'un utilisateur, notamment si l'utilisateur connecté est ami avec lui.
    /// </summary>
    /// <returns>Les informations de l'utilisateur.</returns>
    [HttpGet]
    public async Task<IActionResult> Get()
    {
        return Ok();
    }
}
