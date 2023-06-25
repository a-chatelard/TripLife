using Domain.Vacations;

namespace WebApi.Models.Result.Vacations;
public class VacationDetailsResult : VacationResult
{
    public double? EstimatedBudget { get; }
    public AddressResult? Address { get; }

    public VacationDetailsResult(Guid id, string label, DateTime startDate, DateTime endDate, double? estimatedBudget, AddressResult? address) : base(id, label, startDate, endDate)
    {
        EstimatedBudget = estimatedBudget;
        Address = address;
    }
}