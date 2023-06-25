using Domain.Users;
using FluentValidation;
using System.Collections.ObjectModel;
using TripLife.Foundation.Domain.Exceptions;

namespace Domain.Vacations;

public class Vacation
{
    public Guid Id { get; }

    public string Label { get; private set; }

    public Period Period { get; private set; }

    public Price? EstimatedBudget { get; private set; }

    public Address? Address { get; private set; }

    private readonly Collection<Activity> _activities = new();
    public IReadOnlyCollection<Activity> Activities { get => _activities; }

    private readonly Collection<Vacationer> _vacationers = new();
    public IReadOnlyCollection<Vacationer> Vacationers { get => _vacationers; }

    internal Vacation() { }

    private Vacation(string label, Period period, Price? estimatedBudget, Address? address)
    {
        Label = label;
        Period = period;
        EstimatedBudget = estimatedBudget;
        Address = address;
    }

    public static Vacation Create(
        string label,
        Period period,
        Price? estimatedBudget,
        Address? address,
        User owner)
    {
        var vacation = new Vacation(label, period, estimatedBudget, address);

        vacation.AddVacationer(owner, true);

        var validationResult = new VacationValidator().Validate(vacation);
        if (!validationResult.IsValid)
        {
            throw new DomainValidationException(validationResult.Errors);
        }

        return vacation;
    }

    public Vacationer AddVacationer(User user, bool isOwner = false)
    {
        if (Vacationers.Any(v => v.UserId == user.Id))
        {
            throw new DomainException("Cet utilisateur participe déjà à ces vacances.");
        }

        var vacationer = Vacationer.Create(user, isOwner);

        _vacationers.Add(vacationer);

        return vacationer;
    }

    public void RemoveVacationer(Vacationer vacationer)
    {
        if (vacationer.IsOwner)
        {
            throw new DomainException("Vous ne pouvez pas supprimer le propriétaire des vacances.");
        }

        _vacationers.Remove(vacationer);
    }

    public void ConfirmVacationer(Vacationer vacationer)
    {
        if (vacationer.IsConfirmed)
        {
            throw new DomainException("Le vacancier a déjà confirmé sa participation aux vacances.");
        }

        vacationer.Confirm();
    }

    public void CancelVacationer(Vacationer vacationer)
    {
        if (vacationer.IsConfirmed)
        {
            throw new DomainException("Le vacancier a déjà confirmé sa participation aux vacances.");
        }

        _vacationers.Remove(vacationer);
    }

    public void ProposeActivity(Activity activity)
    {
        if (activity.Period.IsIncludedIn(Period))
        {
            throw new DomainException("La période de l'activité doit être incluse dans la période des vacances.");
        }

        _activities.Add(activity);
    } 

    public void RemoveActivity(Activity activity)
    {
        _activities.Remove(activity);
    }

    public void AddParticipantToActivity(Activity activity, Vacationer vacationer)
    {
        activity.AddParticipant(vacationer);
    }

    public void RemoveParticipantFromActivity(Activity activity, Participation participation)
    {
        activity.RemoveParticipation(participation);
    }
}

public class VacationValidator : AbstractValidator<Vacation>
{
    public VacationValidator()
    {
        RuleFor(v => v.Label).NotEmpty().WithMessage("Le libellé des vacances ne peut être nul.");
        RuleFor(v => v.Period).NotEmpty().WithMessage("La période des vacances ne peut être nulle.");
        RuleFor(v => v.Vacationers).Must((vacation, vacationers) =>
        {
            return vacationers.Any(v => v.IsOwner);
        }).WithMessage("Les vacances doivent obligatoirement comprendre un organisateur.");
    }
}