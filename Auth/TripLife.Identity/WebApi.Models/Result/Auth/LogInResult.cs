namespace WebApi.Models.Result.Auth;

public class LogInResult
{
    public string AccessToken { get; set; }

    public LogInResult(string accessToken)
    {
        AccessToken = accessToken;
    }
}
