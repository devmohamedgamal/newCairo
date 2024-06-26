// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors
import 'package:newcairo/util/textStyle.dart';
import 'package:flutter/material.dart';

class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintTxt;
  final String? image;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  CustomPasswordTextField(
      {this.controller,
      this.hintTxt,
      this.image,
      this.focusNode,
      this.nextNode,
      this.textInputAction});
  @override
  _CustomPasswordTextFieldState createState() =>
      _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).highlightColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 1)) // changes position of shadow
        ],
      ),
      child: TextFormField(
        cursorColor: Theme.of(context).primaryColor,
        controller: widget.controller,
        obscureText: _obscureText,
        focusNode: widget.focusNode,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        onFieldSubmitted: (v) {
          setState(() {
            widget.textInputAction == TextInputAction.done
                ? FocusScope.of(context).consumeKeyboardToken()
                : FocusScope.of(context).requestFocus(widget.nextNode);
          });
        },
        validator: (value) {
          return null;
        },
        decoration: InputDecoration(
            suffixIcon: IconButton(
                icon: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility),
                onPressed: _toggle),
            // prefixIcon: Padding(padding: EdgeInsets.all(10), child: SvgPicture.asset(widget.image!)),
            hintText: widget.hintTxt ?? '',
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
            isDense: true,
            filled: true,
            fillColor: Theme.of(context).highlightColor,
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor)),
            hintStyle:
                cairoRegular.copyWith(color: Theme.of(context).hintColor),
            border: InputBorder.none),
      ),
    );
  }
}
