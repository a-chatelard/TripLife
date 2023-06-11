using Domain.Users;

namespace Domain.Vacations;
public class Vacationer
{
    public Guid Id { get; }
    public Guid VacationId { get; }
    public Vacation Vacation { get; } = default!;
    public Guid UserId { get; }
    public User User { get; } = default!;
    public bool IsOwner { get; }
    public bool IsConfirmed { get; private set; }

    internal Vacationer() { }

    private Vacationer(Guid vacationId, Guid userId, bool isOwner)
    {
        VacationId = vacationId;
        UserId = userId;
        IsOwner = isOwner;
    }

    public static Vacationer Create(Guid vacationId, Guid userId, bool isOwner)
    {
        return new Vacationer(vacationId, userId, isOwner);
    }

    public void Confirm()
    {
        IsConfirmed = true;
    }
}
