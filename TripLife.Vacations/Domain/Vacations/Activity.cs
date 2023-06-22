using FluentValidation;
using System.Collections.ObjectModel;
using TripLife.Foundation.Domain.Exceptions;

namespace Domain.Vacations;
public class Activity
{
    public Guid Id { get; }

    public Vacation Vacation { get; } = default!;
    public Guid VacationId { get; }

    public string Label { get; }
    public string? Description { get; }
    public Period Period { get; }
    public Price? EstimatedPrice { get; }
    public Address? Address { get; }

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

    public static Activity Create(Vacation vacation, string label, Period period, Price? estimatedPrice, Address? address, Vacationer owner)
    {
        var activity = new Activity(label, period, estimatedPrice, address);

        activity.AddParticipant(owner, true);

        var validationResult = new ActivityValidator(vacation).Validate(activity);
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
    public ActivityValidator(Vacation vacation)
    {
        RuleFor(v => v.Label).NotEmpty().WithMessage("Le libellé de l'activité ne peut être nul.");
        RuleFor(v => v.Period).NotEmpty().WithMessage("La période de l'activité ne peut être nulle.");
    }
}
