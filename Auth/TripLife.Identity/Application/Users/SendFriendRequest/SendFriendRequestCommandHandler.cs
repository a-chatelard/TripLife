﻿using Domain.Exceptions;
using Domain.Users;

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
            var sender = await _userRepository.GetUserById(request.SenderId, cancellationToken)
                ?? throw new DomainException("Utilisateur non existant.");
            
            var recipient = await _userRepository.GetUserById(request.RecipientId, cancellationToken)
                ?? throw new DomainException("L'utilisateur demandé n'existe pas ou plus.");
            
            var friendRequest = FriendsService.SendFriendRequest(sender, recipient);

            await _userRepository.UpdateUser(sender, cancellationToken);
            await _userRepository.UpdateUser(recipient, cancellationToken);

            return friendRequest?.Id;
        }
    }
}