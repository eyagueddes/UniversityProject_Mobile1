import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:university_project_mobile/utils/images.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';

Widget placeholderWidget() => Image.asset(  userAvatar, fit: BoxFit.cover);



Widget text(
    String? text, {
      var fontSize = 18.0,
      Color? textColor,
      var fontFamily,
      var isCentered = false,
      var maxLine = 1,
      var latterSpacing = 0.5,
      bool textAllCaps = false,
      var isLongText = false,
      final TextOverflow? overflow,
      bool lineThrough = false,
    }) {
  return Text(
    textAllCaps ? text!.toUpperCase() : text!,
    textAlign: isCentered ? TextAlign.center : TextAlign.start,
    maxLines: isLongText ? null : maxLine,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
      fontFamily: fontFamily ?? null,
      fontSize: fontSize,
      color: textColor ?? Color(0xFF5A5C5E),
      height: 1.5,
      letterSpacing: latterSpacing,
      decoration: lineThrough ? TextDecoration.lineThrough : TextDecoration.none,
    ),
  );
}

BoxDecoration boxDecoration({double radius = 2, Color color = Colors.transparent, Color? bgColor, var showShadow = false}) {
  return BoxDecoration(
    color: bgColor ?? Color(0xFFEBF2F7),
    boxShadow: showShadow ? defaultBoxShadow(shadowColor: Color(0x95E9EBF0)) : [BoxShadow(color: Colors.transparent)],
    border: Border.all(color: color),
    borderRadius: BorderRadius.all(Radius.circular(radius)),
  );
}


void changeStatusColor(Color color) async {
  setStatusBarColor(color);
}

Widget commonCacheImageWidget(String? url, double height, {double? width, BoxFit? fit}) {
  if (url.validate().startsWith('http')) {
    return CachedNetworkImage(
      placeholder: (context, url) => placeholderWidget(),
      imageUrl: '$url',
      height: height,
      width: width,
      fit: fit ?? BoxFit.cover,
      errorWidget: (_, __, ___) {
        return SizedBox(height: height, width: width);
      },
    );
  } else {
    return Image.asset(url!, height: height, width: width, fit: fit ?? BoxFit.cover);
  }
}

Row rowHeading(var label) {
  return Row(
    children: <Widget>[
      Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Text(label, style: TextStyle(color: textPrimaryColor, fontSize: 18, fontFamily: 'Bold'), textAlign: TextAlign.left),
      ),
    ],
  );
}

// ignore: non_constant_identifier_names
Text Heading(var label) {
  return Text(label, style: TextStyle(color: textPrimaryColor, fontSize: 18, fontFamily: 'Bold'), textAlign: TextAlign.left);
}

Row profileText(var label, {var maxline = 1}) {
  return Row(
    children: <Widget>[
      Padding(padding: const EdgeInsets.fromLTRB(20, 0, 10, 0), child: text(label, fontSize: textSizeLargeMedium, textColor: textPrimaryColor, maxLine: maxline)),
    ],
  );
}

Divider view() {
  return Divider(color: t1_view_color, height: 0.5);
}
// ignore: must_be_immutable
class TopBar extends StatefulWidget {
  var titleName;

  TopBar(var this.titleName);

  @override
  State<StatefulWidget> createState() {
    return TopBarState();
  }
}
class TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 60,
        color: Color(0xFF131d25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu, color: Color(0xFF212121)),
              onPressed: () {
                finish(context);
              },
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Center(
                  child: Text(widget.titleName, style: TextStyle(color: Color(0xFF000000), fontSize: textSizeNormal, fontFamily: fontBold))
              ),
            ),
            IconButton(
              icon: Icon(Icons.notifications_none),
              onPressed: () {
                finish(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
