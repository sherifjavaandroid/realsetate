// // Copyright (c) 2019, the PS Project authors.  Please see the AUTHORS file
// // for details. All rights reserved. Use of this source code is governed by a
// // PS license that can be found in the LICENSE file.

// import 'package:flutter/material.dart';

// import '../core/vendor/utils/utils.dart';

// /// Colors Config For the whole App
// /// Please change the color based on your brand need.

// ///
// /// Dark Theme
// ///
// // const Color ps_wtheme_color_primary = Color(0xFFFFFFFF);
// // const Color ps_wtheme_color_primary_dark = Color(0xfFC7D180);
// // const Color ps_wtheme_color_primary_light = Color(0xfEFAD670);

// // const Color ps_wtheme_text__primary_color = Color(0xFF656565);
// // const Color ps_wtheme_text__primary_light_color = Color(0xFFadadad);
// // const Color ps_wtheme_text__primary_dark_color = Color(0xFF424242);

// // const Color ps_wtheme_icon_color = Color(0xFF757575);
// // const Color ps_wtheme_white_color = Colors.white;

// // ///
// // /// White Theme
// // ///
// // const Color ps_dtheme_color_primary = Color(0xFF303030);
// // const Color ps_dtheme_color_primary_dark = Color(0xFF555555);
// // const Color ps_dtheme_color_primary_light = Color(0xFF555555);

// // const Color ps_dtheme_text__primary_color = Color(0xFFFFFFFF);
// // const Color ps_dtheme_text__primary_light_color = Color(0xFFFFFFFF);
// // const Color ps_dtheme_text__primary_dark_color = Color(0xFFFFFFFF);

// // const Color ps_dtheme_icon_color = Colors.white;
// // const Color ps_dtheme_white_color = Color(0xFF757575);

// // ///
// // /// Common Theme
// // ///
// // const Color ps_ctheme_text__category_title = Color(0xFFffcc00);
// // const Color ps_ctheme_button__category_title = Color(0xFFffcc00);
// // const Color ps_ctheme_text__color_gery = Color(0xFF757575);
// // const Color ps_ctheme_text__color_primary_light = Color(0xFFbdbdbd);
// // const Color ps_ctheme__color_speical = Color(0xFFD2232A);
// // const Color ps_ctheme__color_about_us = Colors.cyan;
// // const Color ps_ctheme__color_application = Colors.blue;
// // const Color ps_ctheme__color_line = Color(0xFFbdbdbd);
// // const Color ps_ctheme__sold_out = Color(0x80D2232A);
// // const Color ps_ctheme__global_primary = Color(0xFFD2232A);

// // Copyright (c) 2019, the PS Project authors.  Please see the AUTHORS file
// // for details. All rights reserved. Use of this source code is governed by a
// // PS license that can be found in the LICENSE file.

// // import 'dart:ui';

// // import 'package:flutter/material.dart';

// class PsColors {
//   PsColors._();

//   ///
//   /// Main Color
//   ///

//   static Color mainLightColorWithBlack = dBaseColor;
//   static Color mainShadowColor = Colors.black.withOpacity(0.5);
//   static Color mainLightShadowColor = Colors.black.withOpacity(0.5);

//   /// Primary Color
//   static Color primary50 = cPrimary50;
//   static Color primary100 = cPrimary100;
//   static Color primary200 = cPrimary200;
//   static Color primary300 = cPrimary300;
//   static Color primary400 = cPrimary400;
//   static Color primary500 = cPrimary500;
//   static Color primary600 = cPrimary600;
//   static Color primary700 = cPrimary700;
//   static Color primary800 = cPrimary800;
//   static Color primary900 = cPrimary900;

//   /// Primary Dark Color
//   static Color primaryDarkDark = cPrimaryDarkDark;
//   static Color primaryDarkAccent = cPrimaryDarkAccent;
//   static Color primaryDarkWhite = cPrimaryDarkWhite;
//   static Color primaryDarkGrey = cPrimaryDarkGrey;

//   /// Secondary Color
//   static Color text50 = ctext50;
//   static Color text100 = ctext100;
//   static Color text200 = ctext200;
//   static Color text300 = ctext300;
//   static Color text400 = cSecondary400;
//   static Color text500 = ctext500;
//   static Color secondary600 = cSecondary600;
//   static Color text700 = ctext700;
//   static Color text800 = ctext800;
//   static Color text900 = ctext900;

