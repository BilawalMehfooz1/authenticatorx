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

const gradient1 = LinearGradient(
  colors: [authBackColor1, authBackColor2],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const gradient2 = LinearGradient(
  colors: [
    Color.fromARGB(255, 3, 26, 41),
    Color.fromRGBO(1, 31, 20, 1),
  ],
  begin: Alignment.centerLeft,
  end: Alignment.bottomRight,
);

final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: blueColor),
  primaryColor: whiteColor,
  brightness: Brightness.light,
);

final darkTheme = ThemeData(
  primaryColor: blackColor,
  brightness: Brightness.dark,
);
