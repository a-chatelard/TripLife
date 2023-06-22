using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WebApi.Models.Result.Vacations;
public class VacationResult
{
    public Guid Id { get; }
    public string Label { get; }
    public DateTime StartDate { get; }
    public DateTime EndDate { get; }

    public VacationResult(Guid id, string label, DateTime startDate, DateTime endDate)
    {
        Id = id;
        Label = label;
        StartDate = startDate;
        EndDate = endDate;
    }
}
