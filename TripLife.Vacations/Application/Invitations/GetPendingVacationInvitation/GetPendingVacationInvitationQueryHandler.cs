using Infrastructure.Context;
using Microsoft.EntityFrameworkCore;
using TripLife.Foundation.Domain.Exceptions;
using WebApi.Models.Result.Invitations;
using WebApi.Models.Result.Users;
using WebApi.Models.Result.Vacations;

namespace Application.Invitations.GetPendingVacationInvitation;
public class GetPendingVacationInvitationQueryHandler : IRequestHandler<GetPendingVacationInvitationQuery, IEnumerable<InvitationResult>>
{
    private readonly ApplicationDbContext _context;

    public GetPendingVacationInvitationQueryHandler(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<IEnumerable<InvitationResult>> Handle(GetPendingVacationInvitationQuery request, CancellationToken cancellationToken)
    {
        var vacation = await _context.Vacations
            .Include(v => v.Vacationers.Where(v => v.IsOwner))
            .Where(v => v.Id == request.VacationId)
            .AsNoTracking()
            .FirstOrDefaultAsync()
            ?? throw new DomainException($"Les vacances n'ont pas été trouvées.");

        var owner = vacation.Vacationers.Single();
        if (owner.UserId != request.RequesterId)
        {
            throw new DomainException("Accès non autorisé.");
        }

        var result = await _context.Vacationers.Where(v => v.VacationId == request.VacationId && !v.IsConfirmed)
            .Include(v => v.Vacation)
            .Include(v => v.User)
            .AsNoTracking()
            .ToListAsync(cancellationToken);

        return result.Select(v => new InvitationResult(
            v.Id,
            new UserResult(v.User.Id, v.User.Username),
            new VacationResult(v.Vacation.Id, v.Vacation.Label, v.Vacation.Period.StartDate, v.Vacation.Period.EndDate, false)));
    }
}
