using Domain.Exceptions;
using Domain.Users;

namespace Application.Users.AnswerFriendRequest;
public class AnswerFriendRequestCommandHandler : IRequestHandler<AnswerFriendRequestCommand>
{
    private readonly IUserRepository _userRepository;

    public AnswerFriendRequestCommandHandler(IUserRepository userRepository)
    {
        _userRepository = userRepository;
    }

    public async Task Handle(AnswerFriendRequestCommand request, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetUserById(request.UserId, cancellationToken)
            ?? throw new DomainException("Utilisateur non existant.");

        var friendRequest = user.ReceivedFriendships.FirstOrDefault(rf => rf.Id == request.FriendRequestId)
            ?? throw new DomainException("Demande d'ami non existante.");

        if (request.Answer)
        {
            user.AcceptFriendRequest(friendRequest);
        }
        else
        {
            user.RejectFriendRequest(friendRequest);
        }

        await _userRepository.UpdateUser(user, cancellationToken);
    }
}
