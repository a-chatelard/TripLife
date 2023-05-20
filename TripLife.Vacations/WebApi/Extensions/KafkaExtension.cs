using WebApi.Consumers.UserCreated;
using WebApi.Settings;

namespace WebApi.Extensions;

public static class KafkaExtension
{
    public static IServiceCollection AddKafkaConfiguration(this IServiceCollection services, IConfiguration configuration)
    {
        var kafkaSection = configuration.GetSection("Kafka");

        services.Configure<KafkaSettings>(kafkaSection);

        services.Configure<UserCreatedConsumerSettings>(kafkaSection.GetSection("UserCreated"));
        services.AddSingleton<IHostedService, UserCreatedConsumer>();

        return services;
    }
}
