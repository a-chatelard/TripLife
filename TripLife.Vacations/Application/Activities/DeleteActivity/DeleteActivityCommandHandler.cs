using Domain.Vacations;
using TripLife.Foundation.Domain.Exceptions;

namespace Application.Activities.DeleteActivity;
public class DeleteActivityCommandHandler : IRequestHandler<DeleteActivityCommand>
{
    private readonly IVacationRepository _repository;

    public DeleteActivityCommandHandler(IVacationRepository repository)
    {
        _repository = repository;
    }

    public async Task Handle(DeleteActivityCommand request, CancellationToken cancellationToken)
    {
        var vacation = await _repository.GetVacationById(request.VacationId, cancellationToken)
            ?? throw new DomainException($"Les vacances n'ont pas été trouvées.");

        var activity = vacation.GetActivityById(request.ActivityId);

        if (request.RequesterId != vacation.GetOwner().Id && request.RequesterId != activity.GetOwner().Vacationer.UserId)
        {
            throw new DomainException("Seuls l'organisateur des vacances ou de l'activité peuvent la supprimer.");
        }

        vacation.RemoveActivity(activity);

        await _repository.UpdateVacation(vacation, cancellationToken);
    }
}
