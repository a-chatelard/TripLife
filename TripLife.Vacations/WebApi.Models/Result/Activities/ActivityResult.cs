namespace WebApi.Models.Result.Activities;
public class ActivityResult
{
    public Guid Id { get; }
    public string Label { get; }
    public string? Description { get; }
    public DateTime StartDate { get; }
    public DateTime EndDate { get; }
    public double? EstimatedPrice { get; }
    public AddressResult? Address { get; }

    public ActivityResult(Guid id, string label, string? description, DateTime startDate, DateTime endDate, double? estimatedPrice, AddressResult? address)
    {
        Id = id;
        Label = label;
        Description = description;
        StartDate = startDate;
        EndDate = endDate;
        EstimatedPrice = estimatedPrice;
        Address = address;
    }
}
