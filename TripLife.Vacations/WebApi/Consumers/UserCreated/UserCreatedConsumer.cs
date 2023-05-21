using Application.Users.Events.UserCreated;
using MediatR;
using Microsoft.Extensions.Options;
using TripLife.Foundation.Kafka.Consumers;
using TripLife.Foundation.Kafka.Settings;

namespace WebApi.Consumers.UserCreated;

public class UserCreatedConsumer : BackgroundService
{
    private readonly KafkaSettings _kafkaSettings;
    private readonly UserCreatedConsumerSettings _consumerSettings;
    private readonly ILogger<UserCreatedConsumer> _logger;
    private readonly IMediator _mediator;

    public UserCreatedConsumer(
        IOptions<KafkaSettings> kafkaSettings,
        IOptions<UserCreatedConsumerSettings> consumerSettings,
        ILogger<UserCreatedConsumer> logger,
        IMediator mediator)
    {
        _kafkaSettings = kafkaSettings.Value;
        _consumerSettings = consumerSettings.Value;
        _logger = logger;
        _mediator = mediator;
    }

    protected override Task ExecuteAsync(CancellationToken stoppingToken)
    {
        Task.Run(async () =>
        {
            await Task.Delay(5000);
            var consumer = new KafkaConsumer<UserCreatedEvent>(_kafkaSettings, _consumerSettings, _logger, _mediator);
            await consumer.ConsumeAsync(stoppingToken);
        });
        return Task.CompletedTask;
    }
}
