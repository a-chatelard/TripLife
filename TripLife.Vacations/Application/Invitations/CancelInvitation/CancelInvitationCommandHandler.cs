using Domain.Vacations;
using TripLife.Foundation.Domain.Exceptions;

namespace Application.Invitations.CancelInvitation;
public class CancelInvitationCommandHandler : IRequestHandler<CancelInvitationCommand>
{
    private readonly IVacationRepository _repository;

    public CancelInvitationCommandHandler(IVacationRepository repository)
    {
        _repository = repository;
    }

    public async Task Handle(CancelInvitationCommand request, CancellationToken cancellationToken)
    {
        var vacation = await _repository.GetVacationById(request.VacationId, cancellationToken)
            ?? throw new DomainException($"Les vacances n'ont pas été trouvées.");

        var owner = vacation.GetOwner();

        if (owner.UserId != request.RequesterId)
        {
            throw new DomainException("Accès non autorisé.");
        }

        var vacationer = vacation.GetVacationerById(request.VacationerId);

        vacation.RemoveVacationer(vacationer);

        await _repository.UpdateVacation(vacation, cancellationToken);
    }
}
