using Domain.Users;
using Infrastructure.Context;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infrastructure.Mappings
{
    public class FriendshipMapping : IEntityTypeConfiguration<Friendship>
    {
        public void Configure(EntityTypeBuilder<Friendship> builder)
        {
            builder.ToTable(nameof(ApplicationDbContext.Friendships));

            builder.HasKey(f => f.Id);

            builder.HasOne(fr => fr.User).WithMany(u => u.SentFriendships).HasForeignKey(fr => fr.UserId);
            builder.HasOne(fr => fr.Friend).WithMany(u => u.ReceivedFriendships).HasForeignKey(fr => fr.FriendId);
        }
    }
}
