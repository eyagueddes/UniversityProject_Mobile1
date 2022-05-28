import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:university_project_mobile/utils/images.dart';
import '../../components/styleWidget.dart';
import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/teacher.dart';
import '../../utils/colors.dart';

class teacher_screen extends StatefulWidget {
  const teacher_screen({Key? key}) : super(key: key);

  @override
  State<teacher_screen> createState() => _teacher_screenState();
}

class _teacher_screenState extends State<teacher_screen> {
  String query='';
  late List<dynamic> teachers;

  @override
  void initState() {
    super.initState();

  }
    TextEditingController?_textEditingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
        SchoolCubit()
          ..getTeachers(query)
          ..getUserData(),
        child: BlocConsumer<SchoolCubit, SchoolStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = SchoolCubit.get(context);
              teachers=cubit.allteachers;
              return SafeArea(
                child: Scaffold(
                  backgroundColor: context.scaffoldBackgroundColor,
                  body: Container(
                    child: Column(
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
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
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
                                          backgroundImage: cubit.profileImage !=
                                              null
                                              ? NetworkImage(cubit.profileImage)
                                              : NetworkImage(noImageAsset),
                                        ),
                                        // ClipRRect(
                                        //   child: cubit.profileImage != null
                                        //       ? CachedNetworkImage(
                                        //           placeholder: (context, url) =>
                                        //               placeholderWidget(),
                                        //           imageUrl: cubit.profileImage,
                                        //         )
                                        //       : CachedNetworkImage(
                                        //           placeholder: (context, url) =>
                                        //               placeholderWidget(),
                                        //           imageUrl: noImageAsset,
                                        //         ),
                                        //   borderRadius:
                                        //       BorderRadius.circular(50),
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              transform:
                              Matrix4.translationValues(0.0, 60.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: white,
                                      borderRadius:
                                      const BorderRadius.all(
                                          Radius.circular(26)),
                                      boxShadow: defaultBoxShadow()),
                                  child: Stack(
                                    alignment: Alignment.centerRight,
                                    children: <Widget>[
                                      TextField(
                                          onChanged: (value){
                                            setState((){
                                              searchTeacher(value);
                                               print(teachers);
                                            });
                                          },
                                          controller: _textEditingController,
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: white,
                                              hintText: 'Recherche',
                                              contentPadding: const EdgeInsets
                                                  .only(
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
                            itemCount: teachers.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(8),
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                color: appStore.appBarColor,
                                margin: const EdgeInsets.all(8),
                                elevation: 2,
                                child: ListTile(
                                  onTap: () {
                                    toasty(
                                      context,
                                     teachers[index]['email'],
                                    );
                                  },
                                  leading: ClipRRect(
                                    child: CachedNetworkImage(
                                      progressIndicatorBuilder: (context, url,
                                          downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                      imageUrl:
                                      "${teachers[index]['avatar']}" !=
                                          ""
                                          ? "${teachers[index]['avatar']}"
                                          : noImageAsset,
                                    ),

                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  //  CircleAvatar(radius: 20, backgroundImage: CloudinaryImage(cubit.allteachers[index]['image'])),
                                  title: Text(
                                    teachers[index]['name'] +
                                        ' ' +
                                        teachers[index]['LastName'],
                                    style: boldTextStyle(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Container(
                                    margin: EdgeInsets.only(top: 4),
                                    child: Text(
                                        teachers[index]['email']!,
                                        style: secondaryTextStyle()),
                                  ),

                                  // trailing: Container(
                                  //   padding: EdgeInsets.only(right: 4),
                                  //   child: Icon(
                                  //     Icons.copy,
                                  //     color: appStore.iconColor,
                                  //     size: 14,
                                  //   ),
                                  // ),
                                  trailing: Text("${cubit.allteachers[index]['grade']}",style: TextStyle(color: logosColors),),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }));
  }
  void searchTeacher(String query) {
    print('goo ');
    final teachers = SchoolCubit().allteachers.where((element) =>element.contains(query)).toList();

      // final lastnameLower = element.LastName.toLowerCase();
      // final nameLower = element.name.toLowerCase();
      // final emailLower = element.email?.toLowerCase();
      // final gradeLower = element.grade?.toLowerCase();
      // final searchLower = query.toLowerCase();
      // print (lastnameLower);
      // return emailLower!.contains(searchLower) ||
      //     nameLower.contains(searchLower) ||
      //     lastnameLower.contains(searchLower) ||
      //     gradeLower.contains(searchLower);



    setState(() {
      this.query = query;
      this.teachers = teachers;
    });
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

