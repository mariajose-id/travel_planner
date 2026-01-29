class CountryCodeToEmoji {
  
  
  static String convert(String countryCode) {
    if (countryCode.length != 2) return '';
    final upperCode = countryCode.toUpperCase();
    final firstChar = upperCode.codeUnitAt(0);
    final secondChar = upperCode.codeUnitAt(1);
    
    if (firstChar < 0x41 || firstChar > 0x5A) return '';
    if (secondChar < 0x41 || secondChar > 0x5A) return '';
    
    
    final firstRegional = 0x1F1E6 + (firstChar - 0x41);
    final secondRegional = 0x1F1E6 + (secondChar - 0x41);
    return String.fromCharCodes([
      firstRegional,
      secondRegional,
    ]);
  }
}
