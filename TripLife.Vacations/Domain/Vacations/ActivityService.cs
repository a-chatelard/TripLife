using TripLife.Foundation.Domain.Exceptions;

namespace Domain.Vacations;
public static class ActivityService
{
    public static Participation GetParticipationByVacationerId(this Activity activity, Guid vacationerId)
    {
        return activity.Participations.FirstOrDefault(p => p.VacationerId == vacationerId)
            ?? throw new DomainException($"Le vacancier d'ID {vacationerId} ne participe pas à cette activité.");
    }
}
