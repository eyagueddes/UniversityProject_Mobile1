import 'package:flutter/material.dart';

import '../../components/activityIndicator.dart';
class profile_screen extends StatefulWidget {
  const profile_screen({Key? key}) : super(key: key);

  @override
  State<profile_screen> createState() => _profile_screenState();
}

class _profile_screenState extends State<profile_screen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ActivityIndicatorScreen(),
    );

      Center(
    child:Text('Profile'),
    );
  }
}
