import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:university_project_mobile/utils/colors.dart';
class T8Button extends StatefulWidget {
  var textContent;

  //   var icon;
  VoidCallback onPressed;

  T8Button({
    required this.textContent,
    required this.onPressed,
    //   @required this.icon,
  });

  @override
  T8ButtonState createState() => T8ButtonState();
}
class T8ButtonState extends State<T8Button> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
          decoration: BoxDecoration(color: logosColors),
          padding: EdgeInsets.fromLTRB(16, 10, 16, 10),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Center(
                child: Text(widget.textContent,style: TextStyle(color: Colors.white),),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, ),
                  width: 35,
                  height: 35,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.arrow_downward_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}