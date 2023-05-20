using Application.Auth.Events;
using Application.Exceptions;
using Domain.Auth;
using Domain.Users;
using Microsoft.AspNetCore.Identity;
using Microsoft.Extensions.Logging;
using System.Text.Json;
using WebApi.Models.Events.Auth;

namespace Application.Auth.SignUp;

public class SignUpCommandHandler : IRequestHandler<SignUpCommand, Unit>
{
    private readonly IAuthRepository _authRepository;
    private readonly IUserCreatedEmitter _userCreatedEmitter;
    private readonly ILogger<SignUpCommand> _logger;

    public SignUpCommandHandler(IAuthRepository authRepository, IUserCreatedEmitter userCreatedEmitter, ILogger<SignUpCommand> logger)
    {
        _authRepository = authRepository;
        _userCreatedEmitter = userCreatedEmitter;
        _logger = logger;
    }

    public async Task<Unit> Handle(SignUpCommand request, CancellationToken cancellationToken)
    {
        var user = User.Create(request.Username, request.Email);

        var result = await _authRepository.CreateUser(user, request.Password);

        if (result.Succeeded)
        {
            try
            {
                await _userCreatedEmitter.EmitAsync(new UserCreatedEvent(user.Id, user.UserName));
            }
            catch (Exception ex)
            {
                _logger.LogError($"Erreur lors de l'emission de l'évènement de création d'un utilisateur : {ex}");
            }

            return Unit.Value;
        }
        else
        {
            throw new AuthException(JsonSerializer.Serialize<IEnumerable<IdentityError>>(result.Errors.ToList()));
        }
    }
}
