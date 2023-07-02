namespace WebApi.Models.Result.Vacationers;
public class VacationerResult
{
    public Guid Id { get; }
    public Guid VacationId { get; }
    public Guid UserId { get; }
    public string? Username { get; }
    public bool IsOwner { get; }

    public VacationerResult(Guid id, Guid vacationId, Guid userId, string? username)
    {
        Id = id;
        VacationId = vacationId;
        UserId = userId;
        Username = username;
    }
}
