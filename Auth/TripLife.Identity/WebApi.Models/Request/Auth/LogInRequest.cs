namespace WebApi.Models.Request.Auth;

public class LogInRequest
{
    public string Username { get; set; }
    public string Password { get; set; }

    public LogInRequest(string username, string password)
    {
        Username = username;
        Password = password;
    }
}
