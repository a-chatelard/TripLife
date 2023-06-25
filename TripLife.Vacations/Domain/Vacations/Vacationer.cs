using Domain.Users;
using FluentValidation;
using TripLife.Foundation.Domain.Exceptions;

namespace Domain.Vacations;
public class Vacationer
{
    public Guid Id { get; }

    public Vacation Vacation { get; } = default!;
    public Guid VacationId { get; }

    public User User { get; } = default!;
    public Guid UserId { get; }

    public bool IsOwner { get; private set; }
    public bool IsConfirmed { get; private set; }

    internal Vacationer() { }

    private Vacationer(User user, bool isOwner)
    {
        User = user;
        IsOwner = isOwner;
        IsConfirmed = false;
    }

    public static Vacationer Create(User user, bool isOwner)
    {
        var vacationer = new Vacationer(user, isOwner);

        var validationResult = new VacationerValidator().Validate(vacationer);
        if (!validationResult.IsValid)
        {
            throw new DomainValidationException(validationResult.Errors);
        }

        return vacationer;
    }

    public void Confirm()
    {
        IsConfirmed = true;
    }
}

public class VacationerValidator : AbstractValidator<Vacationer>
{
    public VacationerValidator()
    {
        RuleFor(v => v.User).NotEmpty().WithMessage("L'utilisateur participant à des vacances ne peut pas être nul.");
    }
}