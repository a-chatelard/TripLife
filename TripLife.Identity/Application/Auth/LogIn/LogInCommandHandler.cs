using Application.Exceptions;
using Application.Services;
using Domain.Auth;
using WebApi.Models.Result.Auth;

namespace Application.Auth.LogIn;

public class LogInCommandHandler : IRequestHandler<LogInCommand, LogInResult>
{
    private readonly IAuthRepository _authRepository;
    private readonly JwtTokenService _jwtTokenService;

    public LogInCommandHandler(IAuthRepository authRepository, JwtTokenService jwtTokenService)
    {
        _authRepository = authRepository;
        _jwtTokenService = jwtTokenService;
    }

    public async Task<LogInResult> Handle(LogInCommand request, CancellationToken cancellationToken)
    {
        var user = await _authRepository.GetUserByEmail(request.Email)
            ?? throw new AuthException("Erreur lors de la connexion.");
        
        var isPasswordValid = await _authRepository.CheckPassword(user, request.Password);

        if (isPasswordValid)
        {
            var jwtToken = _jwtTokenService.CreateToken(user);
            return jwtToken;
        } 
        else
        {
            throw new AuthException("Erreur lors de la connexion.");
        }
    }
}
