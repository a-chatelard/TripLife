using Domain.Vacations;
using Infrastructure.Context;
using Microsoft.EntityFrameworkCore;

namespace Infrastructure.Repositories;
public class VacationRepository : IVacationRepository
{
    private readonly ApplicationDbContext _context;

    public VacationRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Guid> CreateVacation(Vacation vacation, CancellationToken cancellationToken)
    {
        _context.Add(vacation);
        await _context.SaveChangesAsync(cancellationToken);
        return vacation.Id;
    }

    public async Task DeleteVacation(Vacation vacation, CancellationToken cancellationToken)
    {
        _context.Remove(vacation);
        await _context.SaveChangesAsync(cancellationToken);
    }

    public Task<Vacation?> GetVacationById(Guid id, CancellationToken cancellationToken)
    {
        return _context.Vacations
            .Include(v => v.Activities)
            .ThenInclude(a => a.Participations)
            .Include(v => v.Vacationers)
            .FirstOrDefaultAsync(v => v.Id == id, cancellationToken);
    }

    public Task UpdateVacation(Vacation vacation, CancellationToken cancellationToken)
    {
        _context.Update(vacation);
        return _context.SaveChangesAsync(cancellationToken);
    }
}
