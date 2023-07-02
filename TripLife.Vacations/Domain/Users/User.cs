using FluentValidation;
using TripLife.Foundation.Domain.Exceptions;

namespace Domain.Users;
public class User
{
    public Guid Id { get; }
    public string? Username { get; }

    internal User() { }

    private User(Guid id, string? username)
    {
        Id = id;
        Username = username;
    }

    public static User Create(Guid userId, string? username)
    {
        var user = new User(userId, username);

        var validationResult = new UserValidator().Validate(user);
        if (!validationResult.IsValid)
        {
            throw new DomainValidationException(validationResult.Errors);
        }

        return user;
    }
}

public class UserValidator : AbstractValidator<User>
{
    public UserValidator()
    {
        RuleFor(u => u.Id).NotEmpty().WithMessage("L'ID d'un utilisateur ne peut être nul.");
    }
}
