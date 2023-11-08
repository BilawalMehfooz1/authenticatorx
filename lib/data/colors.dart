import 'package:flutter/material.dart';

const greyColor = Colors.grey;
const whiteColor = Colors.white;
const blackColor = Colors.black;
const blueColor = Color.fromRGBO(0, 100, 224, 1);
const authBackColor1 = Color.fromRGBO(241, 54, 86, 0.1);
const authBackColor2 = Color.fromRGBO(83, 197, 237, 0.1);

const gradient = LinearGradient(
  colors: [authBackColor1, authBackColor2],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

final lightTheme = ThemeData(
  primaryColor: whiteColor,
  brightness: Brightness.light,
);

final darkTheme = ThemeData(
  primaryColor: blackColor,
  brightness: Brightness.dark,
);
