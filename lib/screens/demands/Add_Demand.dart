import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:university_project_mobile/layout/cubit/states.dart';
import 'package:university_project_mobile/utils/colors.dart';
import 'package:university_project_mobile/utils/images.dart';
import '../../components/defaultFormField.dart';
import '../../layout/cubit/cubit.dart';
import '../../shared/components/components.dart';

class add_demand extends StatefulWidget {
  const add_demand({Key? key}) : super(key: key);

  @override
  State<add_demand> createState() => _State();
}

class _State extends State<add_demand> {
  @override
  void initState() {
    super.initState();
    print('image');
  }

  var subjectController = TextEditingController();
  var raisonController = TextEditingController();
  var phoneController = TextEditingController();
  var languageController = TextEditingController();
  var _formkey = GlobalKey<FormState>();

  String? _selected;
  @override
  Widget build(BuildContext context) {
    // var user=context.watch<SchoolCubit>().getUserData();
    // final cloudinaryImage = CloudinaryImage(user.avatar);
    // String transformedUrl = cloudinaryImage.toString();
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
          if (state is DemandAddingSuccessState) {
            showToast(
              text: 'succes',
              state: ToastStates.SUCCESS,
            );
          }
        }, builder: (context, state) {
          var cubit = SchoolCubit.get(context);
          return Scaffold(
            backgroundColor: context.scaffoldBackgroundColor,
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
                                  icon: Icon(Icons.keyboard_arrow_left,
                                      size: 40, color: t5White),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    print('ok');
                                   // finish(context);
                                  },
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: cubit.profileImage != null
                                      ? NetworkImage(cubit.profileImage)
                                      : NetworkImage(noImageAsset),
                                ),
                                // IconButton(
                                //   icon: Icon(Icons.favorite, color: white),
                                //   onPressed: () {
                                //     finish(context);
                                //   },
                                // ),
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
                                      Text(
                                        'Type de Demande : ',
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
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black26,
                                                  spreadRadius: -10.0,
                                                  blurRadius: 10.0,
                                                  offset: Offset(0.0, 0.0),
                                                ),
                                              ],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Material(
                                              elevation: 5,
                                              shadowColor: Colors.grey[100],
                                              child: DropdownButtonHideUnderline(
                                                child: ButtonTheme(
                                                  alignedDropdown: true,
                                                  child: DropdownButtonFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                            border:
                                                                InputBorder.none),
                                                    menuMaxHeight: 200,
                                                    itemHeight: 50,
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        _selected = newValue!;
                                                        subjectController.text =
                                                            newValue;
                                                        print(
                                                            '  subjectController,${subjectController.text}');
                                                      });
                                                    },
                                                    hint: const Text(
                                                        'Choisir une demande'),
                                                    items: cubit.Demands.map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: value,
                                                        child: Text(value),
                                                      );
                                                    }).toList(),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        'Raison: ',
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
                                            child: Material(
                                              elevation: 5,
                                              shadowColor: Colors.grey[100],
                                              child: DefaultFormField(
                                                maxLine: 3,
                                                prefix: assetMessages,
                                                controller: raisonController,
                                                validation: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Veuillez saisir ce champ';
                                                  }
                                                },
                                                label: "",
                                                keyboardType: TextInputType.multiline,

                                          ),
                                            ),
                                        ),
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        'Numéro de téléphone: ',
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
                                          child: Material(
                                            elevation: 5,
                                            shadowColor: Colors.grey[100],
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
                                      ),
                                      SizedBox(height: 12),
                                      Text(
                                        'Langue ',
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
                                          child: Material(
                                            elevation: 5,
                                            shadowColor: Colors.grey[100],
                                            child: DefaultFormField(
                                              controller: languageController,
                                               validation: (value) {
                                              //   if (value == null ||
                                              //       value.isEmpty) {
                                              //     return 'Veuillez saisir ce champ';
                                              //   }
                                              },
                                              label: "",
                                              keyboardType: TextInputType.text,
                                            ),
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
                                                print(phoneController.text);
                                                print(raisonController.text);
                                                await cubit.addDemand(
                                                  phone: phoneController.text,
                                                  langue:
                                                      languageController.text,
                                                  subject:
                                                      subjectController.text,
                                                  raison: raisonController.text,
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
