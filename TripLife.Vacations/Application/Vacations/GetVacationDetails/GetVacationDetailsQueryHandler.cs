using Infrastructure.Context;
using Microsoft.EntityFrameworkCore;
using TripLife.Foundation.Domain.Exceptions;
using WebApi.Models.Result;
using WebApi.Models.Result.Vacations;

namespace Application.Vacations.GetVacationDetails;
public class GetVacationDetailsQueryHandler : IRequestHandler<GetVacationDetailsQuery, VacationDetailsResult>
{
    private readonly ApplicationDbContext _context;

    public GetVacationDetailsQueryHandler(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<VacationDetailsResult> Handle(GetVacationDetailsQuery request, CancellationToken cancellationToken)
    {
        var vacation = await _context.Vacations
            .Include(v => v.Vacationers)
            .AsNoTracking()
            .Where(v => v.Vacationers.Any(v => v.UserId == request.RequesterId && v.IsConfirmed))
            .SingleOrDefaultAsync(v => v.Id == request.VacationId, cancellationToken)
            ?? throw new DomainException("Vacances non trouvées.");

        var address = vacation.Address != null
            ? new AddressResult(vacation.Address.Street, vacation.Address.City, vacation.Address.State, vacation.Address.Country, vacation.Address.ZipCode)
            : null;

        var result = new VacationDetailsResult(
            vacation.Id,
            vacation.Label,
            vacation.Period.StartDate,
            vacation.Period.EndDate,
            vacation.EstimatedBudget?.Amount,
            address,
            vacation.Vacationers.First(v => v.UserId == request.RequesterId).IsOwner
            );

        return result;
    }
}

