import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:university_project_mobile/models/Messages.dart';
import 'package:university_project_mobile/utils/images.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../utils/colors.dart';

class details_Messages extends StatelessWidget {
  const details_Messages({Key? key, required this.message}) : super(key: key);
  final MessageModel? message;

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    var width = MediaQuery.of(context).size.width;
    changeStatusColor(Colors.transparent);
    return BlocConsumer<SchoolCubit, SchoolStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SchoolCubit.get(context);

          return Scaffold(
            body: SafeArea(
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverAppBar
                      (
                      expandedHeight: 200.0,
                      floating: false,
                      pinned: true,
                      titleSpacing: 0,
                      backgroundColor: white,
                      actionsIconTheme: IconThemeData(opacity: 0.0),
                      leading: IconButton(
                          icon: Icon(Icons.arrow_back,
                              color: !innerBoxIsScrolled
                                  ? logosColors
                                  : Colors.black),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      flexibleSpace: Padding(
                        padding: const EdgeInsets.only(top:30.0),
                        child: FlexibleSpaceBar(
                            background:Image.asset(backgroundImg,fit: BoxFit.cover,height: MediaQuery.of(context).size.height*0.4
                    ),
                    ),
                      ), ),
                      ];
                },
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Row(
                              children: [
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
                                    assetMessages,
                                    color: white,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(message!.subject,
                                    style: boldTextStyle(size: 18)),
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Text('Date', style: boldTextStyle(size: 18)),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                                dateFormat
                                    .format(DateTime.parse('${message!.date}')),
                                style: primaryTextStyle(size: 14)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: <Widget>[],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'description'.toUpperCase(),
                          style: boldTextStyle(size: 18, color: logosColors),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text('${message!.text}',
                            style: primaryTextStyle(size: 16)),
                        const SizedBox(height: 8),
// Container(
//   margin: EdgeInsets.only(left: 16),
//   child: Text('t3_lbl_desc', style: primaryTextStyle(size: 16)),
// ),
                        const SizedBox(height: 30),
                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}

Widget placeholderWidget() =>
    Image.asset('images/LikeButton/image/grey.jpg', fit: BoxFit.cover);

void changeStatusColor(Color color) async {
  setStatusBarColor(color);
}