//   /// Secondary Dark Color

//   static Color secondaryDarkDark = cSecondaryDarkDark;
//   static Color secondaryDarkAccent = cSecondaryDarkAccent;
//   static Color secondaryDarkWhite = cSecondaryDarkWhite;
//   static Color secondaryDarkGrey = cSecondaryDarkGrey;

//   ///
//   /// Base Color
//   ///
//   static Color baseColor = dBaseColor;
//   static Color baseDarkColor = dBaseDarkColor;
//   static Color baseLightColor = dBaseLightColor;

//   static Color? textPrimaryColorForLight;
//   static Color? textPrimaryDarkColorForLight;
//   static Color? textPrimaryLightColorForLight;

//   static Color? textColor1;
//   static Color? textColor2;
//   static Color? textColor3;
//   static Color? textColor4;
//   static Color? textColor5;

//   ///
//   /// Common Color
//   ///

//   static Color? txtPrimaryColor;
//   static Color? txtPrimaryDarkColor;
//   static Color? txtPrimaryLightColor;

//   ///
//   /// Button Color
//   ///
//   static Color? buttonColor;
//   static Color? bottomNavigationSelectedColor;
//   static Color? backArrowColor;
//   static Color? appBarTitleColor;
//   static Color? successColor;

//   ///
//   /// Primary Color
//   ///
//   static Color? mainColor;
//   static Color? mainTransparentColor;
//   static Color? mainDividerColor;

//   ///
//   ///
//   ///
//   static Color? bottomNavigationColor;

//   ///
//   /// Icon Color
//   ///
//   static Color iconColor = dIconColor;
//   static Color iconRejectColor = dIconColor;
//   static Color iconSuccessColor = dIconColor;
//   static Color iconInfoColor = dIconColor;

//   ///
//   /// Background Color
//   ///
//   static Color coreBackgroundColor = dBaseColor;
//   static Color backgroundColor = dBaseDarkColor;

//   ///
//   /// General
//   ///
//   static Color white = cWhiteColor;
//   static Color black = cBlackColor;
//   static Color grey = cGreyColor;
//   static Color transparent = cTransparentColor;

//   ///
//   /// Customs
//   ///

//   static Color facebookLoginButtonColor = cFacebookLoginColor;
//   static Color googleLoginButtonColor = cGoogleLoginColor;
//   static Color phoneLoginButtonColor = cPhoneLoginColor;
//   static Color appleLoginButtonColor = cAppleLoginColor;

//   static Color paypalColor = cPaypalColor;
//   static Color stripeColor = cStripeColor;
//   static Color cardBackgroundColor = cCardBackgroundColor;

//   static Color loadingCircleColor = cBlueColor;
//   static Color ratingColor = cRatingColor;
//   static Color soldOutUIColor = cSoldOutColor;
//   static Color itemTypeColor = cItemTypeColor;
//   static Color paidAdsColor = cPaidAdsColor;
//   static Color bluemarkColor = cBlueColor;

//   static Color watingForApprovalColor = cWatingForApprovalColor;
//   static Color notYetStartColor = cNotYetStartColor;
//   static Color adInFinishColor = cAdInFinishColor;
//   static Color adInRejectColor = cAdInRejectColor;
//   static Color adInProgressColor = cAdInProgressColor;
//   static Color warningColor = cWarningColor;

//   static Color offlineIconColor = cOfflineIconColor;
//   static Color senderTextMsgColor = cSenderTextMsgColor;
//   static Color receiverTextMsgColor = cReceiverTextMsgColor;
//   static Color buttonBorderColor = cButtonBorderColor;
//   static Color borderColor = cBorderColor;

//   /// Colors Config For the whole App
//   /// Please change the color based on your brand need.

//   ///
//   /// Light Theme
//   ///

//   static Color lMainColor = const Color(0xFF4361EE);
//   static Color lBaseColor = const Color(0xFFffffff);
//   static Color lbaseDarkColor = const Color(0xFFFFFFFF);
//   static Color lbaseLightColor = const Color(0xFFEFEFEF);

//   static Color lTextPrimaryColor = const Color(0xFF252B5C);   // accent 500
//   static Color lTextPrimaryLightColor = const Color(0xFFadadad);
//   static Color lTextPrimaryDarkColor = const Color(0xFF25425D);
//   static Color lTextColor4 = const Color(0xFF456079);

