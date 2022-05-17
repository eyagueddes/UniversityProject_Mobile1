import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:university_project_mobile/utils/colors.dart';
import 'package:university_project_mobile/utils/images.dart';
import 'package:flutter_svg/flutter_svg.dart';
class SendEmailNotification extends StatelessWidget {
 // const ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       body:   Column(
         children: [
           ClipPath(
             clipper: MyClipper(),
             child: Container(
               width: MediaQuery.of(context).size.width,
               height: MediaQuery.of(context).size.height * 0.5,
               child: SvgPicture.asset(
                 assetLogin,
                 semanticsLabel: 'Acme Logo',
                 width: MediaQuery.of(context).size.width * 0.3,
                 height:  MediaQuery.of(context).size.height * 0.2,
                 fit: BoxFit.scaleDown,
                 color: Colors.white,
               ),
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(50),
                     topRight: Radius.circular(50)),
                 color: logosColors,
               ),
             ),
           ),
           SizedBox(
             height: MediaQuery.of(context).size.height*0.1,
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text(
                   "Un e-mail a été envoyé à l'adresse que vous \n avez fournie..  ",
                   textAlign: TextAlign.center,
                   style: TextStyle(
                       fontSize: 15,
                       fontFamily: 'Roboto',
                       fontWeight: FontWeight.bold),
                 ),
               ],
             ),
           ),

           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text(
                   "Veuillez vérifier votre e-mail et suivre les \n instructions.  ",
                   textAlign: TextAlign.center,
                   style: TextStyle(
                       fontSize: 15,
                       fontFamily: 'Roboto',
                       fontWeight: FontWeight.bold),
                 ),
               ],
             ),
           ),
         ],
       ),


);



  }
}
class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
