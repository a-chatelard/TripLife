using Domain.Users;
using TripLife.Foundation.Domain.Exceptions;

namespace Application.Users.CancelFriendRequest;

public class CancelFriendRequestCommandHandler : IRequestHandler<CancelFriendRequestCommand>
{
    private readonly IUserRepository _userRepository;

    public CancelFriendRequestCommandHandler(IUserRepository userRepository)
    {
        _userRepository = userRepository;
    }

    public async Task Handle(CancelFriendRequestCommand request, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetUserById(request.UserId, cancellationToken)
            ?? throw new DomainException("Utilisateur non existant");

        user.CancelFriendRequest(request.FriendRequestId);

        await _userRepository.UpdateUser(user, cancellationToken);
    }
}
