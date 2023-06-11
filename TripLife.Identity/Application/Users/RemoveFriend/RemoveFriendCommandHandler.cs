using Domain.Users;
using TripLife.Foundation.Domain.Exceptions;

namespace Application.Users.RemoveFriend;

public class RemoveFriendCommandHandler : IRequestHandler<RemoveFriendCommand>
{
    private readonly IUserRepository _userRepository;

    public RemoveFriendCommandHandler(IUserRepository userRepository)
    {
        _userRepository = userRepository;
    }

    public async Task Handle(RemoveFriendCommand request, CancellationToken cancellationToken)
    {
        var user = await _userRepository.GetUserById(request.userId, cancellationToken)
            ?? throw new DomainException("Utilisateur non existant.");

        user.RemoveFriendship(request.friendId);

        await _userRepository.UpdateUser(user, cancellationToken);
    }
}
