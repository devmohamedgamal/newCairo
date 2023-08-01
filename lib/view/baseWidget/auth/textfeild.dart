// -------------------------------------------------------
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final  TextEditingController controller ;
  final  PaddingHorizontal ;
  final  MarginVertical ;
  final  Function validator ;
   final  bool obscureText ;
  final TextStyle TxtStyle ;
  final Widget icon ;
  final Color fillColor ;
  final  Color  prefixIconColor ;
  final String label ;
  final String hint ;
  final String suffixText ;
  final String prefixText ;
  const CustomInput({
    required this.controller,
    this.PaddingHorizontal,
    this.MarginVertical,
    required this.validator,
     required this.obscureText,
    required this.TxtStyle,
    required this.icon,
    required this.fillColor,
    required this.prefixIconColor,
    required this.label,
    required this.hint,
    required this.suffixText,
    required this.prefixText
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal:  PaddingHorizontal,
      ),
      margin: EdgeInsets.symmetric(
        vertical: MarginVertical ,
      ),
      child: TextFormField(
        controller: controller,
        validator: (vaue) =>validator (vaue)  ,
        //emailAddress - numbers / date
        keyboardType: TextInputType.text,
        // maxLength: 20,
        obscureText: obscureText, //password type

        // maxLines: 3, // textarea
        style: TxtStyle,
        decoration: InputDecoration(
          icon: icon ,
          //   enabledBorder: UnderlineInputBorder - OutlineInputBorder
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(
                color: Color(0xffcccccc).withOpacity(0.3),
                width: 1,
              )),
          focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 147, 14, 72)
                    .withOpacity(0.9),
                width: 1,
              )),

          filled: true,
          fillColor: fillColor,
          hintText:  hint,
          label: Text( label),
         // prefixIcon: Icon(Icons.search),
          prefixIconColor: prefixIconColor,
          prefixText: prefixText,
       //   suffixIcon: Icon(Icons.arrow_forward),
          suffixText: suffixText,

          // enabled: false,
        ),
        // initialValue: '',
      ),
    );
  }
}



class CustomsearchInput extends StatelessWidget {
 // final  TextEditingController controller ;
  final  PaddingHorizontal ;
  final  MarginVertical ;
  final  Function validator ;
  final  bool obscureText ;
  final TextStyle TxtStyle ;
  final Widget icon ;
  final Color fillColor ;
  final  Color  prefixIconColor ;
  final String label ;
  final String hint ;
  final String suffixText ;
  final String prefixText ;
  const CustomsearchInput({
   // required this.controller,
    this.PaddingHorizontal,
    this.MarginVertical,
    required this.validator,
    required this.obscureText,
    required this.TxtStyle,
    required this.icon,
    required this.fillColor,
    required this.prefixIconColor,
    required this.label,
    required this.hint,
    required this.suffixText,
    required this.prefixText
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal:  PaddingHorizontal,
      ),
      margin: EdgeInsets.symmetric(
        vertical: MarginVertical ,
      ),
      child: TextFormField(
     //   controller: controller,
        validator: (vaue) =>validator (vaue)  ,
        //emailAddress - numbers / date
        keyboardType: TextInputType.text,
        // maxLength: 20,
        obscureText: obscureText, //password type

        // maxLines: 3, // textarea
        style: TxtStyle,
        decoration: InputDecoration(
         // icon: icon ,
          //   enabledBorder: UnderlineInputBorder - OutlineInputBorder
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(
                color: Color(0xffcccccc).withOpacity(0.3),
                width: 1,
              )),
          focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(7),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 147, 14, 72)
                    .withOpacity(0.9),
                width: 1,
              )),

          filled: true,
          fillColor: fillColor,
          hintText:  hint,
          label: Text( label),
          // prefixIcon: Icon(Icons.search),
          prefixIconColor: prefixIconColor,
          prefixText: prefixText,
          prefixIcon: icon,
          //   suffixIcon: Icon(Icons.arrow_forward),
          suffixText: suffixText,

          // enabled: false,
        ),
        // initialValue: '',
      ),
    );
  }
}