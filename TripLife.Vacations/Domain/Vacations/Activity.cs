namespace Domain.Vacations;
public class Activity
{
    public Guid Id { get; }

    public Vacation Vacation { get; } = default!;
    public Guid VacationId { get; }
}
