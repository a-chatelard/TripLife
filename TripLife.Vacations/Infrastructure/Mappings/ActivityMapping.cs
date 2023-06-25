using Domain.Vacations;
using Infrastructure.Context;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Newtonsoft.Json;

namespace Infrastructure.Mappings;
public class ActivityMapping : IEntityTypeConfiguration<Activity>
{
    public void Configure(EntityTypeBuilder<Activity> builder)
    {
        builder.ToTable(nameof(ApplicationDbContext.Activities));
        
        builder.HasKey(a => a.Id);

        builder.HasMany(a => a.Participations).WithOne(p => p.Activity).HasForeignKey(p => p.ActivityId);

        builder.Property(a => a.Address).HasConversion(
            address => JsonConvert.SerializeObject(address, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }),
            address => JsonConvert.DeserializeObject<Address>(address, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore })
        );

        builder.OwnsOne(a => a.Period).Property(p => p.StartDate).HasColumnName(nameof(Period.StartDate));
        builder.OwnsOne(a => a.Period).Property(p => p.EndDate).HasColumnName(nameof(Period.EndDate));

        builder.OwnsOne(a => a.EstimatedPrice).Property(p => p.Amount).HasColumnName(nameof(Activity.EstimatedPrice));
    }
}
