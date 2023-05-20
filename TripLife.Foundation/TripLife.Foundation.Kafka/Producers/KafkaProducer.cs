using Confluent.Kafka;
using System.Text.Json;
using TripLife.Foundation.Kafka.Settings;

namespace TripLife.Foundation.Kafka.Producers;

public class KafkaProducer<TMessage> : IKafkaProducer<TMessage> where TMessage : class
{
    private readonly ProducerConfig _producerConfiguration;
    private readonly string _topic;

    public KafkaProducer(KafkaSettings kafkaSettings, KafkaBaseSettings producerSettings)
    {
        _producerConfiguration = new ProducerConfig
        {
            BootstrapServers = kafkaSettings.BootstrapServers,
            EnableIdempotence = true,
            Acks = Acks.All,
            MessageSendMaxRetries = 2,
            MessageTimeoutMs = 1000
        };

        _topic = producerSettings.Topic;
    }

    public async Task ProduceAsync(TMessage message)
    {
        using (var producer = new ProducerBuilder<string, string>(_producerConfiguration)
            .SetKeySerializer(Serializers.Utf8)
            .SetValueSerializer(Serializers.Utf8)
            .Build())
        {
            var messageId = Guid.NewGuid();
            var serializedMessage = JsonSerializer.Serialize(message);

            await producer.ProduceAsync(_topic, new Message<string, string>
            {
                Key = messageId.ToString(),
                Value = serializedMessage
            });
        }
    }
}