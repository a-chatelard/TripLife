using Application;
using Infrastructure.Extensions;
using TripLife.Foundation.WebApi.Extension;
using WebApi.Extensions;
using WebApi.Middlewares;

var builder = WebApplication.CreateBuilder(args);

var configuration = builder.Configuration;

// Add services to the container.

builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();

builder.Services.AddSwagger(configuration);

builder.Services.AddMediatR(options =>
{
    options.RegisterServicesFromAssembly(typeof(ApplicationEntryPoint).Assembly);
});

builder.Services.AddDatabaseModules(configuration);

builder.Services.AddKafkaConfiguration(configuration);

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment() || app.Environment.IsEnvironment("Local"))
{
    app.EnableSwagger();
}

app.UseAuthentication();
app.UseAuthorization();

app.UseMiddleware<ExceptionMiddleware>();

app.MapControllers();

app.Run();
