using Application.Users.AnswerFriendRequest;
using Application.Users.GetFriendsList;
using Application.Users.SendFriendRequest;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using WebApi.Extensions;
using WebApi.Models.Request.Users;
using WebApi.Models.Result.Users;

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

    [HttpPost("Friend")]
    public async Task<IActionResult> SendFriendRequest([FromBody] FriendRequest request, CancellationToken cancellationToken)
    {
        var command = new SendFriendRequestCommand(HttpContext.GetRequesterId(), request);
        await _mediator.Send(command, cancellationToken);

        return Ok();
    }

    [HttpGet("Friend")]
    public async Task<ActionResult<IEnumerable<UserResult>>> GetFriendsList(CancellationToken cancellationToken)
    {
        var command = new GetFriendsListQuery(HttpContext.GetRequesterId());
        var result = await _mediator.Send(command, cancellationToken);

        return Ok(result);
    }

    [HttpPut("FriendRequest/{friendRequestId:guid}")]
    public async Task<IActionResult> AnswerFriendRequest([FromRoute] Guid friendRequestId, [FromBody] FriendRequestAnswer request, CancellationToken cancellationToken)
    {
        var command = new AnswerFriendRequestCommand(HttpContext.GetRequesterId(), friendRequestId, request);
        await _mediator.Send(command, cancellationToken);

        return Ok();
    }
}
