import 'package:flutter/material.dart';

bool isEmailValid(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}

Widget heroWidget(String tag, Widget child) {
  return Hero(
      tag: tag,
      child: Material(
          animationDuration: const Duration(milliseconds: 700),
          type: MaterialType.transparency,
          color: Colors.transparent,
          child: child));
}
