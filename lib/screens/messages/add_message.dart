import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:university_project_mobile/layout/cubit/cubit.dart';
import 'package:university_project_mobile/layout/cubit/states.dart';
import 'package:university_project_mobile/utils/colors.dart';
import '../../components/defaultFormField.dart';
import '../../shared/components/components.dart';
import '../../utils/images.dart';

class add_message extends StatefulWidget {
  const add_message({Key? key}) : super(key: key);

  @override
  State<add_message> createState() => _add_messageState();
}

class _add_messageState extends State<add_message> {
  var subjectController = TextEditingController();
  var textController = TextEditingController();
  var phoneController = TextEditingController();

  var _formkey = GlobalKey<FormState>();
  String? _selected;
  @override
  Widget build(BuildContext context) {
    Widget leadingWidget() {
      return BackButton(
        color: white,
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }
    return BlocProvider(
        create: (BuildContext context) => SchoolCubit()..getUserData(),
        child:
            BlocConsumer<SchoolCubit, SchoolStates>(listener: (context, state) {
          if (state is MessagesAddingSuccessState) {
            showToast(
              text: 'succes',
              state: ToastStates.SUCCESS,
            );
          }
        }, builder: (context, state) {
          var cubit = SchoolCubit.get(context);
          return Scaffold(
            backgroundColor: GWhite,
            body: Column(
              children: <Widget>[
                //header
                Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 140,
                      child: CustomPaint(painter: _MyPainter()),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                // leadingWidget(),
                                IconButton(
                                  icon:const Icon(Icons.keyboard_arrow_left,
                                      size: 40, color: t5White),
                                  onPressed: () {
                                    finish(context);
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children:  <Widget>[
                                CircleAvatar(
                                  backgroundImage: cubit.profileImage != null
                                      ? NetworkImage(cubit.profileImage)
                                      : NetworkImage(noImageAsset),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formkey,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.82,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    0.0315),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              // child: Text(
                              //   'Ajouter une Demande',
                              //   style: GoogleFonts.quicksand(
                              //       fontSize: 20,
                              //       fontWeight: FontWeight.w700,
                              //       color: logosColors),
                              // ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10),
                                      SizedBox(height: 10),
                                      Text(
                                        'Sujet: ',
                                        style: GoogleFonts.inter(
                                            color: black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 10),
                                      Center(
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.85,
                                          child: DefaultFormField(
                                            controller: subjectController,
                                            validation: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Veuillez saisir ce champ';
                                              }
                                            },
                                            label: "",
                                            keyboardType: TextInputType.text,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Description: ',
                                        style: GoogleFonts.inter(
                                            color: black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 10),
                                      Center(
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.85,
                                          child: DefaultFormField(
                                            controller: textController,
                                            validation: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Veuillez saisir ce champ';
                                              }
                                            },
                                            label: "",
                                            keyboardType: TextInputType.text,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Numéro de télephone: ',
                                        style: GoogleFonts.inter(
                                            color: black,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 10),
                                      Center(
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.85,
                                          child: DefaultFormField(
                                            controller: phoneController,
                                            validation: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Veuillez saisir ce champ';
                                              }
                                            },
                                            label: "",
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        height: 70.0,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 30.0, 10, 0),
                                          child: defaultButton(
                                            onPressed: () async {
                                              if (_formkey.currentState!
                                                  .validate()) {
                                                print(subjectController.text);
                                                print(textController.text);
                                                await cubit.addMessage(
                                                  subject:
                                                      subjectController.text,
                                                  text: textController.text,
                                                  phone: phoneController.text,
                                                );
                                              }
                                            },
                                            text: 'Envoyer',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }));
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
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