//   static Color lIconColor = const Color(0xFF4361EE);
//   static Color lIconRejectColor = const Color(0xFFF23A43);
//   static Color lIconSuccessColor = const Color(0xFF38C141);
//   static Color lIconInfoColor = const Color(0xFF00A2DD);
//   static Color lDividerColor = const Color(0x15505050);
//   static Color lMainTransparentColor = const Color(0xFFEDF0FA);
//   static Color lAppBarTitleColor = const Color(0xFF121212);
//   static Color lBottomNavigationColor = const Color(0xFFFFFFFF);
//   static Color lCardBackgroundColor = const Color(0xFF303030);
//   static Color lButtonColor = const Color(0xFF4361EE);

//   ///
//   /// Dark Theme
//   ///
//   static Color dMainColor = const Color(0xFF7C92F3);
//   static Color dBaseColor = const Color(0xFF212121);
//   static Color dBaseDarkColor = const Color(0xFF303030);
//   static Color dBaseLightColor = const Color(0xFF454545);
//   static Color dTextPrimaryColor = const Color(0xFF7C92F3);   // accent 200
//   static Color dTextPrimaryLightColor = const Color(0xFFFFFFFF);
//   static Color dTextPrimaryDarkColor = const Color(0xFFFFFFFF);
//   static Color dTextColor3 = const Color(0xFFA0A0A0);
//   static Color dIconColor = const Color(0xFF7C92F3);
//   static Color dDividerColor = const Color(0x1FFFFFFF);
//   static Color dMainTransparentColor = const Color(0xFFEDF0FA);
//   static Color dCardBackgroundColor = const Color(0xFF303030);
//   static Color dButtonColor = const Color(0xFF7C92F3);

//   ///
//   /// Common Theme
//   ///

//   static Color cPrimary50 = const Color(0xFFECEFFD);
//   static Color cPrimary100 = const Color(0xFFC7D0FA);
//   static Color cPrimary200 = const Color(0xFFA2B1F6);
//   static Color cPrimary300 = const Color(0xFF7C92F3);
//   static Color cPrimary400 = const Color(0xFF5773EF);
//   static Color cPrimary500 = const Color(0xFF4361EE);
//   static Color cPrimary600 = const Color(0xFF1F44EA);
//   static Color cPrimary700 = const Color(0xFF1335CD);
//   static Color cPrimary800 = const Color(0xFF102CA8);
//   static Color cPrimary900 = const Color(0xFF0C2283);

//   static Color cPrimaryDarkDark = const Color(0xFF303030);
//   static Color cPrimaryDarkAccent = const Color(0xFF4361EE);
//   static Color cPrimaryDarkWhite = const Color(0xFFffffff);
//   static Color cPrimaryDarkGrey = const Color(0xFFA0A0A0);

//   static Color ctext50 = const Color(0xFFF9F9F9);
//   static Color ctext100 = const Color(0xFFF3F3F3);
//   static Color ctext200 = const Color(0xFFEAEAEA);
//   static Color ctext300 = const Color(0xFFDADADA);
//   static Color cSecondary400 = const Color(0xFFB7B7B7);
//   static Color ctext500 = const Color(0xFF979797);
//   static Color cSecondary600 = const Color(0xFF6F6F6F);
//   static Color ctext700 = const Color(0xFF5B5B5B);
//   static Color ctext800 = const Color(0xFF3C3C3C);
//   static Color ctext900 = const Color(0xFF1C1C1C);

//   static Color cSecondaryDarkDark = const Color(0xFF303030);
//   static Color cSecondaryDarkAccent = const Color(0xFF6facff);
//   static Color cSecondaryDarkWhite = const Color(0xFFffffff);
//   static Color cSecondaryDarkGrey = const Color(0xFFA0A0A0);

//   static Color cWhiteColor = Colors.white;
//   static Color cBlackColor = Colors.black;
//   static Color cGreyColor = Colors.grey;
//   static Color cBlueColor = Colors.blue;
//   static Color cTransparentColor = Colors.transparent;
//   static Color cPaidAdsColor = Colors.lightGreen;

//   static Color cFacebookLoginColor = const Color(0xFF1877F2);
//   static Color cGoogleLoginColor = const Color(0xFFFFFFFF);
//   static Color cPhoneLoginColor = const Color(0xFF38C141);
//   static Color cAppleLoginColor = const Color(0xFF000000);

