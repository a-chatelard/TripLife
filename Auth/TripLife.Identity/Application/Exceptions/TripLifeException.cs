using System.Runtime.Serialization;

namespace Application.Exceptions
{
    public class TripLifeException : Exception
    {
        public TripLifeException()
        {
        }

        public TripLifeException(string? message) : base(message)
        {
        }

        public TripLifeException(string? message, Exception? innerException) : base(message, innerException)
        {
        }

        protected TripLifeException(SerializationInfo info, StreamingContext context) : base(info, context)
        {
        }
    }
}
