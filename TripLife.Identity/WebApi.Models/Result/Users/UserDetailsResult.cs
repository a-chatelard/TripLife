namespace WebApi.Models.Result.Users;

public class UserDetailsResult : UserResult
{
    public bool Friend { get; set; }

    public UserDetailsResult(Guid id, string? username, bool friend): base(id, username)
    {
        Friend = friend;
    }
}