//   static Color cPaypalColor = const Color(0xFF3b7bbf);
//   static Color cStripeColor = const Color(0xFF008cdd);
//   static Color cCardBackgroundColor = const Color(0xFF303030);
//   static Color cRatingColor = const Color(0xFFF59E0B);
//   static Color cSoldOutColor = const Color(0xFFEF4444);
//   static Color cItemTypeColor = const Color(0xFFBDBDBD);

//   static Color cWatingForApprovalColor = const Color(0xFFF59E0B);
//   static Color cNotYetStartColor = const Color(0xFF979797);
//   static Color cAdInFinishColor = const Color(0xFF10B981);
//   static Color cAdInRejectColor = const Color(0xFFF23A43);
//   static Color cAdInProgressColor = const Color(0xFF00A2DD);
//   static Color cWarningColor = const Color(0xFFFFC700);

//   static Color cOfflineIconColor = const Color(0xFF6B7280);
//   static Color cSenderTextMsgColor = const Color(0xFF009993);
//   static Color cReceiverTextMsgColor = const Color(0xFFF6E9EA);
//   static Color cButtonBorderColor = const Color(0xFFE5E7EB);
//   static Color cBorderColor = const Color(0xFFD1D5DB);

//   static void loadColor(BuildContext context) {
//     if (Utils.isLightMode(context)) {
//       _loadLightColors();
//     } else {
//       _loadDarkColors();
//     }
//   }

//   static void loadColor2(bool isLightMode) {
//     if (isLightMode) {
//       _loadLightColors();
//     } else {
//       _loadDarkColors();
//     }
//   }

//   static void _loadDarkColors() {
//     ///
//     /// Main Color
//     ///
//     mainLightColorWithBlack = dBaseColor;
//     mainShadowColor = Colors.black.withOpacity(0.5);
//     mainLightShadowColor = Colors.black.withOpacity(0.5);
//     mainDividerColor = dDividerColor;

//     ///
//     ///Primary dark Color
//     ///
//     primaryDarkDark = cPrimaryDarkDark;
//     primaryDarkAccent = cPrimaryDarkAccent;
//     primaryDarkWhite = cPrimaryDarkWhite;
//     primaryDarkGrey = cPrimaryDarkGrey;

//     ///
//     ///Secondary dark Color
//     ///
//     secondaryDarkDark = cSecondaryDarkDark;
//     secondaryDarkAccent = cSecondaryDarkAccent;
//     secondaryDarkWhite = cSecondaryDarkWhite;
//     secondaryDarkGrey = cSecondaryDarkGrey;

//     ///
//     /// Base Color
//     ///
//     baseColor = dBaseColor;
//     baseDarkColor = dBaseDarkColor;
//     baseLightColor = dBaseLightColor;

//     ///
//     /// Text Color
//     ///
//     txtPrimaryColor = dTextPrimaryColor;
//     txtPrimaryDarkColor = dTextPrimaryDarkColor;
//     txtPrimaryLightColor = dTextPrimaryLightColor;

//     textPrimaryColorForLight = lTextPrimaryColor;
//     textPrimaryDarkColorForLight = lTextPrimaryDarkColor;
//     textPrimaryLightColorForLight = lTextPrimaryLightColor;

//     textColor1 = dMainColor;
//     textColor2 = dTextPrimaryLightColor;
//     textColor3 = dTextColor3;
//     textColor4 = dBaseColor;
//     textColor5 = text800;

//     ///
//     /// Button Color
//     ///
//     buttonColor = dButtonColor;
//     bottomNavigationSelectedColor = dMainColor;
//     mainColor = dMainColor;
//     mainTransparentColor = dMainTransparentColor;
//     backArrowColor = dMainColor;
//     appBarTitleColor = dTextPrimaryColor;
//     bottomNavigationColor = dBaseDarkColor;

//     ///
//     /// Icon Color
//     ///
//     iconColor = dIconColor;

//     ///
//     /// Background Color
//     ///
//     coreBackgroundColor = dBaseColor;
//     backgroundColor = dBaseDarkColor;

//     ///
//     /// General
//     ///
//     white = cWhiteColor;
//     black = cBlackColor;
//     grey = cGreyColor;
//     transparent = cTransparentColor;

