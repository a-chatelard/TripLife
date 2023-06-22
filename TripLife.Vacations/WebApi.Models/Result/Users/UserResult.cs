namespace WebApi.Models.Result.Users;
public class UserResult
{
    public Guid Id { get; }
    public string? Username { get; }

    public UserResult(Guid id, string? username)
    {
        Id = id;
        Username = username;
    }
}
