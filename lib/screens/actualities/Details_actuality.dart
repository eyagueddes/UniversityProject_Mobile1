import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:university_project_mobile/models/actualities.dart';
import 'package:university_project_mobile/utils/colors.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../utils/images.dart';

class details_actuality extends StatelessWidget {
  final ActualityModel? actuality ;
  const details_actuality({Key? key,required this.actuality}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    var width = MediaQuery.of(context).size.width;
    changeStatusColor(Colors.transparent);
    return BlocConsumer<SchoolCubit, SchoolStates>(
        listener: (context, state) {},
        builder: (context, state) {

          var cubit = SchoolCubit.get(context);
          // image=cubit.profileImage;
          // print(image);

          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    expandedHeight: 200.0,
                    floating: false,
                    pinned: true,
                    titleSpacing: 0,
                    backgroundColor: white,
                    actionsIconTheme: IconThemeData(opacity: 0.0),
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: !innerBoxIsScrolled ? logosColors : Colors.black),
                        onPressed: () {
                         Navigator.pop(context);
                        }),
                    flexibleSpace: FlexibleSpaceBar(
                        background: CachedNetworkImage(
                          imageUrl: "${actuality!.image}" !=
                              ""
                              ? "${actuality!.image}"
                              : 'https://delta-expert.fr/wp-content/uploads/2017/11/cest-nouveau-2-272x185.png',
                          progressIndicatorBuilder: (context,
                              url,
                              downloadProgress) =>
                              CircularProgressIndicator(
                                  value:
                                  downloadProgress
                                      .progress),
                          fit: BoxFit.fill,

                        )),
                  ),
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
                        children: <Widget>[Row(

                          children: [
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
                              width:  width/10,
                              height:width/ 10,
                              padding: EdgeInsets.all(10),
                              child: SvgPicture.asset(
                                assetActualities,color: white,),
                            ),
                              SizedBox(
                                width: 10,
                              ),
                            Text(actuality!.subject, style: boldTextStyle(size: 18)),
                          ],
                        )],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Text('Date', style: boldTextStyle(size: 18)),
                          const SizedBox(
                            width: 10,
                          ),
                          Text( dateFormat.format(
                              DateTime.parse(
                              '${actuality!.date}')), style: primaryTextStyle(size: 14)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text('description'.toUpperCase(), style: boldTextStyle(size: 18,color: logosColors),),
                      const SizedBox(
                        height: 10,
                      ),
                      Text('${actuality!.description}', style: primaryTextStyle(size: 16)),
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
          );
        });
  }
  Widget placeholderWidget() => Image.asset('images/LikeButton/image/grey.jpg', fit: BoxFit.cover);

  void changeStatusColor(Color color) async {
    setStatusBarColor(color);
  }
}
