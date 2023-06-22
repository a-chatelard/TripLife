using Domain.Vacations;
using Infrastructure.Context;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Infrastructure.Mappings;
public class VacationerMapping : IEntityTypeConfiguration<Vacationer>
{
    public void Configure(EntityTypeBuilder<Vacationer> builder)
    {
        builder.ToTable(nameof(ApplicationDbContext.Vacationers));
    
        builder.HasKey(v => v.Id);

        builder.HasOne(v => v.Vacation).WithMany(v => v.Vacationers).HasForeignKey(v => v.VacationId);
        builder.HasOne(v => v.User).WithMany().HasForeignKey(v => v.UserId);
    }
}
