using Application.Users.SendFriendRequest;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WebApi.Extensions;
using WebApi.Models.Request.Users;

namespace WebApi.Controllers;

[ApiController]
[Authorize]
[Route("[controller]")]
public class UserController : ControllerBase
{
    private readonly IMediator _mediator;

    public UserController(IMediator mediator)
    {
        _mediator = mediator;
    }

    [HttpPost]
    public async Task<IActionResult> SendFriendRequest([FromBody] FriendRequest request)
    {
        var command = new SendFriendRequestCommand(HttpContext.GetRequesterId(), request);
        await _mediator.Send(command);

        return Ok();
    }
}
