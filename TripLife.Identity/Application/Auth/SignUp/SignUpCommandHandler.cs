using Application.Exceptions;
using Domain.Auth;
using Domain.Users;
using Microsoft.AspNetCore.Identity;
using System.Text.Json;

namespace Application.Auth.SignUp;

public class SignUpCommandHandler : IRequestHandler<SignUpCommand, Unit>
{
    private readonly IAuthRepository _authRepository;

    public SignUpCommandHandler(IAuthRepository authRepository)
    {
        _authRepository = authRepository;
    }

    public async Task<Unit> Handle(SignUpCommand request, CancellationToken cancellationToken)
    {
        var user = User.Create(request.Username, request.Email);

        var result = await _authRepository.CreateUser(user, request.Password);

        if (result.Succeeded)
        {
            return Unit.Value;
        }
        else
        {
            throw new AuthException(JsonSerializer.Serialize<IEnumerable<IdentityError>>(result.Errors.ToList()));
        }
    }
}
