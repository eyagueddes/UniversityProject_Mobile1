import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:university_project_mobile/layout/cubit/cubit.dart';
import 'package:university_project_mobile/models/marks.dart';

import '../../layout/cubit/states.dart';
import '../../utils/colors.dart';
import '../../utils/widgets.dart';
import 'package:university_project_mobile/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class result_Deliberation extends StatefulWidget {
  const result_Deliberation({Key? key}) : super(key: key);

  @override
  State<result_Deliberation> createState() => _result_DeliberationState();
}

class _result_DeliberationState extends State<result_Deliberation> {
  //@override
  // void initState() {
  //   ResultDeliberationCubit.get(context).getResultDeliberation();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Color scaffoldBackgroundColor = Color(0xFFEFEFEF);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
        create: (BuildContext context) =>
            SchoolCubit()..getResultDeliberation()..getUserData(),
        child: BlocConsumer<SchoolCubit, SchoolStates>(
            listener: (context, state) {},
            builder: (context, state) {
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
                                      icon: Icon(Icons.keyboard_arrow_left,
                                          size: 40, color: t5White),
                                      onPressed: () {
                                        finish(context);
                                      },
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    CircleAvatar(
                                      backgroundImage:cubit.profileImage!=null? NetworkImage(cubit.profileImage):NetworkImage(noImageAsset),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "Classe : ${context.watch<SchoolCubit>().deliberationModel?.classe}",
                              style: boldTextStyle(
                                  fontFamily: fontFamilyBoldGlobal),
                            ).paddingOnly(bottom: 2),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "Semestre : ${context.watch<SchoolCubit>().deliberationModel?.semester}",
                              style: secondaryTextStyle(
                                  color: logosColors,
                                  fontFamily: fontFamilyBoldGlobal),
                            ).paddingOnly(bottom: 16),
                          ),
                          SizedBox(height: 10),
                          Container(
                            margin: EdgeInsets.only(
                                left: 16, bottom: 16, right: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: const [
                                BoxShadow(
                                  color: shadowColor,
                                  offset: Offset(5, 5),
                                  blurRadius: 10.0,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.white,
                                            logosColors,
                                          ],
                                        ),
                                      ),
                                      width: width / 6.5,
                                      height: width / 6.5,
                                      padding: EdgeInsets.all(10),
                                      child: SvgPicture.asset(
                                        studyPlanAsset,
                                        height: 20,
                                        fit: BoxFit.scaleDown,
                                        color: appStore.cardColor,
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Délibération des notes",
                                          style: TextStyle(
                                            color: appStore.textPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: width * 0.04,
                                          ),
                                        ),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        Text(
                                          "Vous trouverez ci-joint le fichier de délibération ",
                                          style: TextStyle(
                                            color: appStore.textPrimaryColor,
                                            fontSize: width * 0.03,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(height: 16),
                                T8Button(
                                    textContent: 'Télécharger'.toUpperCase(),
                                    onPressed: () {
                                      cubit.downloadDeliberation();
                                    }),
                                // Text(
                                //   '$progress',
                                //   style:Theme.of(context).textTheme.headline4,
                                //   ),
                              ],
                            ),
                          ),
                        ],
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
