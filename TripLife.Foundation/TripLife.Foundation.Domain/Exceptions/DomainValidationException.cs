using FluentValidation;
using FluentValidation.Results;
using System.Runtime.Serialization;

namespace TripLife.Foundation.Domain.Exceptions;
public class DomainValidationException : ValidationException
{
    public DomainValidationException(string message) : base(message)
    {
    }

    public DomainValidationException(IEnumerable<ValidationFailure> errors) : base(errors)
    {
    }

    public DomainValidationException(string message, IEnumerable<ValidationFailure> errors) : base(message, errors)
    {
    }

    public DomainValidationException(SerializationInfo info, StreamingContext context) : base(info, context)
    {
    }

    public DomainValidationException(string message, IEnumerable<ValidationFailure> errors, bool appendDefaultMessage) : base(message, errors, appendDefaultMessage)
    {
    }
}
