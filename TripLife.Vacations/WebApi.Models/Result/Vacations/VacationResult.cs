namespace WebApi.Models.Result.Vacations;
public class VacationResult
{
    public Guid Id { get; }
    public string Label { get; }
    public DateTime StartDate { get; }
    public DateTime EndDate { get; }
    public bool IsOwner { get; }

    public VacationResult(Guid id, string label, DateTime startDate, DateTime endDate, bool isOwner)
    {
        Id = id;
        Label = label;
        StartDate = startDate;
        EndDate = endDate;
        IsOwner = isOwner;
    }
}
