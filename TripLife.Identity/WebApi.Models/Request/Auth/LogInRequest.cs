namespace WebApi.Models.Request.Auth;

public class LogInRequest
{
    public string Email { get; set; }
    public string Password { get; set; }

    public LogInRequest(string email, string password)
    {
        Email = email;
        Password = password;
    }
}
