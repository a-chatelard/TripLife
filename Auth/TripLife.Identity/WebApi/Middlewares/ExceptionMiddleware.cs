﻿using Application.Exceptions;
using Domain.Exceptions;
using System.Net;

namespace WebApi.Middlewares
{
    public class ExceptionMiddleware
    {
        private readonly RequestDelegate _next;
        private readonly ILogger<ExceptionMiddleware> _logger;

        public ExceptionMiddleware(RequestDelegate next, ILogger<ExceptionMiddleware> logger)
        {
            _logger = logger;
            _next = next;
        }

        public async Task InvokeAsync(HttpContext httpContext)
        {
            try
            {
                await _next(httpContext);
            }
            catch (Exception ex)
            {
                httpContext.Response.ContentType = "application/json";

                switch (ex)
                {
                    case DomainException:
                        httpContext.Response.StatusCode = (int)HttpStatusCode.BadRequest; 
                        break;
                    case UnauthorizedAccessException:
                    case AuthException:
                        httpContext.Response.StatusCode = (int)HttpStatusCode.Unauthorized;
                        break;
                    default:
                        httpContext.Response.StatusCode = (int)HttpStatusCode.InternalServerError;  
                        break;
                }
                _logger.LogError($"Something went wrong: {ex}");

                var errorDetails = new ErrorDetails(httpContext.Response.StatusCode, ex.Message);
                await httpContext.Response.WriteAsync(errorDetails.ToString());
            }
        }
    }
}
