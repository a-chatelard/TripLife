using Application.Auth.LogIn;
using Application.Auth.SignUp;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System.Security.Claims;
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

    [HttpPost("SignUp")]
    [AllowAnonymous]
    public async Task<IActionResult> SignUp([FromBody] SignUpRequest request, CancellationToken cancellationToken)
    {
        var command = new SignUpCommand(request);

        await _mediator.Send(command, cancellationToken);

        return Ok();
    }

    [HttpPost("LogIn")]
    [AllowAnonymous]
    public async Task<IActionResult> LogIn([FromBody] LogInRequest request, CancellationToken cancellationToken)
    {
        var command = new LogInCommand(request);

        var result = await _mediator.Send(command, cancellationToken);

        return Ok(result);
    }

    [HttpGet]
    public async Task<IActionResult> Test()
    {
        var identity = HttpContext.User.Identity as ClaimsIdentity;
        return Ok();
    }
}