//     ///
//     /// Custom
//     ///
//     facebookLoginButtonColor = cFacebookLoginColor;
//     googleLoginButtonColor = cGoogleLoginColor;
//     appleLoginButtonColor = cAppleLoginColor;
//     phoneLoginButtonColor = cPhoneLoginColor;
//     paypalColor = cPaypalColor;
//     stripeColor = cStripeColor;
//     loadingCircleColor = cBlueColor;
//     ratingColor = cRatingColor;
//     soldOutUIColor = cSoldOutColor;
//     itemTypeColor = cItemTypeColor;
//     paidAdsColor = cPaidAdsColor;
//     bluemarkColor = cBlueColor;
//     cardBackgroundColor = dCardBackgroundColor;

//     watingForApprovalColor = cWatingForApprovalColor;
//     notYetStartColor = cNotYetStartColor;
//     adInFinishColor = cAdInFinishColor;
//     adInRejectColor = cAdInRejectColor;
//     adInProgressColor = cAdInProgressColor;
//     warningColor = cWarningColor;

//     offlineIconColor = cOfflineIconColor;
//     senderTextMsgColor = cSenderTextMsgColor;
//     receiverTextMsgColor = cReceiverTextMsgColor;
//     buttonBorderColor = cButtonBorderColor;
//     borderColor = cBorderColor;
//   }

//   static void _loadLightColors() {
//     ///
//     /// Main Color
//     mainDividerColor = lDividerColor;

//     ///
//     ///Primary Color
//     ///
//     primary50 = cPrimary50;
//     primary100 = cPrimary100;
//     primary200 = cPrimary200;
//     primary300 = cPrimary300;
//     primary400 = cPrimary400;
//     primary500 = cPrimary500;
//     primary600 = cPrimary600;
//     primary700 = cPrimary700;
//     primary800 = cPrimary800;
//     primary900 = cPrimary900;

//     ///
//     ///Secondary Color
//     ///
//     text50 = ctext50;
//     text100 = ctext100;
//     text200 = ctext200;
//     text300 = ctext300;
//     text400 = cSecondary400;
//     text500 = ctext500;
//     secondary600 = cSecondary600;
//     text700 = ctext700;
//     text800 = ctext800;
//     text900 = ctext900;

//     ///
//     /// Base Color
//     ///
//     baseColor = lBaseColor;
//     baseDarkColor = lbaseDarkColor;
//     baseLightColor = lbaseLightColor;

//     ///
//     /// Text Color
//     ///
//     txtPrimaryColor = dTextPrimaryColor;
//     txtPrimaryDarkColor = dTextPrimaryDarkColor;
//     txtPrimaryLightColor = dTextPrimaryLightColor;

//     textPrimaryColorForLight = lTextPrimaryColor;
//     textPrimaryDarkColorForLight = lTextPrimaryDarkColor;
//     textPrimaryLightColorForLight = lTextPrimaryLightColor;

//     textColor1 = lMainColor;
//     textColor2 = ctext700;
//     textColor3 = ctext500;
//     textColor4 = lTextColor4;
//     textColor5 = white;

//     ///
//     /// Button Color
//     ///
//     buttonColor = lButtonColor;
//     bottomNavigationSelectedColor = lMainColor;
//     mainColor = lMainColor;
//     mainTransparentColor = lMainTransparentColor;
//     backArrowColor = ctext800;
//     appBarTitleColor = lAppBarTitleColor;
//     successColor = lIconSuccessColor;
//     bluemarkColor = cBlueColor;
//     bottomNavigationColor = lBottomNavigationColor;

//     ///
//     /// Icon Color
//     ///
//     iconColor = lIconColor;
//     iconRejectColor = lIconRejectColor;
//     iconSuccessColor = lIconSuccessColor;
//     iconInfoColor = lIconInfoColor;

//     ///
//     /// Background Color
//     ///
//     coreBackgroundColor = lBaseColor;
//     backgroundColor = lbaseDarkColor;

//     ///
//     /// General
//     ///
//     white = cWhiteColor;
//     black = cBlackColor;
//     grey = cGreyColor;
//     transparent = cTransparentColor;

//     ///
//     /// Custom
//     ///
//     facebookLoginButtonColor = cFacebookLoginColor;
//     googleLoginButtonColor = cGoogleLoginColor;
//     appleLoginButtonColor = cAppleLoginColor;
//     phoneLoginButtonColor = cPhoneLoginColor;
//     paypalColor = cPaypalColor;
//     stripeColor = cStripeColor;
//     loadingCircleColor = cBlueColor;
//     ratingColor = cRatingColor;
//     soldOutUIColor = cSoldOutColor;
//     itemTypeColor = cItemTypeColor;
//     paidAdsColor = cPaidAdsColor;
//     cardBackgroundColor = lCardBackgroundColor;
//   }
// }


