import 'package:flutter/material.dart';

class TextFormFieldTheme {
  TextFormFieldTheme._();
  static InputDecorationTheme textFieldInputDecorationTheme =
      const InputDecorationTheme(
          // Todo: prefixIconColor: color,
          // Todo: floatingLabelStyle: TextStyle(color: color),
          border: OutlineInputBorder(),
          // Todo: labelStyle: TextStyle(color: color),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2.0,
              //Todo: color: color,
            ),
          ));
}
