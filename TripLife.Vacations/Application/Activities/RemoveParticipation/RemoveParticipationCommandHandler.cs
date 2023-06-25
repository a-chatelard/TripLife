using Domain.Vacations;
using TripLife.Foundation.Domain.Exceptions;

namespace Application.Activities.RemoveParticipation;
public class RemoveParticipationCommandHandler : IRequestHandler<RemoveParticipationCommand>
{
    private readonly IVacationRepository _repository;

    public RemoveParticipationCommandHandler(IVacationRepository repository)
    {
        _repository = repository;
    }

    public async Task Handle(RemoveParticipationCommand request, CancellationToken cancellationToken)
    {
        var vacation = await _repository.GetVacationById(request.VacationId, cancellationToken)
            ?? throw new DomainException($"Les vacances n'ont pas été trouvées.");

        var activity = vacation.GetActivityById(request.ActivityId)
            ?? throw new DomainException($"L'activité n'a pas été trouvée.");

        var vacationer = vacation.GetVacationerByUserId(request.RequesterId);

        var participation = activity.GetParticipationByVacationerId(vacationer.Id);

        vacation.RemoveParticipantFromActivity(activity, participation);

        await _repository.UpdateVacation(vacation, cancellationToken);
    }
}
