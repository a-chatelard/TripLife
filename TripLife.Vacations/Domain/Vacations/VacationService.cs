using TripLife.Foundation.Domain.Exceptions;

namespace Domain.Vacations;
public static class VacationService
{
    public static Activity GetActivityById(this Vacation vacation, Guid activityId)
    {
        return vacation.Activities.FirstOrDefault(a => a.Id == activityId)
            ?? throw new DomainException($"L'activité d'ID {activityId} n'existe pas au sein de ces vacances.");
    }

    public static Vacationer GetOwner(this Vacation vacation)
    {
        return vacation.Vacationers.Single(v => v.IsOwner);
    }

    public static Participation GetOwner(this Activity activity)
    {
        return activity.Participations.Single(v => v.IsOwner);
    }

    public static Vacationer GetVacationerById(this Vacation vacation, Guid vacationerId)
    {
        return vacation.Vacationers.FirstOrDefault(v => v.Id == vacationerId)
            ?? throw new DomainException($"Le participant d'ID {vacationerId} n'existe pas au sein de ces vacances.");
    }

    public static Vacationer GetVacationerByUserId(this Vacation vacation, Guid userId)
    {
        return vacation.Vacationers.SingleOrDefault(v => v.UserId == userId)
            ?? throw new DomainException("Aucun participant n'a été trouvé avec cet identifiant.");
    }

    public static Participation GetParticipationById(this Vacation vacation, Guid participationId)
    {
        return vacation.Activities.SelectMany(a => a.Participations).FirstOrDefault(p => p.Id == participationId)
            ?? throw new DomainException($"La participation d'ID {participationId} n'existe pas au sein de ces vacances.");
    }
}
