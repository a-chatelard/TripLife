﻿using Domain.Vacations;
using Infrastructure.Context;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Newtonsoft.Json;

namespace Infrastructure.Mappings;

public class VacationMapping : IEntityTypeConfiguration<Vacation>
{
    public void Configure(EntityTypeBuilder<Vacation> builder)
    {
        builder.ToTable(nameof(ApplicationDbContext.Vacations));

        builder.HasKey(v => v.Id);

        builder.HasMany(v => v.Activities).WithOne(a => a.Vacation).HasForeignKey(a => a.VacationId);

        builder.Property(v => v.Address).HasConversion(
            address => JsonConvert.SerializeObject(address, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }),
            address => JsonConvert.DeserializeObject<Address>(address, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore })
        );

        builder.OwnsOne(v => v.Period).Property(p => p.StartDate).HasColumnName(nameof(Period.StartDate));
        builder.OwnsOne(v => v.Period).Property(p => p.EndDate).HasColumnName(nameof(Period.EndDate));

        builder.OwnsOne(v => v.EstimatedBudget).Property(p => p.Amount).HasColumnName(nameof(Vacation.EstimatedBudget));
    }
}
