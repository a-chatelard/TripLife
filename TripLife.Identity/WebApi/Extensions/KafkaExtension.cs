using Application.Auth.Events;
using TripLife.Foundation.Kafka.Settings;
using WebApi.Producers.UserCreated;

namespace WebApi.Extensions;

public static class KafkaExtension
{
    public static IServiceCollection AddKafkaConfiguration(this IServiceCollection services, IConfiguration configuration)
    {
        var kafkaSection = configuration.GetSection("Kafka");

        services.Configure<KafkaSettings>(kafkaSection);

        services.Configure<UserCreatedProducerSettings>(kafkaSection.GetSection("UserCreated"));
        services.AddScoped<IUserCreatedEmitter, UserCreatedEmitter>();

        //services.Configure<UserDeletedProducerSettings>(kafkaSection.GetSection("UserDeleted"));

        return services;
    }
}