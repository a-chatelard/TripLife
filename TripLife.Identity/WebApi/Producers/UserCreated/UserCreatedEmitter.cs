using Application.Auth.Events;
using Microsoft.Extensions.Options;
using TripLife.Foundation.Kafka.Producers;
using TripLife.Foundation.Kafka.Settings;
using WebApi.Models.Events.Auth;

namespace WebApi.Producers.UserCreated;

public class UserCreatedEmitter : IUserCreatedEmitter
{
    private readonly IKafkaProducer<UserCreatedEvent> _producer;

    public UserCreatedEmitter(IOptions<KafkaSettings> kafkaSettings, IOptions<UserCreatedProducerSettings> producerSettings)
    {
        _producer = new KafkaProducer<UserCreatedEvent>(kafkaSettings.Value, producerSettings.Value);
    }

    public async Task EmitAsync(UserCreatedEvent message)
    {
         await _producer.ProduceAsync(message);
    }
}
