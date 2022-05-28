
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';


class DefaultFormField extends StatelessWidget {

  final TextEditingController controller;
  final TextInputType keyboardType ;
  final String? Function(String?)? validation ;
  final String? label ;
  Color? labelColor ;
  Color? textInputColor ;
  Color? textFieldColor ;
  bool? isPassword ;
  IconData? suffix;
  Color? fillColor ;
  Function()? pressSuffix ;
  String? hint ;
  int? maxLine ;
  String? prefix;


  DefaultFormField({required this.controller,
    required this.keyboardType,
    required this.validation,
    this.label,
    this.labelColor,
    this.textInputColor,
    this.textFieldColor,
    this.isPassword,
    this.suffix,
    this.fillColor,
    this.pressSuffix,
    this.hint,
    this.maxLine,
    this.prefix
  });


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.7,
      //height: MediaQuery.of(context).size.height*0.080,


      child: TextFormField(
        //cursorHeight: 22,
        maxLines: maxLine ?? 1,
        style: TextStyle(color:textInputColor,fontSize: 17,fontWeight: FontWeight.w500),
        //style : GoogleFonts.rubik(color: textInputColor,fontSize: 18,fontWeight: FontWeight.w500),
        controller:controller,
        //textAlign: TextAlign.center,
        keyboardType:keyboardType,
        validator: validation,
        obscureText: isPassword ?? false,
        decoration: InputDecoration(
          suffixIcon: IconButton(onPressed: (pressSuffix), icon: Icon(suffix,color: textInputColor,)),
          hintText:hint,
          contentPadding:EdgeInsets.only(bottom: 0,top: 0,left: 10.0),
          filled: true,
          fillColor:fillColor ?? kWhite,
          errorBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: logosColors,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: logosColors,
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Colors.transparent,
              width: 2.0,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: kWhite,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: kWhite,
            ),
          ),

          //hintText: hint,
          label: Text(label!),

          labelStyle: GoogleFonts.quicksand(

            //TODO:add varible color as attribut
              color: labelColor ?? kBlack,
              fontSize: 16,
              fontWeight: FontWeight.w500

          ),

        ),
      ),
    );
  }

}
