import 'package:flutter/material.dart';
import 'package:university_project_mobile/utils/colors.dart';
import 'package:university_project_mobile/utils/images.dart';

class profile_screen extends StatelessWidget {
  static var tag = "ProfileInfo";

  @override
  Widget build(BuildContext context) {
    final profileImg = Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: FractionalOffset.center,
      child: const CircleAvatar(
        backgroundColor: Colors.white,
        radius: 50,
      ),
    );
    final profileContent = Container(
      margin: const EdgeInsets.only(top: 55.0),
      decoration: BoxDecoration(
          color: logosColors, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50),
            const Text('Eya gueddes',
                style: TextStyle(
                    color: Colors.white, fontSize: 14, fontFamily: 'Roboto')),
            const Text('eyagueddes1@gmail.com',
                style: TextStyle(
                    color: Colors.white, fontSize: 12, fontFamily: 'Roboto')),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Divider(color: Colors.grey, height: 0.5),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 90, left: 2, right: 2),
        physics: const ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            const SizedBox(height: 16),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Stack(
                children: <Widget>[profileContent, profileImg],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: const <Widget>[
                    SizedBox(height: 8),
                    SizedBox(height: 16),
                    Text('name'),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                      //  child: view(),
                    ),
                    SizedBox(height: 8),
                    Text("Male"),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                      // child: view(),
                    ),
                    SizedBox(height: 8),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: const <Widget>[
                    SizedBox(height: 8),
                    Text("+91 36982145"),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
                      //  child: view(),
                    ),
                    SizedBox(height: 8),
                    Text("Astoncina@gmail.com"),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
