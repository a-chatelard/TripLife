using Domain.Vacations;
using TripLife.Foundation.Domain.Exceptions;

namespace Application.Vacations.DeleteVacation;
public class DeleteVacationCommandHandler : IRequestHandler<DeleteVacationCommand>
{
    private readonly IVacationRepository _repository;

    public DeleteVacationCommandHandler(IVacationRepository repository)
    {
        _repository = repository;
    }

    public async Task Handle(DeleteVacationCommand request, CancellationToken cancellationToken)
    {
        var vacation = await _repository.GetVacationById(request.VacationId, cancellationToken)
            ?? throw new DomainException($"Les vacances n'ont pas été trouvées.");

        var owner = vacation.Vacationers.FirstOrDefault(v => v.IsOwner)
            ?? throw new DomainException("Organisateur des vacances non trouvé.");

        if (owner.UserId != request.RequesterId)
        {
            throw new DomainException("Seul l'organisateur des vacances peut les supprimer.");
        }

        await _repository.DeleteVacation(vacation, cancellationToken);
    }
}
