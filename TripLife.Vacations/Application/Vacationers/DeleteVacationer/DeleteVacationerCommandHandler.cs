using Domain.Vacations;
using TripLife.Foundation.Domain.Exceptions;

namespace Application.Vacationers.DeleteVacationer;
public class DeleteVacationerCommandHandler : IRequestHandler<DeleteVacationerCommand>
{
    private readonly IVacationRepository _repository;

    public DeleteVacationerCommandHandler(IVacationRepository repository)
    {
        _repository = repository;
    }

    public async Task Handle(DeleteVacationerCommand request, CancellationToken cancellationToken)
    {
        var vacation = await _repository.GetVacationById(request.VacationId, cancellationToken)
            ?? throw new DomainException($"Les vacances n'ont pas été trouvées.");

        var vacationer = vacation.GetVacationerById(request.VacationerId);

        vacation.RemoveVacationer(vacationer);

        await _repository.UpdateVacation(vacation, cancellationToken);
    }
}
