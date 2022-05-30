import 'package:flutter/material.dart';
const GWhite=Color(0xFFFCFCF7);
const kWhite = Colors.white ;
const kBlack = Colors.black;
const  logosColors = Color(0xFF62786f);
const kBackgroundColor = Color(0xFFF1EFF1);
const kPrimaryColor = Color(0xFF035AA6);
const kTextLightColor = Color(0xFF747474);
const shadowColor = Color(0xFFdfdfdf);
const roundColor = Color(0xFFE2FFF9);
const kiconsColor = Color(0xFF7A7028);
const PendCOlor=Color(0xFFF1A928);
const YColor = Color(0XFF02C29B);
const db2_textColorSecondary = Color(0xFF757575);
const t2_colorPrimary = Color(0XFF5959fc);
const t2_colorPrimaryDark = Color(0XFF7900F5);
const t2_colorPrimaryLight = Color(0XFFF2ECFD);
const t2_colorAccent = Color(0XFF7e05fa);
const t2_textColorPrimary = Color(0XFF212121);
const t2_textColorSecondary = Color(0XFF747474);
const t2_app_background = Color(0XFFf8f8f8);
const t2_view_color = Color(0XFFDADADA);
const gradient_color=Color.fromRGBO(89, 114, 89, 0.5450980392156862);
const t2_white = Color(0XFFFFFFFF);
const t2_icon_color = Color(0XFF747474);
const t2_blue = Color(0XFF1C38D3);
const t2_orange = Color(0XFFFF5722);
const t2_background_bottom_navigation = Color(0XFFE9E7FE);
const t2_background_selected = Color(0XFFF3EDFE);
const t2_green = Color.fromRGBO(4, 23, 4, 0.5450980392156862);
const t2_red = Color(0XFFFCDD2);
const t2_card_background = Color(0XFFFaFaFa);
const t2_bg_bottom_sheet = Color(0XFFE8E6FD);
const t2_instagram_pink = Color(0XFFCC2F97);
const t2_linkedin_pink = Color(0XFF0c78b6);
var t2lightStatusBar = materialColor(0XFFEAEAF9);
var t2White = materialColor(0XFFFFFFFF);
var t2TextColorPrimary = materialColor(0XFF212121);
const shadow_color = Color(0XFFECECEC);
const t1_view_color = Color(0XFFDADADA);
const t5ColorPrimary = Color(0XFF5104D7);
const t5ColorPrimaryDark = Color(0XFF325BF0);
const t5ColorAccent = Color(0XFFD81B60);
const t5TextColorPrimary = Color(0XFF130925);
const t5TextColorSecondary = Color(0XFF888888);
const t5TextColorThird = Color(0XFFBABFB6);
const t5TextColorGrey = Color(0XFFB4BBC2);
const t5White = Color(0XFFFFFFFF);
const t5LayoutBackgroundWhite = Color(0XFFF6F7FA);
const t5ViewColor = Color(0XFFB4BBC2);
const t5SkyBlue = Color(0XFF1fc9cd);
const t5DarkNavy = Color(0XFF130925);
const t5Cat2 = Color(0XFF510AD7);
const t5Cat3 = Color(0XFFe43649);
const t5Cat4 = Color(0XFFf4b428);
const t5Cat5 = Color(0XFF22ce9a);
const t5Cat6 = Color(0XFF203afb);
const t5ShadowColor = Color(0X95E9EBF0);
const t5DarkRed = Color(0XFFF06263);
const t5ColorPrimaryLight = Color(0X505104D7);
const t7colorPrimary = Color(0xFF2F95A1);
const gradGreen=Color.fromRGBO(175, 189, 175, 0.5450980392156862);


Map<int, Color> color= {
  50: Color.fromRGBO(24, 52, 24, 0.5450980392156862),
  100: Color.fromRGBO(46, 73, 46, 0.5450980392156862),
  200: Color.fromRGBO(89, 114, 89, 0.5450980392156862),
  300: Color.fromRGBO(8, 30, 8, 0.5450980392156862),
  400: Color.fromRGBO(33, 45, 33, 0.5450980392156862),
  500: Color.fromRGBO(83, 93, 83, 0.5450980392156862),
  600: Color.fromRGBO(4, 23, 4, 0.5450980392156862),
  700: Color.fromRGBO(218, 238, 218, 0.5450980392156862),
  800: Color.fromRGBO(193, 199, 193, 0.5450980392156862),
  900: Color.fromRGBO(25, 44, 25, 0.5450980392156862),
};

MaterialColor materialColor(colorHax) {
  return MaterialColor(colorHax, color);
}
AppStore appStore = AppStore();
class AppStore{

  Color textPrimaryColor = Color(0xFF212121);
  Color iconColorPrimaryDark = Color(0xFF212121);
  Color scaffoldBackground = Color(0xFFEBF2F7);
  Color backgroundColor = Colors.black;
  Color backgroundSecondaryColor = Color(0xFF131d25);
  Color appColorPrimaryLightColor = Color(0xFFF9FAFF);
  Color textSecondaryColor = Color(0xFF5A5C5E);
  Color appBarColor = Colors.white;
  Color iconColor = Color(0xFF212121);
  Color iconSecondaryColor = Color(0xFFA8ABAD);
  Color cardColor = Colors.white;
  Color appColorPrimary = Color(0xFF1157FA);
  Color scaffoldBackgroundColor = Color(0xFFEFEFEF);

  AppStore();

}

MaterialColor colorCustom = MaterialColor(0XFF5959fc, color);