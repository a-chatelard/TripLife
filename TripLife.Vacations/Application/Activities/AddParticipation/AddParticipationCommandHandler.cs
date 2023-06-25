using Domain.Vacations;
using TripLife.Foundation.Domain.Exceptions;

namespace Application.Activities.AddParticipation;
public class AddParticipationCommandHandler : IRequestHandler<AddParticipationCommand>
{
    private readonly IVacationRepository _repository;

    public AddParticipationCommandHandler(IVacationRepository repository)
    {
        _repository = repository;
    }

    public async Task Handle(AddParticipationCommand request, CancellationToken cancellationToken)
    {
        var vacation = await _repository.GetVacationById(request.VacationId, cancellationToken)
            ?? throw new DomainException($"Les vacances n'ont pas été trouvées.");
    
        var activity = vacation.GetActivityById(request.ActivityId)
            ?? throw new DomainException($"L'activité n'a pas été trouvée.");

        var vacationer = vacation.GetVacationerByUserId(request.RequesterId);

        vacation.AddParticipantToActivity(activity, vacationer);

        await _repository.UpdateVacation(vacation, cancellationToken);
    }
}
