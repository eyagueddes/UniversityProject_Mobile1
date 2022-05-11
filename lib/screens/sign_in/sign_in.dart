import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:university_project_mobile/utils/constants.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen> {

  static const String id='LoginScreen';
  var _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key:_formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: SvgPicture.asset(
                        assetLogin,
                        semanticsLabel: 'Acme Logo',
                        width: 200,
                        color: logosColors,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    'Bienvenue',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight:FontWeight.bold,fontSize:14,fontFamily: 'Roboto' ),

                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(30,5,30,30),
                    child: Text(
                      'Au systéme de gestion universitaire pour simplifier le travail administratif',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize:14,fontFamily: 'Roboto',),

                    ),
                  ),

                  TextField(

                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                        prefixIcon: SizedBox(

                          child: SvgPicture.asset(
                            assetUser,
                            semanticsLabel: 'Acme Logo',
                            color: logosColors,
                              height: 5, width: 5,
                              fit: BoxFit.scaleDown

                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color:Colors.black87),

                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(width: 1, color:Colors.black87),
                        ),
                        hintText: "Connexion",
                        hintStyle: TextStyle(color: Colors.black87),
                        alignLabelWithHint: false,
                        filled: true),
                    cursorColor: Colors.black,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                        prefixIcon: SizedBox(
                          child: SvgPicture.asset(
                              assetPassword,
                              semanticsLabel: 'Acme Logo',
                              color: logosColors,
                              height: 5, width: 5,
                              fit: BoxFit.scaleDown

                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color:Colors.black87),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(width: 1, color:Colors.black87),
                        ),
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.black87),
                        alignLabelWithHint: false,
                        filled: true),
                    cursorColor: Colors.black,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Mot de passe oublié ? ',
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize:14,fontFamily: 'Roboto',fontWeight: FontWeight.w600),

                      ),
                      Padding(
                        padding: const EdgeInsets.only(left :4.0),
                        child: Text(
                          'Cliquez ici?',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize:14,fontFamily: 'Roboto',fontWeight: FontWeight.bold),

                        ),
                      ),
                    ],
                  ),
                //  Divider(),
                  SizedBox(
                    width: double.infinity,
                    height: 70.0,
                    child: Padding(
                      padding: const EdgeInsets.only(top:30.0),

                      child: ElevatedButton(
                        onPressed: () {
                          //print( 'Customize Rounded Raised button');
                        },
                        style: ElevatedButton.styleFrom(
                          primary: logosColors,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: BorderSide(
                              color: logosColors,
                            ),
                          ),
                        ),
                        child: Text(
                          'Connectez-vous',
                          style: TextStyle(fontSize: 15,color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                 SizedBox(
                   height: 30,
                 ),
                 ClipPath(
                    clipper: MyClipper(),
                   child: Container(

                      width: MediaQuery.of(context).size.width,
                      height:MediaQuery.of(context).size.height*0.2,
                      decoration: BoxDecoration(
                        // borderRadius: BorderRadius.only(
                        //   topLeft:Radius.circular(50),
                        //   topRight: Radius.circular(50)
                        // ),
                        color: Colors.black87
                      ),
                    ),
                 )

                ],

              ),
            ),
          ),
        ));
  }
}

class MyClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height-80);
    path.quadraticBezierTo(size.width/2, size.height, size.width, size.height-80);
    path.lineTo(size.width, 0);
    path.close();
    return path ;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}