// Copyright (c) 2019, the PS Project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// PS license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../core/vendor/utils/utils.dart';
import '../core/vendor/viewobject/mobile_color.dart';

/// Colors Config For the whole App
/// Please change the color based on your brand need.

class PsColors {
  PsColors._();

  ///
  /// Primary Colors
  ///
  static Color primary50 = const Color(0xFFE8EBFD);
  static Color primary100 = const Color(0xFFC7D0FA);
  static Color primary200 = const Color(0xFFAFBCF8);
  static Color primary300 = const Color(0xFF98A9F6);
  static Color primary400 = const Color(0xFF7389F2);
  static Color primary500 = const Color(0xFF4361EE);
  static Color primary600 = const Color(0xFF0F2AA8);
  static Color primary700 = const Color(0xFF0C2183);
  static Color primary800 = const Color(0xFF091A67);
  static Color primary900 = const Color(0xFF071450);

  ///
  /// Text Colors
  ///
  static Color text50 = const Color(0xFFF2F2F2);
  static Color text100 = const Color(0xFFE0E0E0);
  static Color text200 = const Color(0xFFD4D4D4);
  static Color text300 = const Color(0xFFC7C7C7);
  static Color text400 = const Color(0xFFB3B3B3);
  static Color text500 = const Color(0xFF8B8B8B);
  static Color text600 = const Color(0xFF5C5C5C);
  static Color text700 = const Color(0xFF474747);
  static Color text800 = const Color(0xFF383838);
  static Color text900 = const Color(0xFF2B2B2B);

  ///
  /// Accent Colors
  ///
  static Color accent50 = const Color(0xFFEDEEF8);
  static Color accent100 = const Color(0xFFD3D7EE);
  static Color accent200 = const Color(0xFFC1C6E6);
  static Color accent300 = const Color(0xFFAFB5DF);
  static Color accent400 = const Color(0xFF919AD4);
  static Color accent500 = const Color(0xFF343E83);
  static Color accent600 = const Color(0xFF343E83);
  static Color accent700 = const Color(0xFF293066);
  static Color accent800 = const Color(0xFF202650);
  static Color accent900 = const Color(0xFF191D3E);

  ///
  /// Sematic - Success Colors
  ///
  static Color success50 = const Color(0xFFE8FDF6);
  static Color success100 = const Color(0xFFC7FAE9);
  static Color success200 = const Color(0xFFAFF8E0);
  static Color success300 = const Color(0xFF98F6D7);
  static Color success400 = const Color(0xFF72F3C8);
  static Color success500 = const Color(0xFF10B981);
  static Color success600 = const Color(0xFF0FA976);
  static Color success700 = const Color(0xFF0B835C);
  static Color success800 = const Color(0xFF096748);
  static Color success900 = const Color(0xFF075038);

  ///
  /// Sematic - Error Colors
  ///
  static Color error50 = const Color(0xFFFDE8E8);
  static Color error100 = const Color(0xFFFAC7C7);
  static Color error200 = const Color(0xFFF8AFAF);
  static Color error300 = const Color(0xFFF69898);
  static Color error400 = const Color(0xFFF37272);
  static Color error500 = const Color(0xFFA90E0E);
  static Color error600 = const Color(0xFFDC2626);
  static Color error700 = const Color(0xFF840B0B);
  static Color error800 = const Color(0xFF670909);
  static Color error900 = const Color(0xFF500707);

  ///
  /// Sematic - Warning Colors
  ///
  static Color warning50 = const Color(0xFFFEF5E7);
  static Color warning100 = const Color(0xFFFDE8C4);
  static Color warning200 = const Color(0xFFFCDEAC);
  static Color warning300 = const Color(0xFFFBD493);
  static Color warning400 = const Color(0xFFF9C56C);
  static Color warning500 = const Color(0xFFF59E0B);
  static Color warning600 = const Color(0xFFB07107);
  static Color warning700 = const Color(0xFF895806);
  static Color warning800 = const Color(0xFF6C4504);
  static Color warning900 = const Color(0xFF533603);

