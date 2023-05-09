using Domain.Users;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using WebApi.Models.Result.Auth;

namespace Application.Services;

public class JwtTokenService
{
    private readonly IConfiguration _configuration;

    public JwtTokenService(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    public LogInResult CreateToken(User user)
    {
        var token = CreateJwtToken(
            CreateClaims(user),
            CreateSigningCredentials()
        );

        var tokenHandler = new JwtSecurityTokenHandler();

        return new LogInResult(tokenHandler.WriteToken(token));
    }

    private JwtSecurityToken CreateJwtToken(Claim[] claims, SigningCredentials credentials) =>
        new JwtSecurityToken(
            _configuration["Jwt:Issuer"], 
            _configuration["Jwt:Audience"],
            claims,
            signingCredentials: credentials
        );

    private Claim[] CreateClaims(User user) =>
        new[] {
            new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
            new Claim(JwtRegisteredClaimNames.Iat, DateTime.UtcNow.ToString()),
            new Claim(ClaimTypes.NameIdentifier, user.Id.ToString()),
            new Claim(ClaimTypes.Name, user.UserName),
            new Claim(ClaimTypes.Email, user.Email)
        };

    private SigningCredentials CreateSigningCredentials() =>
        new SigningCredentials(
            new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(_configuration["Jwt:Key"])
            ),
            SecurityAlgorithms.HmacSha256
        );
}
