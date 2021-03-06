import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:university_project_mobile/screens/HomeScreen/HomeScreen.dart';
import 'package:university_project_mobile/utils/images.dart';
import '../../components/activityIndicator.dart';
import '../../components/styleWidget.dart';
import '../../layout/cubit/states.dart';
import '../../utils/colors.dart';
import 'package:university_project_mobile/layout/cubit/cubit.dart';
import '../../utils/constants.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:intl/intl.dart';

import '../updateProfile/Update_profile.dart';
class profile_screen extends StatefulWidget {
  const profile_screen({Key? key}) : super(key: key);

  @override
  State<profile_screen> createState() => _profile_screenState();
}
class _profile_screenState extends State<profile_screen> {
  double? width;


  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SchoolCubit()..getUserData(),
   child:  BlocConsumer<SchoolCubit, SchoolStates>(
        listener: (context, state) {},
    builder: (context, state) {
      width = MediaQuery.of(context).size.width;
    var cubit = SchoolCubit.get(context);
      DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    // changeStatusColor(t5DarkNavy);
    // final cloudinaryImage = CloudinaryImage("${context.read<SchoolCubit>().studentData?.avatar}");
    // String transformedUrl = cloudinaryImage.toString();
  //  DateTime dt=  DateTime.parse("${context.watch<SchoolCubit>().studentData?.dateBirth}");
  return state is SchoolLoadingUserDataState ? Center(child: CircularProgressIndicator()) : Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(

        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.topCenter,
              height: width,
              child: Container(
                height: 100.0,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      logosColors,
                      gradient_color,
                      logosColors,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // IconButton(
                    //   icon: Icon(Icons.keyboard_arrow_left, size: 40, color: t5White),
                    //   onPressed: (){
                    //     Navigator.pop(context);
                    //   },
                    // ),
                    //SizedBox(width:MediaQuery.of(context).size.width*0.18),

                    Center(
                      child: text("PROFILE",
                          textColor: t5White,
                          fontSize: textSizeLarge,
                          fontFamily: fontBold),
                    ),
                    //Spacer(),
                    // Padding(
                    //   padding: EdgeInsets.only(right: 16.0),
                    //    child: Container(
                    //      width: 28,
                    //      height: 28,
                    //      child: FloatingActionButton(
                    //        onPressed: () {
                    //          print('pressed');
                    //          Navigator.push(
                    //              context,
                    //              MaterialPageRoute(
                    //                  builder: (context) => update_profile()));
                    //        },
                    //        child: Icon(Icons.edit, color: t2TextColorPrimary),
                    //        backgroundColor: t2_white,
                    //      ),
                    //    ),
                    // ),

                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 80),
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    padding: EdgeInsets.only(top: 60),
                    alignment: Alignment.topCenter,
                    decoration: const BoxDecoration(
                        color:   white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24))),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        text("${context.watch<SchoolCubit>().studentData?.name} ${context.watch<SchoolCubit>().studentData?.LastName}".capitalizeFirstLetter(),
                            textColor: t5TextColorPrimary,
                            fontFamily: fontMedium,
                            fontSize: textSizeNormal),
                        if(SchoolCubit().studentData?.email != "null")
                        text("${context.watch<SchoolCubit>().studentData?.email}", fontSize: textSizeLargeMedium),

                        Container(
                          margin: EdgeInsets.fromLTRB(16, 8, 16, 8),

                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 8),
                                rowHeading('Donn??es personnelles '),
                                SizedBox(height: 16),
                                Row(
                                  children: [
                                    profileText('Nom :'),
                                    text("${context.watch<SchoolCubit>().studentData?.LastName}", fontSize: TtextSize),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                                  child: view(),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                  profileText('Pr??nom :'),
                                  text("${context.watch<SchoolCubit>().studentData?.name}", fontSize: TtextSize),
                                ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                                  child: view(),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    profileText('Genre :',maxline: 2),
                                    if(SchoolCubit().studentData?.gender !=null.toString())
                                    text("${context.watch<SchoolCubit>().studentData?.gender}", fontSize: TtextSize),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                                  child: view(),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    profileText('email :' , maxline: 2),
                                   if(SchoolCubit().studentData?.email != null.toString())
                                      text("${context.watch<SchoolCubit>().studentData?.email}", fontSize: TtextSize),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                                  child: view(),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    profileText('Date de naissance :', maxline: 2),
                                  if(SchoolCubit().studentData?.dateBirth !=null)
                                      text(dateFormat.format(DateTime.parse("${context.read<SchoolCubit>().studentData?.dateBirth}")), fontSize: TtextSize),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                                  child: view(),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [

                                    profileText('Num??ro de T??lephone :',maxline: 2),
                                    if(SchoolCubit().studentData?.phone !='null')
                                    text("${context.watch<SchoolCubit>().studentData?.phone}", fontSize: TtextSize),
                                  ],
                                ),


                                Padding(
                                  padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                                  child: view(),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        profileText('pays :',maxline: 2),
                                        if(SchoolCubit().studentData?.country !=null.toString())
                                        text("${context.watch<SchoolCubit>().studentData?.country}", fontSize: TtextSize),
                                      ],
                                    ),

                                  ],
                                ),
                              //  if(SchoolCubit().studentData?.country != null)

                                Padding(
                                  padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                                  child: view(),
                                ),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    profileText('Gouvernement :',maxline: 2),
                                    if(SchoolCubit().studentData?.government !=null.toString())
                                    text("${context.watch<SchoolCubit>().studentData?.government}", fontSize: TtextSize),
                                  ],
                                ),
                              //  if(SchoolCubit().studentData?.government != null)
                                Padding(
                                  padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                                  child: view(),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    profileText('Adresse :',maxline: 2),
                                    if(SchoolCubit().studentData?.adress !=null.toString())
                                    text("${context.watch<SchoolCubit>().studentData?.adress}", fontSize: TtextSize),
                                  ],
                                ),
                               // if(SchoolCubit().studentData?.adress != null)

                                Padding(
                                  padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                                  child: view(),
                                ),


                              ],
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.fromLTRB(16, 8, 16, 8),
                          // decoration: boxDecoration(
                          //     bgColor: context.scaffoldBackgroundColor,
                          //     radius: 10,
                          //     showShadow: true),
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 8),
                                rowHeading('Donn??es Universitaires '),
                                SizedBox(height: 16),

                                Row(
                                  children: [
                                    profileText("Num??ro d'inscription"),
                                    text("${context.watch<SchoolCubit>().studentData?.numInscription}",fontSize: TtextSize),],
                                ),
                                SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        const Padding(
                          padding: EdgeInsets.only(right: 16.0),
                          //  child: SvgPicture.asset(t5_options, width: 25, height: 25, color: t5White),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(backgroundImage: cubit
                      .profileImage !=
                  null
                  ? NetworkImage(
                  cubit.profileImage)
              : NetworkImage(noImageAsset) , radius: 50),
                  //  CircleAvatar(backgroundImage: CachedNetworkImageProvider(t5_profile_8), radius: 50)
                ],
              ),
            ),
          ],
        ),
      ),
    );
    }),
    );
  }
}
