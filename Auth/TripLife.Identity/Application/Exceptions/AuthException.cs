using System.Runtime.Serialization;

namespace Application.Exceptions
{
    public class AuthException : Exception
    {
        public AuthException()
        {
        }

        public AuthException(string? message) : base(message)
        {
        }

        public AuthException(string? message, Exception? innerException) : base(message, innerException)
        {
        }

        protected AuthException(SerializationInfo info, StreamingContext context) : base(info, context)
        {
        }
    }
}
