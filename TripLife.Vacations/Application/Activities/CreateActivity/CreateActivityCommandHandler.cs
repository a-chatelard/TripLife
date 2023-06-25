using Domain.Vacations;
using TripLife.Foundation.Domain.Exceptions;

namespace Application.Activities.CreateActivity;
public class CreateActivityCommandHandler : IRequestHandler<CreateActivityCommand, Guid>
{
    private readonly IVacationRepository _repository;

    public CreateActivityCommandHandler(IVacationRepository repository)
    {
        _repository = repository;
    }
    
    public async Task<Guid> Handle(CreateActivityCommand request, CancellationToken cancellationToken)
    {
        var vacation = await _repository.GetVacationById(request.VacationId, cancellationToken)
            ?? throw new DomainException($"Les vacances n'ont pas été trouvées.");

        var vacationer = vacation.Vacationers.SingleOrDefault(v => v.UserId == request.RequesterId)
            ?? throw new DomainException("Accès non autorisé.");

        var period = Period.Create(request.Activity.StartDate, request.Activity.EndDate);

        Price? estimatedPrice = null;
        if (request.Activity.EstimatedPrice.HasValue)
        {
            estimatedPrice = Price.Create(request.Activity.EstimatedPrice.Value);
        }

        Address? address = null;
        if (request.Activity.Address != null)
        {
            address = Address.Create(request.Activity.Address.Street, request.Activity.Address.City, request.Activity.Address.State, request.Activity.Address.Country, request.Activity.Address.ZipCode);
        }

        var activity = Activity.Create(request.Activity.Label, period, estimatedPrice, address, vacationer);

        vacation.ProposeActivity(activity);

        await _repository.UpdateVacation(vacation, cancellationToken);

        return activity.Id;
    }
}
