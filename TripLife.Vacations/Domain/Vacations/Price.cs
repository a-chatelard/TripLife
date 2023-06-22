using FluentValidation;
using TripLife.Foundation.Domain.BuildingBlocks;
using TripLife.Foundation.Domain.Exceptions;

namespace Domain.Vacations;
public class Price : ValueObject
{
    public double Amount { get; }

    private Price(double amount)
    {
        Amount = amount;
    }

    public static Price Create(double amount)
    {
        var price = new Price(amount);

        var validationResult = new PriceValidator().Validate(price);
        if (!validationResult.IsValid)
        {
            throw new DomainValidationException(validationResult.Errors);
        }

        return price;
    }

    protected override IEnumerable<object> GetEqualityComponents()
    {
        yield return Amount;
    }
}

public class PriceValidator : AbstractValidator<Price>
{
    public PriceValidator()
    {
        RuleFor(p => p.Amount)
            .NotNull().WithMessage("La valeur du prix ne peut être nulle.")
            .GreaterThanOrEqualTo(0).WithMessage("La valeur du prix doit être supérieure à 0.");
    }
}
