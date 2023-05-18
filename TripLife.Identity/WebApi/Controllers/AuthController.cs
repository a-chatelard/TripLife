using Application.Auth.LogIn;
using Application.Auth.SignUp;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WebApi.Models.Request.Auth;

namespace WebApi.Controllers;

[ApiController]
[Authorize]
[Route("[controller]")]
public class AuthController : ControllerBase
{
    private readonly IMediator _mediator;

    public AuthController(IMediator mediator)
    {
        _mediator = mediator;
    }

    /// <summary>
    /// Création d'un compte utilisateur.
    /// </summary>
    /// <param name="request">Informations du compte.</param>
    /// <param name="cancellationToken">Jeton d'annulation.</param>
    /// <returns>Ok si le compte a bien été crée.</returns>
    [HttpPost("SignUp")]
    [AllowAnonymous]
    public async Task<IActionResult> SignUp([FromBody] SignUpRequest request, CancellationToken cancellationToken)
    {
        var command = new SignUpCommand(request);

        await _mediator.Send(command, cancellationToken);

        return Ok();
    }
    
    /// <summary>
    /// Identifie un utilisateur.
    /// </summary>
    /// <param name="request">Identifiant de connexion.</param>
    /// <param name="cancellationToken">Jeton d'annulation.</param>
    /// <returns>Le token d'authentification de l'utilisateur.</returns>
    [HttpPost("LogIn")]
    [AllowAnonymous]
    public async Task<IActionResult> LogIn([FromBody] LogInRequest request, CancellationToken cancellationToken)
    {
        var command = new LogInCommand(request);

        var result = await _mediator.Send(command, cancellationToken);

        return Ok(result);
    }
}
