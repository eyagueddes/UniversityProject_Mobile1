import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SchoolCubit()..getUserData(),
        child: BlocConsumer<SchoolCubit, SchoolStates>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = SchoolCubit.get(context);
              return Scaffold(
                body: cubit.screens[cubit.currentIndex],
                bottomNavigationBar: Container(
                  height: 80,
                  child: CurvedNavigationBar(
                    backgroundColor: logosColors,
                    color: Colors.white,
                    items: <Widget>[
                      SvgPicture.asset(
                        assetHome,
                        height: 24,
                        width: 24,
                        fit: BoxFit.none,
                        color: logosColors,
                      ),
                      SvgPicture.asset(assetUser,
                          height: 24,
                          width: 24,
                          fit: BoxFit.none,
                          color: logosColors),
                      SvgPicture.asset(assetEdit,
                          height: 24,
                          width: 24,
                          fit: BoxFit.none,
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
