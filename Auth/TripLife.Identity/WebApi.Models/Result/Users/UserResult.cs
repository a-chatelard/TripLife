namespace WebApi.Models.Result.Users;

public class UserResult
{
    public Guid Id { get; set; }
    public string? Username { get; set; } = string.Empty;

    public UserResult(Guid id, string? username)
    {
        Id = id;
        Username = username;
    }
}
