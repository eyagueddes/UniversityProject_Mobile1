import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import '../components/curvedNavigationBar.dart';
import '../layout/cubit/cubit.dart';
import '../utils/colors.dart';
import '../utils/images.dart';
import 'cubit/states.dart';

class school_Layout extends StatefulWidget {
  const school_Layout({Key? key}) : super(key: key);
  @override
  State<school_Layout> createState() => _school_LayoutState();
}
class _school_LayoutState extends State<school_Layout> {
  void initState() {
     print("eya,${SchoolCubit.get(context).studentData?.name}");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SchoolCubit()..getUserData(),
        child: BlocConsumer<SchoolCubit, SchoolStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = SchoolCubit.get(context);
              return Scaffold(
               // appBar: mainAppBar("${context.watch<SchoolCubit>().studentModel?.data?.name}"),
                body: cubit.screens[cubit.currentIndex],
                bottomNavigationBar: Container(
                  height: 80,
                  child: CurvedNavigationBar(
                    backgroundColor: logosColors,
                    color: Colors.white,
                    items: <Widget>[
                      SvgPicture.asset(
                        assetHome,
                        height: 28,
                        width: 28,
                        fit: BoxFit.scaleDown,
                        color: logosColors ,
                      ),
                      SvgPicture.asset(assetUser,
                          height: 24,
                          width: 24,
                          fit: BoxFit.none,
                          color: logosColors),
                      SvgPicture.asset(assetEdit,
                          height: 28,
                          width: 28,
                          fit: BoxFit.scaleDown,
                          color: logosColors),
                    ],
                    onTap: (index) {
                      cubit.changeBottomNav(index);
                                },
                  ),
                ),
              );
            }));
  }
}
