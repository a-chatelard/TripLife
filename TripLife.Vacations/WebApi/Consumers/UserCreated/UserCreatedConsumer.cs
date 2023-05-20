using Application.Users.UserCreated;
using MediatR;
using Microsoft.Extensions.Options;
using WebApi.Settings;

namespace WebApi.Consumers.UserCreated;

public class UserCreatedConsumer : IHostedService
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

    public async Task StartAsync(CancellationToken cancellationToken)
    {
        var consumer = new KafkaConsumer<UserCreatedEvent>(_kafkaSettings, _consumerSettings, _logger, _mediator);
        await consumer.ConsumeAsync(cancellationToken);
    }

    public Task StopAsync(CancellationToken cancellationToken)
    {
        return Task.CompletedTask;
    }
}
