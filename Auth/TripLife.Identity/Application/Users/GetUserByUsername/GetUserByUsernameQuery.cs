using WebApi.Models.Result.Users;

namespace Application.Users.GetUserByUsername;
public record GetUserByUsernameQuery(string Username): IRequest<UserResult?>;
