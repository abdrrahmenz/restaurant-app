import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final ValueChanged onChanged;
  final String hintText;
  final Function onFieldSubmit;
  final TextEditingController controller;
  final Function onComplete;
  final EdgeInsets margin;

  const CustomTextField({
    Key key,
    this.onChanged,
    this.hintText,
    this.onFieldSubmit,
    this.controller,
    this.onComplete,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      margin: margin,
      child: Platform.isIOS
          ? CupertinoTextField(
              controller: controller,
              onChanged: onChanged,
              onSubmitted: onFieldSubmit,
              onEditingComplete: onComplete,
              placeholder: hintText ?? 'TextField',
              padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
            )
          : TextFormField(
              onChanged: onChanged,
              onFieldSubmitted: onFieldSubmit,
              onEditingComplete: onComplete,
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText ?? 'TextField',
                contentPadding: EdgeInsets.fromLTRB(15, 5, 15, 6),
                border: _border(context),
                disabledBorder: _border(context),
                enabledBorder: _border(context),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).accentColor,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
              ),
            ),
    );
  }

  OutlineInputBorder _border(BuildContext context) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: Theme.of(context).accentColor,
        width: 2,
        style: BorderStyle.solid,
      ),
    );
  }
}
