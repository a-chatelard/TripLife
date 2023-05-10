using WebApi.Models.Request.Auth;
using WebApi.Models.Result.Auth;

namespace Application.Auth.LogIn;

public class LogInCommand : IRequest<LogInResult>
{
    public string Email { get; }
    public string Password { get; }

    public LogInCommand(LogInRequest request) 
    {
        Email = request.Email;
        Password = request.Password;
    }
}
