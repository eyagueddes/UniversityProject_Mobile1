import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:university_project_mobile/utils/colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
Widget defaultTextField({
  double width = 5,
  double height = 5,
  Color background = Colors.white,
  Color svgColor = logosColors,
  String svgAsset = '',
  String text = '',
  required FormFieldValidator validate,
  Function? onChange,
  bool isPassword = false,
  required TextEditingController controller,
  required TextInputType type,
  Function()? suffixPressed,
  IconData? suffix,
}) =>
    TextFormField(
      controller: controller,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
       suffixIcon: IconButton(icon: Icon(suffix),onPressed: suffixPressed),
        prefixIcon: SizedBox(
          child: SvgPicture.asset(svgAsset,
              semanticsLabel: 'Acme Logo',
              color: svgColor,
              height: height,
              width: width,
              fit: BoxFit.scaleDown),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(width: 1, color: Colors.white),
        ),
        hintText: text,
        hintStyle: const TextStyle(color: Colors.black87),
        alignLabelWithHint: false,
        filled: true,
        fillColor: Colors.white,
      ),
      cursorColor: Colors.black,
      obscureText: isPassword,
      keyboardType: type,
      textInputAction: TextInputAction.done,
      onChanged: onChange as void Function(String)?,
      validator: validate,
    );
// mixin InputValidationMixin {
//   bool isPasswordValid(String password) => password.length == 6;
//
//   bool isEmailValid(String email) {
//     Pattern pattern ='^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))';
//     RegExp regex = RegExp(pattern);
//     return regex.hasMatch(email);
//   }
// }
Widget defaultButton({
   Function? function,
  Color background = logosColors,
  Function? onSubmit,
  @required VoidCallback? onPressed,
  String text = '',
}) =>
    ElevatedButton(
      onPressed: onPressed  ,
      style: ElevatedButton.styleFrom(
        primary: background,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 15, color: Colors.white),
      ),
    );

void showToast({
  required String text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}
