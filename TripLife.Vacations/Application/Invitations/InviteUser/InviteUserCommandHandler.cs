using Domain.Users;
using Domain.Vacations;
using TripLife.Foundation.Domain.Exceptions;

namespace Application.Invitations.InviteUser;
public class InviteUserCommandHandler : IRequestHandler<InviteUserCommand, Guid>
{
    private readonly IVacationRepository _vacationRepository;

    private readonly IUserRepository _userRepository;

    public InviteUserCommandHandler(IVacationRepository vacationRepository, IUserRepository userRepository)
    {
        _vacationRepository = vacationRepository;
        _userRepository = userRepository;
    }

    public async Task<Guid> Handle(InviteUserCommand request, CancellationToken cancellationToken)
    {
        var vacation = await _vacationRepository.GetVacationById(request.VacationId, cancellationToken)
            ?? throw new DomainException($"Les vacances n'ont pas été trouvées.");

        var owner = vacation.GetOwner();
        if (owner.UserId != request.RequesterId)
        {
            throw new DomainException("Accès non autorisé.");
        }

        var user = await _userRepository.GetUserById(request.UserId, cancellationToken)
            ?? throw new DomainException($"L'utilisateur n'a pas été trouvé.");

        var vacationer = vacation.AddVacationer(user);

        await _vacationRepository.UpdateVacation(vacation, cancellationToken);

        return vacationer.Id;
    }
}
