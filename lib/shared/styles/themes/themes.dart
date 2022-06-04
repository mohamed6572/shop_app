import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData darkTheme = ThemeData(
  fontFamily: 'test',
    primarySwatch: defColor,
    scaffoldBackgroundColor: HexColor('333749'),
    appBarTheme:  AppBarTheme(
        titleSpacing: 20.0,
        elevation: 0.0,
        titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22.0
        ),
        backgroundColor: HexColor('333749'),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333749'),
          statusBarIconBrightness: Brightness.light,

        ),
        iconTheme: IconThemeData(
            color: Colors.white
        )
    ),
    bottomNavigationBarTheme:  BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      elevation: 20.0,
      backgroundColor: HexColor('333749'),
      unselectedItemColor: Colors.grey,
      selectedItemColor: defColor,
    ),
    textTheme: TextTheme(
    )
);


ThemeData lightTheme = ThemeData(
    fontFamily: 'test',
    primarySwatch: defColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20.0,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 22.0
    ),
    backgroundColor: Colors.white,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,

    ),
    iconTheme: IconThemeData(
      color: Colors.black
    )
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    elevation: 20.0,
    backgroundColor: Colors.white,
    unselectedItemColor: Colors.grey,
    selectedItemColor: defColor,
  ),
  textTheme: TextTheme(
  )
);