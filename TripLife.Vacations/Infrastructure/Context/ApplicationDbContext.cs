using Domain.Users;
using Domain.Vacations;
using Microsoft.EntityFrameworkCore;
using System.Reflection;

namespace Infrastructure.Context;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
    {
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());

        base.OnModelCreating(modelBuilder);
    }

    public DbSet<User> Users { get; set; }

    public DbSet<Vacation> Vacations { get; set; }

    public DbSet<Vacationer> Vacationers { get; set; }

    public DbSet<Activity> Activities { get; set; }

    public DbSet<Participation> Participations { get; set; }
}
