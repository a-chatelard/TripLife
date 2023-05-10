namespace WebApi.Models.Result.Users;

public class FriendRequestResult
{
    public Guid RequestId { get; set; }
    public string? Username { get; set; }

    public FriendRequestResult(Guid requestId, string? username)
    {
        RequestId = requestId;
        Username = username;
    }
}
