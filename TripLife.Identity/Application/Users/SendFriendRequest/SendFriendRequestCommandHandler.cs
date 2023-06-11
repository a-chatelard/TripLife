using Domain.Users;
using TripLife.Foundation.Domain.Exceptions;

namespace Application.Users.SendFriendRequest
{
    public class SendFriendRequestCommandHandler : IRequestHandler<SendFriendRequestCommand, Guid?>
    {
        private readonly IUserRepository _userRepository;

        public SendFriendRequestCommandHandler(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public async Task<Guid?> Handle(SendFriendRequestCommand request, CancellationToken cancellationToken)
        {
            var user = await _userRepository.GetUserById(request.UserId, cancellationToken)
                ?? throw new DomainException("Utilisateur non existant.");
            
            var recipient = await _userRepository.GetUserById(request.RecipientId, cancellationToken)
                ?? throw new DomainException("L'utilisateur demandé n'existe pas ou plus.");
            
            var friendRequest = user.SendFriendRequest(recipient);

            await _userRepository.UpdateUser(user, cancellationToken);

            return friendRequest?.Id;
        }
    }
}
