import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:university_project_mobile/utils/colors.dart';
import 'package:university_project_mobile/utils/images.dart';
import 'curvedNavigationBar.dart';

class bottom_navigation extends StatefulWidget {


  @override
  bottom_navigationState createState() => bottom_navigationState();
}

class bottom_navigationState extends State<bottom_navigation> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   // changeStatusColor(appStore.appBarColor);
    return Scaffold(
      bottomNavigationBar: Container(
        height: 100,
        color:Colors.white,
        child: CurvedNavigationBar(
          backgroundColor: logosColors,
          color: Colors.white,
          items: <Widget>[
            SvgPicture.asset(assetHome, height: 24, width: 24, fit: BoxFit.none, color: logosColors),
            SvgPicture.asset(assetUser, height: 24, width: 24, fit: BoxFit.none, color: logosColors),
            SvgPicture.asset(assetEdit, height: 24, width: 24, fit: BoxFit.none, color: logosColors),

          ],
          onTap: (index) {
            //Handle button tap
          },
        ),
      ),
    );
  }
}
class _MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.color = logosColors;

    Path path = Path();
    path.lineTo(0, size.height - 40);
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
