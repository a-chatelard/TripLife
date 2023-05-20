namespace TripLife.Foundation.Kafka.Producers;

public interface IKafkaProducer<in TMessage>
{
    Task ProduceAsync(TMessage message);
}
