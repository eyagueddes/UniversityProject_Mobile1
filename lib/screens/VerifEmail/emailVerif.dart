import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:university_project_mobile/shared/components/components.dart';
import 'package:university_project_mobile/utils/colors.dart';
import 'package:university_project_mobile/utils/images.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerificationScreen extends StatefulWidget {
  // const ({Key? key}) : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
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
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Entrez le mail associé à votre compte ',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(15,15,15,0),
            child: Form(
              child: Material(
                borderRadius: BorderRadius.circular(25.0),
                elevation: 15,
                shadowColor: Colors.grey[100],
                child: defaultTextField (
                  onChange: (value){
                    print(value);
                  },
                  validate: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter text';
                    }

                  },
                    text:'e-mail',
                    width: 5,
                    svgAsset: assetEmail,
                    background: Colors.white,
                    type:TextInputType.text,
                 controller: emailController,
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: SizedBox(
              width: double.infinity,
              height: 70.0,
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: defaultButton(
               onSubmit: () => {},
               text: 'Envoyer le code'),
              ),
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
