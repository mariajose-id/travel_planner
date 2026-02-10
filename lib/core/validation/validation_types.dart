abstract class ValidationException implements Exception {
  final List<ValidationError> errors;
  
  const ValidationException(this.errors);
  
  @override
  String toString() => 'ValidationException: ${errors.map((e) => e.toString()).join(', ')}';
}

class ValidationError {
  final String field;
  final ValidationType type;
  final String? expected;
  final dynamic actual;
  
  const ValidationError({
    required this.field,
    required this.type,
    this.expected,
    this.actual,
  });
  
  @override
  String toString() => 'ValidationError(field: $field, type: $type, expected: $expected, actual: $actual)';
}

enum ValidationType {
  required,
  minLength,
  maxLength,
  emailPattern,
  passwordPattern,
  fileSize,
  fileType,
  invalidFormat,
}

class ValidationOutcome {
  final bool isValid;
  final List<ValidationError> errors;
  
  const ValidationOutcome({required this.isValid, required this.errors});
  
  factory ValidationOutcome.success() => const ValidationOutcome(isValid: true, errors: []);
  
  factory ValidationOutcome.failure(List<ValidationError> errors) => 
      ValidationOutcome(isValid: false, errors: errors);
}

abstract class ValidationInterface<T> {
  ValidationOutcome validate(T data);
}
