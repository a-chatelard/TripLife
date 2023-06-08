using Microsoft.AspNetCore.Http;
using System.Security.Claims;

namespace TripLife.Foundation.WebApi.Extension;

public static class HttpContextExtension
{
    public static ClaimsIdentity GetClaimsIdentity(this HttpContext httpContext)
    {
        ClaimsIdentity? claims = httpContext.User.Identity as ClaimsIdentity;

        return claims ?? throw new UnauthorizedAccessException("Vous devez être connecté pour effectuer cette requête.");
    }

    public static Guid GetRequesterId(this HttpContext httpContext)
    {
        var claims = httpContext.GetClaimsIdentity();
        var requesterIdClaim = claims.FindFirst(ClaimTypes.NameIdentifier);

        if (requesterIdClaim == null)
        {
            throw new UnauthorizedAccessException("Vous devez être connecté pour effectuer cette requête.");
        }

        var requesterId = requesterIdClaim!.Value;

        if (Guid.TryParse(requesterId, out Guid requesterIdParsed))
        {
            return requesterIdParsed;
        }
        else
        {
            throw new UnauthorizedAccessException("Vous devez être connecté pour effectuer cette requête.");
        }
    }
}
