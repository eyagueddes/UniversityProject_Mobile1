import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:university_project_mobile/screens/demands/addDemand.dart';

import '../../components/curvedNavigationBar.dart';
import '../../components/styleWidget.dart';
import '../../helper/Navigation.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/images.dart';

class get_allDemands extends StatefulWidget {
  const get_allDemands({Key? key}) : super(key: key);

  @override
  State<get_allDemands> createState() => _get_allDemandsState();
}

class _get_allDemandsState extends State<get_allDemands> {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  var image;
  @override
  void initState() {
    super.initState();
    image = SchoolCubit().profileImage;
    print(SchoolCubit.get(context).allDemands);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SchoolCubit()
        ..getUserData()
        ..getDemands(),
      child: BlocConsumer<SchoolCubit, SchoolStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SchoolCubit.get(context);
            late var width;
            width = MediaQuery.of(context).size.width;
            return Scaffold(
              backgroundColor: context.scaffoldBackgroundColor,
              body: Column(
                children: <Widget>[
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
                                    backgroundImage: image != null
                                        ? NetworkImage(image)
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
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                text('Demandes',
                                    textColor: appStore.textPrimaryColor,
                                    fontSize: textSizeLarge,
                                    fontFamily: fontBold),
                                backIcon(context, logosColors, Icons.add, white)
                              ],
                            ),
                          ),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: cubit.allDemands.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                    margin: const EdgeInsets.only(
                                        left: 16, bottom: 16, right: 16),
                                    decoration: boxDecoration(
                                        radius: 10,
                                        showShadow: true,
                                        bgColor:
                                            context.scaffoldBackgroundColor),
                                    padding: const EdgeInsets.all(16),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                width: width / 10,
                                                height: width / 10,
                                                padding: EdgeInsets.all(10),
                                                child: SvgPicture.asset(
                                                    assetDemands,color: white,),
                                              ),
                                              SizedBox(width: 16),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Row(
                                                    children: [
                                                      Text('Sujet: ',
                                                          style:
                                                              primaryTextStyle()),
                                                      text(
                                                          cubit.allDemands[
                                                              index]['subject'],
                                                          textColor: appStore
                                                              .textPrimaryColor,
                                                          fontSize:
                                                              textSizeSMedium),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      text(
                                                          dateFormat.format(
                                                              DateTime.parse(cubit
                                                                      .allDemands[
                                                                  index]['date'])),
                                                          fontFamily: fontMedium,
                                                          fontSize: textSizeSmall,
                                                          textColor: logosColors),
                                                      text(cubit.allDemands[index]['status'], textColor:cubit.allDemands[index]['status']=='En cours'? PendCOlor : cubit.allDemands[index]['status']=='Rejetée'? redColor: Colors.green, fontSize: textSizeMedium),

                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 12),
                                          Row(
                                            children: [
                                              Text('Langue: ',
                                                  style: primaryTextStyle()),
                                              Text(
                                                cubit.allDemands[index]
                                                    ['langue'],
                                                style: secondaryTextStyle(),
                                                maxLines: 2,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Text('Raison: ',
                                                  style: primaryTextStyle()),
                                              Text(
                                                cubit.allDemands[index]
                                                    ['raison'],
                                                style: secondaryTextStyle(),
                                                maxLines: 2,
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 16),
                                        ]));
                              }),
                        ],
                      ),
                    ),
                  )
                ],
              ),

            );
          }),
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

Widget backIcon(BuildContext context, var color, var icon, var iconColor) {
  return Container(
          width: 38,
          height: 38,
          decoration: boxDecoration(
              bgColor: color, radius: 10, color: white, showShadow: false),
          child: Icon(icon, color: iconColor))
      .onTap(() {
    navigateAndFinish(context, add_demand());
  });
}
