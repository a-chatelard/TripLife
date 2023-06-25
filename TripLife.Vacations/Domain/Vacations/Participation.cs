using FluentValidation;
using TripLife.Foundation.Domain.Exceptions;

namespace Domain.Vacations;

public class Participation
{
    public Guid Id { get; }
    
    public Activity Activity { get; } = default!;
    public Guid ActivityId { get; }

    public Vacationer Vacationer { get; } = default!;
    public Guid VacationerId { get; }
    
    public bool IsOwner { get; private set; }

    internal Participation() { }
    
    private Participation(Vacationer vacationer, bool isOwner)
    {
        Vacationer = vacationer;
        VacationerId = vacationer.Id;
        IsOwner = isOwner;
    }

    public static Participation Create(Vacationer vacationer, bool isOwner = false)
    {
        var participation = new Participation(vacationer, isOwner);
        var validationResult = new ParticipationValidator().Validate(participation);
        if (!validationResult.IsValid)
        {
            throw new DomainValidationException(validationResult.Errors);
        }
        return participation;
    }
}

public class ParticipationValidator : AbstractValidator<Participation>
{
    public ParticipationValidator()
    {
        RuleFor(p => p.Vacationer).NotNull().WithMessage("Le participant ne peut être nul.");
    }
}