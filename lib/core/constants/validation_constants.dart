class ValidationConstants {
  
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 128;
  
  
  static const int minTripTitleLength = 3;
  static const int maxTripTitleLength = 100;
  static const int minDescriptionLength = 10;
  static const int maxDescriptionLength = 500;
  static const int maxDestinationLength = 100;
  
  
  static const double minBudget = 0.0;
  static const double maxBudget = 999999.99;
  
  
  static const int maxTripDurationDays = 365;
  static const int minTripDurationDays = 1;
  
  
  static const String emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  
  
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
}