  ///
  /// Sematic - Info Colors
  ///
  static Color info50 = const Color(0xFFE7EFFE);
  static Color info100 = const Color(0xFFC4DAFC);
  static Color info200 = const Color(0xFFACCAFB);
  static Color info300 = const Color(0xFF94BBFA);
  static Color info400 = const Color(0xFF6DA2F8);
  static Color info500 = const Color(0xFF3B82F6);
  static Color info600 = const Color(0xFF0848B0);
  static Color info700 = const Color(0xFF063889);
  static Color info800 = const Color(0xFF052C6B);
  static Color info900 = const Color(0xFF042253);

  ///
  /// Achromatic Colors
  ///
  static Color achromatic50 = const Color(0xFFFFFFFF);
  static Color achromatic100 = const Color(0xFFEBEBEB);
  static Color achromatic200 = const Color(0xFFD6D6D6);
  static Color achromatic300 = const Color(0xFFB8B8B8);
  static Color achromatic400 = const Color(0xFF999999);
  static Color achromatic500 = const Color(0xFF858585);
  static Color achromatic600 = const Color(0xFF666666);
  static Color achromatic700 = const Color(0xFF363636);
  static Color achromatic800 = const Color(0xFF292929);
  static Color achromatic900 = const Color(0xFF121212);

  ///
  /// Brand Colors
  ///
  static Color facebookColor = const Color(0xFF3B5999);
  static Color googleColor = const Color(0xFFDD4B39);
  static Color phoneColor = const Color(0xFF38C141);
  static Color appleColor = const Color(0xFF000000);
  static Color paypalColor = const Color(0xFF003087);
  static Color stripeColor = const Color(0xFF00AFE1);
  static Color razorColor = const Color(0xFF003087);
  static Color paystackColor = const Color(0xFF00C3F7);

