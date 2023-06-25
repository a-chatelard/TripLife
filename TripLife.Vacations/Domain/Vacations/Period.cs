using FluentValidation;
using TripLife.Foundation.Domain.BuildingBlocks;
using TripLife.Foundation.Domain.Exceptions;

namespace Domain.Vacations;
public class Period : ValueObject
{
    public DateTime StartDate { get; }
    public DateTime EndDate { get; }

    internal Period() { }
    private Period(DateTime startDate, DateTime endDate)
    {
        StartDate = startDate;
        EndDate = endDate;
    }
    public static Period Create(DateTime startDate, DateTime endDate)
    {
        var period = new Period(startDate, endDate);

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

    public bool IsIncludedIn(Period period)
    {
        return StartDate >= period.StartDate && EndDate <= period.EndDate;
    }
}

public class PeriodValidator : AbstractValidator<Period>
{
    public PeriodValidator()
    {
        RuleFor(p => p.StartDate).NotEmpty().WithMessage("La date de début ne peut être nulle.");
        RuleFor(p => p.EndDate).NotEmpty().WithMessage("La date de fin ne peut être nulle");
        RuleFor(p => p.StartDate).LessThanOrEqualTo(p => p.EndDate).WithMessage("La date de début doit être inférieure ou égale à la date de fin.");
    }
}
