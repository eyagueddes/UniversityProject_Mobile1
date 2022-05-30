import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:university_project_mobile/layout/cubit/cubit.dart';
import 'package:university_project_mobile/layout/cubit/states.dart';
import '../../components/styleWidget.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/images.dart';
import 'Details_Notice.dart';

class notices extends StatefulWidget {
  const notices({Key? key}) : super(key: key);

  @override
  State<notices> createState() => _noticesState();
}

class _noticesState extends State<notices> {
  var image;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SchoolCubit()
          ..getNotices()
          ..getUserData(),
        child: BlocConsumer<SchoolCubit, SchoolStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = SchoolCubit.get(context);
              late var width;
              image = cubit.profileImage;
              print(image);
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
                                        Navigator.pop(context);
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  text('Avis',
                                      textColor: appStore.textPrimaryColor,
                                      fontSize: textSizeLarge,
                                      fontFamily: fontBold),
                                ],
                              ),
                            ),
                            ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: cubit.allNotices.length,
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
                                                    Details_Notice(
                                                        notice:
                                                            cubit.allNotices[
                                                                index])),
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              children: <Widget>[
                                                Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        gradGreen,
                                                        logosColors,
                                                      ],
                                                    ),
                                                  ),
                                                  width: width / 9,
                                                  height: width / 9,
                                                  padding: EdgeInsets.all(10),
                                                  child: SvgPicture.asset(
                                                    assetNotice,
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
                                                                .allNotices[
                                                                    index]
                                                                .title,
                                                            maxLine: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            textColor: appStore
                                                                .textPrimaryColor,
                                                            fontSize:
                                                                textSizeSMedium),
                                                      ],
                                                    ),
                                                    (cubit.allNotices[index]
                                                                .pdf !=
                                                            "")
                                                        ? TextButton(
                                                            child: text(
                                                                'Téléchager',
                                                                fontFamily:
                                                                    fontMedium,
                                                                fontSize:
                                                                    textSizeSmall,
                                                                textColor:
                                                                    logosColors),
                                                            onPressed: () {
                                                              print(
                                                                  'notice to download,${cubit.allNotices[index].pdf}');
                                                              cubit.downloadNotice(
                                                                  cubit
                                                                      .allNotices[
                                                                          index]
                                                                      .pdf);
                                                            },
                                                          )
                                                        : Text(''),
                                                  ],
                                                )
                                              ],
                                            ),
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
                                                    cubit.allNotices[index]
                                                        .message,
                                                    style: secondaryTextStyle(),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
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
            }));
  }
}

Widget backIcon(BuildContext context, var color, var icon, var iconColor) {
  return Container(
          width: 38,
          height: 38,
          decoration: boxDecoration(
              bgColor: color, radius: 10, color: white, showShadow: false),
          child: Icon(icon, color: iconColor))
      .onTap(() {});
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
