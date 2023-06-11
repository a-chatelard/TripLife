using Domain.Exceptions;
using FluentValidation;
using TripLife.Foundation.Domain.BuildingBlocks;

namespace Domain.Vacations;
public class VacationPeriod : ValueObject
{
    public DateTime StartDate { get; }
    public DateTime EndDate { get; }

    internal VacationPeriod() { }
    private VacationPeriod(DateTime startDate, DateTime endDate)
    {
        StartDate = startDate;
        EndDate = endDate;
    }
    public static VacationPeriod Create(DateTime startDate, DateTime endDate)
    {
        var period = new VacationPeriod(startDate, endDate);

        var validationResult = new PeriodValidator().Validate(period);
        if (!validationResult.IsValid)
        {
            throw new DomainValidationException(validationResult.Errors);
        }

        return period;
    }
    protected override IEnumerable<object> GetEqualityComponents()
    {
        yield return StartDate;
        yield return EndDate;
    }
}

public class PeriodValidator : AbstractValidator<VacationPeriod>
{
    public PeriodValidator()
    {
        RuleFor(p => p.StartDate).NotEmpty().WithMessage("La date de début des vacances ne peut être nulle.");
        RuleFor(p => p.EndDate).NotEmpty().WithMessage("La date de fin des vacances ne peut être nulle");
        RuleFor(p => p.StartDate).LessThanOrEqualTo(p => p.EndDate).WithMessage("La date de début doit être inférieure ou égale à la date de fin.");
    }
}
