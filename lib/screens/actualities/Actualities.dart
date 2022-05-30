import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:university_project_mobile/helper/Navigation.dart';
import 'package:university_project_mobile/layout/cubit/cubit.dart';
import 'package:university_project_mobile/layout/cubit/states.dart';
import 'package:university_project_mobile/layout/school_Layout.dart';
import 'package:university_project_mobile/models/actualities.dart';
import 'package:university_project_mobile/screens/HomeScreen/HomeScreen.dart';
import 'package:university_project_mobile/utils/images.dart';
import '../../components/styleWidget.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import 'Details_actuality.dart';

class actualities extends StatelessWidget {
  const actualities({Key? key, this.actuality}) : super(key: key);
  final ActualityModel? actuality;
  @override
  Widget build(BuildContext context) {
    //final cloudinaryImage = CloudinaryImage(ActualitiesCubit().model?.image);
    // String transformedUrl = cloudinaryImage.transform().thumb().face().generate().toString();
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    var width = MediaQuery.of(context).size.width;

    changeStatusColor(appStore.appBarColor);
    return BlocProvider(
        create: (BuildContext context) => SchoolCubit()
          ..getActualities()
          ..getUserData(),
        child: BlocConsumer<SchoolCubit, SchoolStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = SchoolCubit.get(context);
              return Scaffold(
                backgroundColor: context.scaffoldBackgroundColor,
                body: Container(
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            height: 160,
                            child: CustomPaint(painter: _MyPainter()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      // leadingWidget(),
                                      IconButton(
                                        icon: const Icon(
                                            Icons.keyboard_arrow_left,
                                            size: 40,
                                            color: t5White),
                                        onPressed: () {
                                          navigateAndFinish(
                                              context, school_Layout());
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: <Widget>[
                                      CircleAvatar(
                                        backgroundImage: cubit.profileImage !=
                                                null
                                            ? NetworkImage(cubit.profileImage)
                                            : const NetworkImage(noImageAsset),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            transform:
                                Matrix4.translationValues(0.0, 80.0, 0.0),
                            child: Padding(
                              padding: EdgeInsets.all(16),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(26)),
                                    boxShadow: defaultBoxShadow()),
                                child: Stack(
                                  alignment: Alignment.centerRight,
                                  children: <Widget>[
                                    TextField(
                                        onChanged: (value) {
                                          // cubit.searchOperation(value);
                                        },
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: white,
                                            hintText: 'Recherche',
                                            contentPadding:
                                                const EdgeInsets.only(
                                                    left: 26.0,
                                                    bottom: 8.0,
                                                    right: 50.0),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: white, width: 0.5),
                                              borderRadius:
                                                  BorderRadius.circular(26),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: white, width: 0.5),
                                              borderRadius:
                                                  BorderRadius.circular(26),
                                            ))),
                                    GestureDetector(
                                      child: const Padding(
                                        padding: EdgeInsets.only(right: 16.0),
                                        child: Icon(Icons.search,
                                            color: db2_textColorSecondary),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: cubit.allActualities.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Padding(
                                  padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
                                  child: Column(
                                    children: <Widget>[
                                      Material(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      details_actuality(
                                                          actuality: cubit
                                                                  .allActualities[
                                                              index])),
                                            );
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                top: 20,
                                                bottom: 5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Colors.white,
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: shadowColor,
                                                  offset: Offset(5, 5),
                                                  blurRadius: 5.0,
                                                ),
                                              ],
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                ClipRRect(
                                                  child: Container(
                                                    width: width / 3.5,
                                                    height: width / 4,
                                                    child: CachedNetworkImage(
                                                      fit: BoxFit.fill,
                                                      imageUrl: "${cubit.allActualities[index].image}" !=
                                                              ""
                                                          ? "${cubit.allActualities[index].image}"
                                                          : 'https://delta-expert.fr/wp-content/uploads/2017/11/cest-nouveau-2-272x185.png',
                                                      progressIndicatorBuilder: (context,
                                                              url,
                                                              downloadProgress) =>
                                                          CircularProgressIndicator(
                                                              value:
                                                                  downloadProgress
                                                                      .progress),
                                                      // errorWidget: (context,url,error)=>CircularProgressIndicator(color: Colors.grey,),
                                                      // placeholder: (context, url) =>
                                                      //     placeholderWidget(),
                                                      // width: width / 3.5,
                                                      // height: width / 4,
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10.0),
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: <Widget>[
                                                            text(
                                                                cubit
                                                                    .allActualities[
                                                                        index]
                                                                    .subject,
                                                                textColor: appStore
                                                                    .textPrimaryColor,
                                                                fontSize:
                                                                    textSizeLargeMedium,
                                                                fontFamily:
                                                                    fontBold),
                                                            text(
                                                                dateFormat.format(
                                                                    DateTime.parse(
                                                                        '${cubit.allActualities[index].date}')),
                                                                fontSize:
                                                                    TtextSize,
                                                                textColor:
                                                                    color[900]),
                                                            const SizedBox(
                                                              height: 4,
                                                            ),
                                                            text(
                                                                cubit
                                                                    .allActualities[
                                                                        index]
                                                                    .description,
                                                                fontSize:
                                                                    textSizeSMedium,
                                                                maxLine: 3),
                                                            const SizedBox(
                                                              height: 4,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16,
                                      ),
                                      Divider()
                                    ],
                                  ));
                            }),
                      ),
                    ],
                  ),
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
