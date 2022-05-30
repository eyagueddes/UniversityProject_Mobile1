import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:university_project_mobile/helper/Navigation.dart';
import 'package:university_project_mobile/helper/network/dioHelper.dart';
import 'package:university_project_mobile/layout/cubit/cubit.dart';
import 'package:university_project_mobile/layout/cubit/states.dart';
import 'package:university_project_mobile/shared/components/components.dart';
import 'package:university_project_mobile/utils/colors.dart';
import 'package:university_project_mobile/utils/images.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../layout/school_Layout.dart';
import '../HomeScreen/HomeScreen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin {
  final formGlobalKey = GlobalKey<FormState>();
  var connexionController = TextEditingController();
  var passwordController = TextEditingController();
  final DioHelper dio = DioHelper();


  @override
  Widget build(BuildContext context) {

  return BlocProvider(
      create: (BuildContext context) => SchoolCubit(), //creation
      child: BlocConsumer<SchoolCubit, SchoolStates>(  //to know any cubit and any states it will control
        //control and listen to changes(states)the scaffold get as parameters
        listener: (context, state) {
          if (state is LoginLoadingState) {
            showToast(
              text: 'En Cours',
              state: ToastStates.WARNING,
            );
          }
          if (state is LoginSuccessState) {
            showToast(
              text: 'Connecté avec succès',
              state: ToastStates.SUCCESS,
            );
            navigateAndFinish(context, school_Layout());

          }
          if (state is LoginErrorState) {
            showToast(
              text: 'Login ou mot de passe incorrecte',
              state: ToastStates.ERROR,
            );
          }
        },  //builder and listner are required //listen to listen to scaffold
        builder: (context, state) {
          var cubit=SchoolCubit.get(context);//builder will rebuild based on what he listened
          return Scaffold(
              body: Center(
            child: SingleChildScrollView(
              child: Form(
                key: formGlobalKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 20)),

                       SvgPicture.asset(
                        assetLogin,
                        semanticsLabel: 'Acme Logo',
                        width: 200,
                        color: logosColors,
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'UniSpace',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: logosColors,
                          fontWeight: FontWeight.bold,
                          fontSize: 45,
                          fontFamily: 'Dancing'),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Bienvenue',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 19,
                          fontFamily: 'Roboto'),
                    ),

                    const Padding(
                      padding: EdgeInsets.fromLTRB(30, 5, 30, 30),
                      child: Text(
                        'Au systéme de gestion universitaire pour simplifier le travail administratif',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Roboto',
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Material(
                          borderRadius: BorderRadius.circular(25.0),
                          elevation: 15,
                          shadowColor: Colors.grey[100],
                          child: defaultTextField(
                              // onChange: (value) {
                              //   print(value);
                              // },
                              validate: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez entrer ce champ';
                                }
                              },
                              text: 'Connexion',
                              width: 5,
                              svgAsset: assetUser,
                              background: Colors.white,
                              type: TextInputType.text,
                              controller: connexionController)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Material(
                          borderRadius: BorderRadius.circular(25.0),
                          elevation: 10,
                          child: defaultTextField(
                              // onChange: (value) {
                              //   log(value);
                              // },
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Veuillez entrer un mot de passe';
                                }
                                return null;
                              },
                              text: 'Mot de passe',
                              width: 5,
                              svgAsset: assetPassword,
                              background: Colors.white,
                              type: TextInputType.text,
                              isPassword: cubit.isPassword,
                              suffixPressed: () {
                                cubit.changePasswordVisibility();
                              },
                              suffix:cubit.suffix,
                              controller: passwordController)),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Mot de passe oublié ? ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4.0),
                          child: Text(
                            'Cliquez ici?',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    //  Divider(),
                    SizedBox(
                      width: double.infinity,
                      height: 70.0,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 30.0, 10, 0),
                        child: defaultButton(
                          onPressed: () async {
                            if (formGlobalKey.currentState!.validate()) {
                              print(connexionController.text);
                              print(passwordController.text);
                              await cubit.userLogin(
                                login: connexionController.text,
                                password: passwordController.text,
                              );
                             }

                          },
                          text: 'Connectez-vous',
                        ),
                      ),
                    ),

                    // ClipPath(
                    //   clipper: MyClipper(),
                    //   child: Container(
                    //     child:const  Text("Pour une vie universitaire plus facile",style:  TextStyle(
                    //       fontFamily: 'Parisienne',
                    //     ),
                    //     ),
                    //     width: MediaQuery.of(context).size.width,
                    //     height: MediaQuery.of(context).size.height * 0.2,
                    //       color: logosColors),
                    //   ),
                  ],
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}

//
// class MyClipper extends CustomClipper<Path>{
//   @override
//   Path getClip(Size size) {
//     double width=size.width;
//     double height=size.height;
//     double offset=100.0;
//     var path = Path();
//     path.lineTo( 0,height);
//     path.lineTo( width,height);
//     path.lineTo(width, 0);
//     path.quadraticBezierTo(width/2, offset, 0, 0);
//
//     path.close();
//     return path ;
//   }
class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    double offset = 30.0;
    size.height;
    Path path = Path();
    path.moveTo(0, height);
    path.lineTo(0, height);
    path.lineTo(width, height);
    path.lineTo(width, height - (height - offset));
    path.quadraticBezierTo(
        3 * width / 4, 0, width / 2, height - (height - offset));
    path.quadraticBezierTo(
        width / 4, 2 * offset, 0, height - (height - offset));
    path.close();
    return path;
  }
//  //  class MyClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//   double width = size.width;
//   double height = size.height;
// //  double offset = 30.0;
//   size.height;
//   Path path = Path();
//  // path.moveTo(0, width/2  );
//     path.lineTo(0, height);
//     path.lineTo(height, width/2);
//   //path.lineTo(width, height - (height - offset));
//   path.quadraticBezierTo(
//   width/2 , 0, width , height );
//
//   path.lineTo(width, height);
//   path.close();
//   return path;
//   }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
