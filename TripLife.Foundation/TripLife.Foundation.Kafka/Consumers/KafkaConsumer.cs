using Confluent.Kafka;
using MediatR;
using Microsoft.Extensions.Logging;
using System.Text.Json;
using TripLife.Foundation.Kafka.Settings;

namespace TripLife.Foundation.Kafka.Consumers;

public class KafkaConsumer<TMessage> where TMessage : INotification
{
    private readonly ConsumerConfig _consumerConfiguration;
    private readonly string _topic;
    private readonly IMediator _mediator;
    private readonly ILogger _logger;

    public KafkaConsumer(KafkaSettings kafkaSettings, KafkaBaseSettings consumerSettings, ILogger logger, IMediator mediator)
    {
        _consumerConfiguration = new ConsumerConfig
        {
            BootstrapServers = kafkaSettings.BootstrapServers,
            GroupId = consumerSettings.GroupId,
            AutoOffsetReset = AutoOffsetReset.Earliest
        };

        _topic = consumerSettings.Topic;
        _logger = logger;
        _mediator = mediator;
    }

    public async Task ConsumeAsync(CancellationToken cancellationToken)
    {
        try
        {
            using (var consumer = new ConsumerBuilder<string, string>(_consumerConfiguration).Build())
            {
                consumer.Subscribe(_topic);
                try
                {
                    while (true)
                    {
                        var consumeResult = consumer.Consume(cancellationToken);
                        var message = JsonSerializer.Deserialize<TMessage>(consumeResult.Message.Value);

                        if (message != null)
                        {
                            await _mediator.Publish(message);
                        }
                        else
                        {
                            _logger.LogError($"Erreur lors de la désérialisation du message : {consumeResult.Message.Value}.");
                        }
                    }
                }
                catch (OperationCanceledException)
                {
                    consumer.Close();
                    _logger.LogError($"Consommeur interrompu.");
                }
            }
        }
        catch (Exception ex)
        {
            _logger.LogError($"Erreur lors de la consommation Kafka : {ex}.");
        }
    }
}
