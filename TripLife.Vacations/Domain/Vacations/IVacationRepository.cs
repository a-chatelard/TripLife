namespace Domain.Vacations;

public interface IVacationRepository
{
    Task<Guid> CreateVacation(Vacation vacation, CancellationToken cancellationToken);

    Task DeleteVacation(Vacation vacation, CancellationToken cancellationToken);

    Task<Vacation?> GetVacationById(Guid id, CancellationToken cancellationToken);

    Task UpdateVacation(Vacation vacation, CancellationToken cancellationToken);
}
