import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityIndicatorScreen extends StatefulWidget {
  static String tag = '/ActivityIndicatorScreen';

  @override
  ActivityIndicatorScreenState createState() => ActivityIndicatorScreenState();
}

class ActivityIndicatorScreenState extends State<ActivityIndicatorScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {}

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Theme(
          data: ThemeData.light(),
          child: CupertinoActivityIndicator(
            animating: true,
            radius: 20,
          ),
        ),
      ),
    );
  }
}

