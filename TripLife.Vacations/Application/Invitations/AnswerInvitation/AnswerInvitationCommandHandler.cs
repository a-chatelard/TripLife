using Domain.Vacations;
using TripLife.Foundation.Domain.Exceptions;

namespace Application.Invitations.AnswerInvitation;
public class AnswerInvitationCommandHandler : IRequestHandler<AnswerInvitationCommand>
{
    private readonly IVacationRepository _repository;

    public AnswerInvitationCommandHandler(IVacationRepository repository)
    {
        _repository = repository;
    }

    public async Task Handle(AnswerInvitationCommand request, CancellationToken cancellationToken)
    {
        var vacation = await _repository.GetVacationById(request.VacationId, cancellationToken)
            ?? throw new DomainException($"Les vacances n'ont pas été trouvées.");

        var vacationer = vacation.GetVacationerById(request.VacationerId);

        if (vacationer.UserId != request.RequesterId)
        {
            throw new DomainException("Accès non autorisé.");
        }

        if (request.Answer)
        {
            vacation.ConfirmVacationer(vacationer);
        } 
        else
        {
            vacation.CancelVacationer(vacationer);
        }

        await _repository.UpdateVacation(vacation, cancellationToken);
    }
}
