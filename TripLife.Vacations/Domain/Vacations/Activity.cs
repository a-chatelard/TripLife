using FluentValidation;
using System.Collections.ObjectModel;
using TripLife.Foundation.Domain.Exceptions;

namespace Domain.Vacations;
public class Activity
{
    public Guid Id { get; }

    public Vacation Vacation { get; } = default!;
    public Guid VacationId { get; }

    public string Label { get; private set; }
    public string? Description { get; private set; }
    public Period Period { get; private set; }
    public Price? EstimatedPrice { get; private set; }
    public Address? Address { get; private set; }

    private readonly Collection<Participation> _participations = new();
    public IReadOnlyCollection<Participation> Participations { get => _participations; }

    internal Activity() { }

    private Activity(string label, Period period, Price? estimatedPrice, Address? address)
    {
        Label = label;
        Period = period;
        EstimatedPrice = estimatedPrice;
        Address = address;
    }

    public static Activity Create(string label, Period period, Price? estimatedPrice, Address? address, Vacationer owner)
    {
        var activity = new Activity(label, period, estimatedPrice, address);

        activity.AddParticipant(owner, true);

        var validationResult = new ActivityValidator().Validate(activity);
        if (!validationResult.IsValid)
        {
            throw new DomainValidationException(validationResult.Errors);
        }


        return activity;
    }

    public void AddParticipant(Vacationer vacationer, bool isOwner = false)
    {
        if (Participations.Any(p => p.VacationerId == vacationer.Id))
        {
            throw new DomainException("Ce participant participe déjà à cette activité.");
        }

        _participations.Add(Participation.Create(vacationer, isOwner));
    }

    public void RemoveParticipation(Participation participation)
    {
        _participations.Remove(participation);
    }
}

public class ActivityValidator : AbstractValidator<Activity>
{
    public ActivityValidator()
    {
        RuleFor(v => v.Label).NotEmpty().WithMessage("Le libellé de l'activité ne peut être nul.");
        RuleFor(v => v.Period).NotEmpty().WithMessage("La période de l'activité ne peut être nulle.");
    }
}
