import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:university_project_mobile/helper/Navigation.dart';
import 'package:university_project_mobile/layout/school_Layout.dart';
import 'package:university_project_mobile/screens/HomeScreen/HomeScreen.dart';
import 'package:university_project_mobile/screens/messages/Add_message.dart';
import '../../components/styleWidget.dart';
import '../../layout/cubit/cubit.dart';

import '../../layout/cubit/states.dart';
import '../../shared/components/components.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/images.dart';
import '../../utils/widgets.dart';
import 'Details_messages.dart';

class get_allMessages extends StatefulWidget {
  const get_allMessages({Key? key}) : super(key: key);

  @override
  State<get_allMessages> createState() => _get_allMessagesState();
}

class _get_allMessagesState extends State<get_allMessages> {
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  var image;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SchoolCubit()
        ..getUserData()
        ..getMessages(),
      child: BlocConsumer<SchoolCubit, SchoolStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = SchoolCubit.get(context);
            image = cubit.profileImage;
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
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>school_Layout()));
;                                    },
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
                                text('Messages',
                                    textColor: appStore.textPrimaryColor,
                                    fontSize: textSizeLarge,
                                    fontFamily: fontBold),
                                backIcon(context, logosColors, Icons.add, white)
                              ],
                            ),
                          ),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: cubit.allMessages.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(
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
                                  padding: const EdgeInsets.all(16),
                                  child: Material(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  details_Messages(
                                                      message: cubit
                                                          .allMessages[index])),
                                        );
                                      },
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
                                                      gradGreen,
                                                      logosColors,
                                                    ],
                                                  ),
                                                ),
                                                width: width / 10,
                                                height: width / 10,
                                                padding: EdgeInsets.all(10),
                                                child: SvgPicture.asset(
                                                  assetMessages,
                                                  color: white,
                                                ),
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
                                                          cubit
                                                              .allMessages[
                                                                  index]
                                                              .subject,
                                                          maxLine: 1,
                                                          textColor: appStore
                                                              .textPrimaryColor,
                                                          fontSize:
                                                              textSizeSMedium),
                                                    ],
                                                  ),
                                                  text(
                                                      dateFormat.format(
                                                          DateTime.parse(cubit
                                                              .allMessages[
                                                                  index]
                                                              .date)),
                                                      fontFamily: fontMedium,
                                                      fontSize: textSizeSmall,
                                                      textColor: logosColors),
                                                ],
                                              )
                                            ],
                                          ),
                                          SizedBox(height: 16),
                                          Row(
                                            children: [
                                              Text('Description: ',
                                                  style: primaryTextStyle()),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                child: Text(
                                                  cubit.allMessages[index].text,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: secondaryTextStyle(),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 16),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
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

// ignore: must_be_immutable

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
    Navigator.push(context, MaterialPageRoute(builder: (context)=>add_message()));
  });
}
