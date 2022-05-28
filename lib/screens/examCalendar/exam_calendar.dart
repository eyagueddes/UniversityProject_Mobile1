
import 'dart:isolate';
import 'dart:ui';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_svg/svg.dart';
import 'package:university_project_mobile/layout/cubit/states.dart';
import 'package:university_project_mobile/utils/images.dart';
import '../../layout/cubit/cubit.dart';
import '../../utils/colors.dart';
import '../../utils/widgets.dart';

import 'package:university_project_mobile/utils/colors.dart';

class exam_calendar extends StatefulWidget {

  @override
  State<exam_calendar> createState() => _exam_calendarState();
 
}

class _exam_calendarState extends State<exam_calendar> {
  ReceivePort _port = ReceivePort();
  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];
      setState((){
      });
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(String id, DownloadTaskStatus status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    Color scaffoldBackgroundColor = Color(0xFFEFEFEF);
    var width = MediaQuery
        .of(context)
        .size
        .width;
    var height = MediaQuery
        .of(context)
        .size
        .height;
    return BlocProvider(
        create: (BuildContext context) =>
        SchoolCubit()
          ..getUserExamCalendar()..getUserData()..getUserExamCalendar(),
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
                                      icon: Icon(Icons.keyboard_arrow_left, size: 40, color: t5White),
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
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 20),
                              SizedBox(height: 10),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 16, bottom: 16, right: 16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
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
                                            examCalendarAsset,
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
                                              'Calendrier des examens',
                                              style: TextStyle(
                                                color:
                                                appStore.textPrimaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.01,
                                            ),
                                            Text(
                                              'Vous trouverez ci-joint le calendrier des examens.',
                                              style: TextStyle(
                                                color:
                                                appStore.textPrimaryColor,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 16),
                                    T8Button(
                                        textContent:
                                        'Télécharger'.toUpperCase(),
                                        onPressed: () {
                                        cubit.downloadExamCalendar();
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
                      )
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
    path.quadraticBezierTo(size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}