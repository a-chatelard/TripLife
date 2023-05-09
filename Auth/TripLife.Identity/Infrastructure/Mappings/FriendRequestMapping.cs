using Domain.Users;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;

namespace Infrastructure.Mappings
{
    public class FriendRequestMapping : IEntityTypeConfiguration<FriendRequest>
    {
        public void Configure(EntityTypeBuilder<FriendRequest> builder)
        {
            builder.HasKey(f => f.Id);

            builder.HasOne(fr => fr.Sender).WithMany().HasForeignKey(fr => fr.SenderId);
            builder.HasOne(fr => fr.Recipient).WithMany().HasForeignKey(fr => fr.RecipientId);
        }
    }
}
