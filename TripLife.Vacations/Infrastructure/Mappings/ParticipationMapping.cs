using Domain.Vacations;
using Infrastructure.Context;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infrastructure.Mappings;
public class ParticipationMapping : IEntityTypeConfiguration<Participation>
{
    public void Configure(EntityTypeBuilder<Participation> builder)
    {
        builder.ToTable(nameof(ApplicationDbContext.Participations));
        
        builder.HasKey(p => p.Id);

        builder.HasOne(p => p.Activity).WithMany(a => a.Participations).HasForeignKey(p => p.ActivityId);

        builder.HasOne(p => p.Vacationer).WithMany().HasForeignKey(p => p.VacationerId);
    }
}
