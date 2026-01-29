import 'package:flutter/material.dart';
class AppSpacing {
  AppSpacing._();
  
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  
  static const EdgeInsets paddingXS = EdgeInsets.all(xs);
  static const EdgeInsets paddingSM = EdgeInsets.all(sm);
  static const EdgeInsets paddingMD = EdgeInsets.all(md);
  static const EdgeInsets paddingLG = EdgeInsets.all(lg);
  static const EdgeInsets paddingXL = EdgeInsets.all(xl);
  
  static const EdgeInsets paddingHorizontalSM = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets paddingHorizontalMD = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets paddingHorizontalLG = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets paddingVerticalSM = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets paddingVerticalMD = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets paddingVerticalLG = EdgeInsets.symmetric(vertical: lg);
  
  static const EdgeInsets marginXS = EdgeInsets.all(xs);
  static const EdgeInsets marginSM = EdgeInsets.all(sm);
  static const EdgeInsets marginMD = EdgeInsets.all(md);
  static const EdgeInsets marginLG = EdgeInsets.all(lg);
  static const EdgeInsets marginXL = EdgeInsets.all(xl);
  
  static const EdgeInsets cardPadding = EdgeInsets.all(md);
  static const EdgeInsets screenPadding = EdgeInsets.all(lg);
  static const EdgeInsets dialogPadding = EdgeInsets.all(lg);
  static const EdgeInsets formPadding = EdgeInsets.all(md);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(horizontal: lg, vertical: md);
  
  static const double smallBorderRadius = 8.0;
  static const double mediumBorderRadius = 12.0;
  static const double largeBorderRadius = 16.0;
  static const double extraLargeBorderRadius = 24.0;
  
  static const double noElevation = 0.0;
  static const double smallElevation = 2.0;
  static const double mediumElevation = 4.0;
  static const double largeElevation = 8.0;
  
  static const double smallIcon = 16.0;
  static const double mediumIcon = 24.0;
  static const double largeIcon = 32.0;
  static const double extraLargeIcon = 48.0;
  
  static const double buttonHeight = 48.0;
  static const double inputHeight = 56.0;
  static const double avatarSize = 40.0;
  static const double smallAvatarSize = 32.0;
  static const double largeAvatarSize = 56.0;
  
  static const Duration fastAnimation = Duration(milliseconds: 150);
  static const Duration normalAnimation = Duration(milliseconds: 300);
  static const Duration slowAnimation = Duration(milliseconds: 500);
  
  static const Widget gapXS = SizedBox(width: xs, height: xs);
  static const Widget gapSM = SizedBox(width: sm, height: sm);
  static const Widget gapMD = SizedBox(width: md, height: md);
  static const Widget gapLG = SizedBox(width: lg, height: lg);
  static const Widget gapXL = SizedBox(width: xl, height: xl);
  
  static const Widget horizontalGapXS = SizedBox(width: xs);
  static const Widget horizontalGapSM = SizedBox(width: sm);
  static const Widget horizontalGapMD = SizedBox(width: md);
  static const Widget horizontalGapLG = SizedBox(width: lg);
  static const Widget horizontalGapXL = SizedBox(width: xl);
  
  static const Widget verticalGapXS = SizedBox(height: xs);
  static const Widget verticalGapSM = SizedBox(height: sm);
  static const Widget verticalGapMD = SizedBox(height: md);
  static const Widget verticalGapLG = SizedBox(height: lg);
  static const Widget verticalGapXL = SizedBox(height: xl);
}
