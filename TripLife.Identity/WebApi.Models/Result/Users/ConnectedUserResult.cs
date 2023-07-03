namespace WebApi.Models.Result.Users;
public class ConnectedUserResult : UserResult
{
    public string Email { get; }

    public ConnectedUserResult(Guid id, string? username, string email): base(id, username)
    {
        Email = email;
    }
}
