import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:university_project_mobile/layout/cubit/cubit.dart';
import 'package:university_project_mobile/layout/cubit/states.dart';
import 'package:university_project_mobile/utils/colors.dart';
import 'package:university_project_mobile/utils/images.dart';
import 'package:university_project_mobile/utils/assetsHomePage.dart';
import '../../components/search_bar.dart';
import '../../helper/Navigation.dart';
import '../../helper/cache_helper.dart';
import '../Login/login.dart';


class home_screen extends StatelessWidget {
  const home_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider(
        create: (BuildContext context) => SchoolCubit()..getUserData(),
        child: BlocConsumer<SchoolCubit, SchoolStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = SchoolCubit.get(context);
              return Scaffold(
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipPath(
                          clipper:
                              CustomShape(), // this is my own class which extendsCustomClipper
                          child: Container(
                            color: logosColors,
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            backgroundImage:cubit.profileImage!=null? NetworkImage(cubit.profileImage):NetworkImage(noImageAsset),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Bonjour ${cubit.studentData?.name} ${cubit.studentData?.LastName}"
                                                    .capitalizeFirstLetter(),
                                                style: boldTextStyle(
                                                    fontFamily:
                                                    fontFamilyBoldGlobal,
                                                    color: white),
                                              ).paddingOnly(bottom: 2),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Container(
                                        width:45,
                                        height: 35,
                                          child:TextButton(
                                              onPressed: (){
                                                CacheHelper.removeData(
                                                  key: 'token',
                                                ).then((value)
                                                {
                                                  print('logout');
                                                  if (value)
                                                  {
                                                    navigateAndFinish(
                                                      context,
                                                      LoginScreen(),
                                                    );
                                                  }
                                                });
                                              },
                                                child: SvgPicture.asset(
                                              logoutAsset,
                                              height: 25,
                                              fit: BoxFit.scaleDown,
                                              color: Colors.white,
                                            ),
                                          )
                                      ),
                                      //search_bar(),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 70),
                          child: Positioned(
                            top: 60,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: size.height * 0.25,
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 5,
                                  child: Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Center(
                                        child: Column(
                                          children: <Widget>[
                                            Row(
                                              children: [
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(
                                                          assetEdit,
                                                          color: logosColors,
                                                          width:
                                                              size.width * 0.05,
                                                        ),
                                                        const Text('Actualités',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    'Roboto',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                      ],
                                                    ),
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20),
                                                      child: Text(
                                                          'Lorem ipsum dolor sit amet, consectetur \n adipiscing  '
                                                          'dolor sit amet,em ipsum \n dolor sit amet, co olor sit amet, co\n sit amet, co olor',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              fontFamily:
                                                                  'Roboto',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 20.0, right: 20),
                        child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            physics: ScrollPhysics(),
                            itemCount: Assets.Cards.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              mainAxisExtent: size.height * 0.13,
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            cubit.Homescreens[cubit.currentIndex],
                                      ));
                                  cubit.changeCardIndex(index);
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 20, bottom: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: shadowColor,
                                        offset: Offset(5, 5),
                                        blurRadius: 5.0,
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          children: [
                                            SvgPicture.asset(
                                              '${Assets.Cards[index]['image']}',
                                              color: logosColors,
                                              width: size.width * 0.1,
                                              height: size.height * 0.04,
                                              semanticsLabel: 'Acme Logo',
                                            ),
                                            SizedBox(
                                              width: size.width * 0.01,
                                            ),
                                            Text(
                                                '${Assets.Cards[index]['title']}',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}

class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
