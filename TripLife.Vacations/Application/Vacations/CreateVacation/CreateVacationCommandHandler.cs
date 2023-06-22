using Domain.Users;
using Domain.Vacations;
using TripLife.Foundation.Domain.Exceptions;

namespace Application.Vacations.CreateVacation;

public class CreateVacationCommandHandler : IRequestHandler<CreateVacationCommand, Guid>
{
    private readonly IUserRepository _userRepository;
    private readonly IVacationRepository _vacationRepository;

    public CreateVacationCommandHandler(IUserRepository userRepository, IVacationRepository vacationRepository)
    {
        _userRepository = userRepository;
        _vacationRepository = vacationRepository;
    }

    public async Task<Guid> Handle(CreateVacationCommand request, CancellationToken cancellationToken)
    {
        var requester = await _userRepository.GetUserById(request.RequesterId, cancellationToken)
            ?? throw new DomainException("Utilisateur non existant.");

        var period = Period.Create(request.Vacation.StartDate, request.Vacation.EndDate);

        Price? estimatedBudget = null;
        if (request.Vacation.EstimatedBudget != null)
        {
            estimatedBudget = Price.Create(request.Vacation.EstimatedBudget.Value);
        }

        Address? address = null;
        if (request.Vacation.Address != null)
        {
            address = Address.Create(
                request.Vacation.Address.Street, 
                request.Vacation.Address.City, 
                request.Vacation.Address.State, 
                request.Vacation.Address.Country, 
                request.Vacation.Address.ZipCode);
        }

        var vacation = Vacation.Create(request.Vacation.Label, period, estimatedBudget, address, requester);

        var result = await _vacationRepository.CreateVacation(vacation, cancellationToken);

        return result;
    }
}
