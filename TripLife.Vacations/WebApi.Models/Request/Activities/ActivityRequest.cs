using WebApi.Models.Common;

namespace WebApi.Models.Request.Activities;
public class ActivityRequest
{
    public string Label { get; set; }
    public string? Description { get; set; }
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    public double? EstimatedPrice { get; set; }
    public AddressRequest? Address { get; set; }
}
