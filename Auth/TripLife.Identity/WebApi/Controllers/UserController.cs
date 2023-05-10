using Application.Users.AnswerFriendRequest;
using Application.Users.CancelFriendRequest;
using Application.Users.GetFriendRequests;
using Application.Users.GetFriendsList;
using Application.Users.GetSentFriendRequests;
using Application.Users.GetUserByUsername;
using Application.Users.GetUserDetails;
using Application.Users.RemoveFriend;
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

    /// <summary>
    /// Retourne les informations d'un utilisateur, notamment si l'utilisateur connecté est ami avec lui.
    /// </summary>
    /// <param name="userId">Utilisateur dont on souhaite récupérer les informations.</param>
    /// <param name="cancellationToken">Jeton d'annulation.</param>
    /// <returns>Les informations de l'utilisateur.</returns>
    [HttpGet("{userId:guid}")]
    public async Task<ActionResult<UserDetailsResult>> GetUserDetails(Guid userId, CancellationToken cancellationToken)
    {
        var query = new GetUserDetailsQuery(HttpContext.GetRequesterId(), userId);
        var result = await _mediator.Send(query, cancellationToken);
        
        return Ok(result);
    }

    /// <summary>
    /// Recherche un utilisateur par son nom d'utilisateur.
    /// </summary>
    /// <param name="username">Nom d'utilisateur recherché.</param>
    /// <param name="cancellationToken">Jeton d'annulation.</param>
    /// <returns>Les informations de l'utilisateur s'il a été trouvé, null sinon.</returns>
    [HttpGet("Search")]
    public async Task<ActionResult<UserResult?>> GetUserByUsername([FromQuery] string username, CancellationToken cancellationToken)
    {
        var query = new GetUserByUsernameQuery(username);
        var result = await _mediator.Send(query, cancellationToken);

        return Ok(result);
    }

    /// <summary>
    /// Liste les amis de l'utilisateur connecté.
    /// </summary>
    /// <param name="cancellationToken">Jeton d'annulation.</param>
    /// <returns>Liste contenant les amis de l'utilisateur connecté.</returns>
    [HttpGet("Friend")]
    public async Task<ActionResult<IEnumerable<UserResult>>> GetFriendsList(CancellationToken cancellationToken)
    {
        var command = new GetFriendsListQuery(HttpContext.GetRequesterId());
        var result = await _mediator.Send(command, cancellationToken);

        return Ok(result);
    }

    [HttpDelete("Friend/{friendId}")]
    public async Task<IActionResult> RemoveFriend(Guid friendId, CancellationToken cancellationToken)
    {
        var command = new RemoveFriendCommand(HttpContext.GetRequesterId(), friendId);
        await _mediator.Send(command, cancellationToken);

        return Ok();
    }

    /// <summary>
    /// Liste les demandes d'ami reçues en attente.
    /// </summary>
    /// <param name="cancellationToken">Jeton d'annulation.</param>
    /// <returns>Liste contenant les demandes d'ami reçues en attente</returns>
    [HttpGet("FriendRequest/Received")]
    public async Task<ActionResult<IEnumerable<FriendRequestResult>>> GetReceivedFriendRequests(CancellationToken cancellationToken)
    {
        var query = new GetReceivedFriendRequestsQuery(HttpContext.GetRequesterId());
        var result = await _mediator.Send(query, cancellationToken);

        return Ok(result);
    }

    /// <summary>
    /// Liste les demandes d'ami envoyées en attente.
    /// </summary>
    /// <param name="cancellationToken">Jeton d'annulation.</param>
    /// <returns>Liste contenant les demandes d'ami envoyées en attente.</returns>
    [HttpGet("FriendRequest/Sent")]
    public async Task<ActionResult<IEnumerable<FriendRequestResult>>> GetSentFriendRequests(CancellationToken cancellationToken)
    {
        var query = new GetSentFriendRequestsQuery(HttpContext.GetRequesterId());
        var result = await _mediator.Send(query, cancellationToken);

        return Ok(result);
    }

    /// <summary>
    /// Envoi une demande d'ami à un utilisateur.
    /// </summary>
    /// <param name="request">Requête contenant l'id du destinataire.</param>
    /// <param name="cancellationToken">Jeton d'annulation</param>
    /// <returns>
    /// 201 si une demande d'ami a bien été créée et envoyée. <br></br>
    /// 200 si le destinaire avait envoyé une demande d'ami, celle-ci a été acceptée.
    /// </returns>
    [HttpPost("FriendRequest")]
    public async Task<ActionResult<Guid?>> SendFriendRequest([FromBody] FriendRequest request, CancellationToken cancellationToken)
    {
        var command = new SendFriendRequestCommand(HttpContext.GetRequesterId(), request);
        var result = await _mediator.Send(command, cancellationToken);

        if (result.HasValue)
        {
            return CreatedAtAction(nameof(SendFriendRequest), result);
        }
        return Ok();
    }

    /// <summary>
    /// Répond à une demande d'ami reçue.
    /// </summary>
    /// <param name="friendRequestId">Identifiant de la demande d'ami.</param>
    /// <param name="request">Réponse (True/False).</param>
    /// <param name="cancellationToken">Jeton d'annulation.</param>
    /// <returns>Ok si la réponse à la demande a été prise en compte.</returns>
    [HttpPatch("FriendRequest/{friendRequestId:guid}")]
    public async Task<IActionResult> AnswerFriendRequest([FromRoute] Guid friendRequestId, [FromBody] FriendRequestAnswer request, CancellationToken cancellationToken)
    {
        var command = new AnswerFriendRequestCommand(HttpContext.GetRequesterId(), friendRequestId, request);
        await _mediator.Send(command, cancellationToken);

        return Ok();
    }

    /// <summary>
    /// Supprime un demande d'ami envoyée en attente.
    /// </summary>
    /// <param name="friendRequestId">Identifiant de la demande d'ami.</param>
    /// <param name="cancellationToken">Jeton d'annulation.</param>
    /// <returns>Ok si la demande a bien été annulée.</returns>
    [HttpDelete("FriendRequest/{friendRequestId:guid}")]
    public async Task<IActionResult> CancelFriendRequest([FromRoute] Guid friendRequestId, CancellationToken cancellationToken)
    {
        var command = new CancelFriendRequestCommand(HttpContext.GetRequesterId(), friendRequestId);
        await _mediator.Send(command, cancellationToken);
        
        return Ok();
    }
}
