using Domain.Vacations;

namespace WebApi.Models.Result.Vacations;
public class VacationDetailsResult : VacationResult
{
    public double? EstimatedBudget { get; }
    public AddressResult? Address { get; }

    public VacationDetailsResult(Guid id, string label, DateTime startDate, DateTime endDate, double? estimatedBudget, AddressResult? address, bool isOwner) : base(id, label, startDate, endDate, isOwner)
    {
        EstimatedBudget = estimatedBudget;
        Address = address;
    }
}