  static void replaceColor(MobileColor mobileColor) {
    // primary300 = Utils.codeToColor('rgba(0, 255, 38, 0.5)', primary500);
    // primary500 = Utils.codeToColor('#EF58', primary500);
    primary50 = Utils.codeToColor(mobileColor.primary50, primary50);
    primary100 = Utils.codeToColor(mobileColor.primary100, primary100);
    primary200 = Utils.codeToColor(mobileColor.primary200, primary200);
    primary300 = Utils.codeToColor(mobileColor.primary300, primary300);
    primary400 = Utils.codeToColor(mobileColor.primary400, primary400);
    primary500 = Utils.codeToColor(mobileColor.primary500, primary500);
    primary600 = Utils.codeToColor(mobileColor.primary600, primary600);
    primary700 = Utils.codeToColor(mobileColor.primary700, primary700);
    primary800 = Utils.codeToColor(mobileColor.primary800, primary800);
    primary900 = Utils.codeToColor(mobileColor.primary900, primary900);

    text50 = Utils.codeToColor(mobileColor.text50, text50);
    text100 = Utils.codeToColor(mobileColor.text100, text100);
    text200 = Utils.codeToColor(mobileColor.text200, text200);
    text300 = Utils.codeToColor(mobileColor.text300, text300);
    text400 = Utils.codeToColor(mobileColor.text400, text400);
    text500 = Utils.codeToColor(mobileColor.text500, text500);
    text600 = Utils.codeToColor(mobileColor.text600, text600);
    text700 = Utils.codeToColor(mobileColor.text700, text700);
    text800 = Utils.codeToColor(mobileColor.text800, text800);
    text900 = Utils.codeToColor(mobileColor.text900, text900);

    accent50 = Utils.codeToColor(mobileColor.accent50, accent50);
    accent100 = Utils.codeToColor(mobileColor.accent100, accent100);
    accent200 = Utils.codeToColor(mobileColor.accent200, accent200);
    accent300 = Utils.codeToColor(mobileColor.accent300, accent300);
    accent400 = Utils.codeToColor(mobileColor.accent400, accent400);
    accent500 = Utils.codeToColor(mobileColor.accent500, accent500);
    accent600 = Utils.codeToColor(mobileColor.accent600, accent600);
    accent700 = Utils.codeToColor(mobileColor.accent700, accent700);
    accent800 = Utils.codeToColor(mobileColor.accent800, accent800);
    accent900 = Utils.codeToColor(mobileColor.accent900, accent900);

    success50 = Utils.codeToColor(mobileColor.success50, success50);
    success100 = Utils.codeToColor(mobileColor.success100, success100);
    success200 = Utils.codeToColor(mobileColor.success200, success200);
    success300 = Utils.codeToColor(mobileColor.success300, success300);
    success400 = Utils.codeToColor(mobileColor.success400, success400);
    success500 = Utils.codeToColor(mobileColor.success500, success500);
    success600 = Utils.codeToColor(mobileColor.success600, success600);
    success700 = Utils.codeToColor(mobileColor.success700, success700);
    success800 = Utils.codeToColor(mobileColor.success800, success800);
    success900 = Utils.codeToColor(mobileColor.success900, success900);

    error50 = Utils.codeToColor(mobileColor.error50, error50);
    error100 = Utils.codeToColor(mobileColor.error100, error100);
    error200 = Utils.codeToColor(mobileColor.error200, error200);
    error300 = Utils.codeToColor(mobileColor.error300, error300);
    error400 = Utils.codeToColor(mobileColor.error400, error400);
    error500 = Utils.codeToColor(mobileColor.error500, error500);
    error600 = Utils.codeToColor(mobileColor.error600, error600);
    error700 = Utils.codeToColor(mobileColor.error700, error700);
    error800 = Utils.codeToColor(mobileColor.error800, error800);
    error900 = Utils.codeToColor(mobileColor.error900, error900);

    warning50 = Utils.codeToColor(mobileColor.warning50, warning50);
    warning100 = Utils.codeToColor(mobileColor.warning100, warning100);
    warning200 = Utils.codeToColor(mobileColor.warning200, warning200);
    warning300 = Utils.codeToColor(mobileColor.warning300, warning300);
    warning400 = Utils.codeToColor(mobileColor.warning400, warning400);
    warning500 = Utils.codeToColor(mobileColor.warning500, warning500);
    warning600 = Utils.codeToColor(mobileColor.warning600, warning600);
    warning700 = Utils.codeToColor(mobileColor.warning700, warning700);
    warning800 = Utils.codeToColor(mobileColor.warning800, warning800);
    warning900 = Utils.codeToColor(mobileColor.warning900, warning900);

    info50 = Utils.codeToColor(mobileColor.info50, info50);
    info100 = Utils.codeToColor(mobileColor.info100, info100);
    info200 = Utils.codeToColor(mobileColor.info200, info200);
    info300 = Utils.codeToColor(mobileColor.info300, info300);
    info400 = Utils.codeToColor(mobileColor.info400, info400);
    info500 = Utils.codeToColor(mobileColor.info500, info500);
    info600 = Utils.codeToColor(mobileColor.info600, info600);
    info700 = Utils.codeToColor(mobileColor.info700, info700);
    info800 = Utils.codeToColor(mobileColor.info800, info800);
    info900 = Utils.codeToColor(mobileColor.info900, info900);

    achromatic50 = Utils.codeToColor(mobileColor.achromatic50, achromatic50);
    achromatic100 = Utils.codeToColor(mobileColor.achromatic100, achromatic100);
    achromatic200 = Utils.codeToColor(mobileColor.achromatic200, achromatic200);
    achromatic300 = Utils.codeToColor(mobileColor.achromatic300, achromatic300);
    achromatic400 = Utils.codeToColor(mobileColor.achromatic400, achromatic400);
    achromatic500 = Utils.codeToColor(mobileColor.achromatic500, achromatic500);
    achromatic600 = Utils.codeToColor(mobileColor.achromatic600, achromatic600);
    achromatic700 = Utils.codeToColor(mobileColor.achromatic700, achromatic700);
    achromatic800 = Utils.codeToColor(mobileColor.achromatic800, achromatic800);
    achromatic900 = Utils.codeToColor(mobileColor.achromatic900, achromatic900);

    facebookColor = Utils.codeToColor(mobileColor.facebookColor, facebookColor);
    googleColor = Utils.codeToColor(mobileColor.googleColor, googleColor);
    phoneColor = Utils.codeToColor(mobileColor.phoneColor, phoneColor);
    appleColor = Utils.codeToColor(mobileColor.appleColor, appleColor);
    paypalColor = Utils.codeToColor(mobileColor.paypalColor, paypalColor);
    stripeColor = Utils.codeToColor(mobileColor.stripeColor, stripeColor);
    razorColor = Utils.codeToColor(mobileColor.razorColor, razorColor);
    paystackColor = Utils.codeToColor(mobileColor.paystackColor, paystackColor);
  }
}
