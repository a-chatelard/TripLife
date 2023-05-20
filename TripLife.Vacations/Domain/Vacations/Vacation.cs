﻿using System.Collections.ObjectModel;
using TripLife.Foundation.Domain.Exceptions;

namespace Domain.Vacations;

public class Vacation
{
    public Guid Id { get; }

    public string Label { get; }
    public string Location { get; }

    public DateTime StartDate { get; private set; }
    public DateTime EndDate { get; private set; }

    public double? EstimatedBudget { get; private set; }

    public Address? Address { get; private set; }

    private readonly Collection<Activity> _activities = new();
    public IReadOnlyCollection<Activity> Activities { get => _activities; }

    internal Vacation() { }

    private Vacation(string label, string location)
    {
        Label = label;
        Location = location;
    }

    public static Vacation Create(string label, string location, DateTime startDate, DateTime endDate, double? estimatedBudget, string street, string city, string state, string country, string zipCode)
    {
        var vacation = new Vacation(label, location);

        vacation.UpdateDates(startDate, endDate);
        vacation.SetEstimatedBudget(estimatedBudget);
        vacation.SetAddress(street, city, state, country, zipCode);

        return vacation;
    }

    public void SetAddress(string street, string city, string state, string country, string zipCode)
    {
        Address = Address.Create(street, city, state, country, zipCode);
    }

    public void UpdateDates(DateTime startDate, DateTime endDate)
    {
        if (startDate >  endDate) 
        {
            throw new DomainException("La date de fin ne peut être supérieure à la date de début.");
        }

        StartDate = startDate;
        EndDate = endDate;
    }

    public void SetEstimatedBudget(double? estimatedBudget)
    {
        EstimatedBudget = estimatedBudget;
    }
}
