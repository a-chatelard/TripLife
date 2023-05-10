using WebApi.Models.Request.Auth;

namespace Application.Auth.SignUp;

public class SignUpCommand : IRequest<Unit>
{
    public string Username { get; }
    public string Email { get; }
    public string Password { get; }

    public SignUpCommand(SignUpRequest request)
    {
        Username = request.Username;
        Email = request.Email;
        Password = request.Password;
    }
}
