using Infrastructure.Context;
using Microsoft.EntityFrameworkCore;
using WebApi.Models.Result.Invitations;
using WebApi.Models.Result.Users;
using WebApi.Models.Result.Vacations;

namespace Application.Invitations.GetUserVacationInvitations;
public class GetUserVacationInvitationsQueryHandler : IRequestHandler<GetUserVacationInvitationsQuery, IEnumerable<InvitationResult>>
{
    private readonly ApplicationDbContext _context;

    public GetUserVacationInvitationsQueryHandler(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<IEnumerable<InvitationResult>> Handle(GetUserVacationInvitationsQuery request, CancellationToken cancellationToken)
    {
        var invitations = await _context.Vacationers
            .Where(v => v.UserId == request.RequesterId && !v.IsConfirmed)
            .Include(v => v.User)
            .Include(v => v.Vacation)
            .AsNoTracking()
            .ToListAsync(cancellationToken);

        return invitations.Select(v => new InvitationResult(
            v.Id,
            new UserResult(v.User.Id, v.User.Username),
            new VacationResult(v.Vacation.Id, v.Vacation.Label, v.Vacation.Period.StartDate, v.Vacation.Period.EndDate, false))
        ).ToList();
    }
}
