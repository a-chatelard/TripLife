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

        if (request.Answer)
        {
            user.AcceptFriendRequest(request.FriendRequestId);
        }
        else
        {
            user.RejectFriendRequest(request.FriendRequestId);
        }

        await _userRepository.UpdateUser(user, cancellationToken);
    }
}
