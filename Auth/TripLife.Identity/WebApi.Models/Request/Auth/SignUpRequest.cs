namespace WebApi.Models.Request.Auth;

public class SignUpRequest
{
    public string Username { get; set; }
    public string Email { get; set; }
    public string Password { get; set; }
}
