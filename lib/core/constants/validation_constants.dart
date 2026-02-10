class ValidationConstants {
  static const String emailRegex =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  static const String passwordRegex =
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$'; // Min 8 chars, 1 letter, 1 number
  static const String phoneRegex = r'^\+?[\d\s-]{10,}$';
  static const String numericRegex = r'^\d+$';
  static const String alphanumericRegex = r'^[a-zA-Z0-9]+$';
}
