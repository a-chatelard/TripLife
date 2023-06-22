using WebApi.Models.Common;

namespace WebApi.Models.Request.Vacations;
public class VacationRequest
{
    public string Label { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    public AddressRequest? Address { get; set; }
    public double? EstimatedBudget { get; set; }

    public VacationRequest(string label, DateTime startDate, DateTime endDate, AddressRequest? address, double? estimatedBudget)
    {
        Label = label;
        StartDate = startDate;
        EndDate = endDate;
        Address = address;
        EstimatedBudget = estimatedBudget;
    }
}
