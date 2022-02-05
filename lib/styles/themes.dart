// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/styles/colors.dart';

darkTheme() => ThemeData(
      scaffoldBackgroundColor: HexColor("#292929"),
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backwardsCompatibility: false,
        color: HexColor("#292929"),
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: HexColor("#292929"),
            statusBarBrightness: Brightness.light),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      primarySwatch: defaultColor,
      primaryColorLight: Colors.white,
      backgroundColor: HexColor("#292929"),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: HexColor("#292929"),
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          unselectedItemColor: Colors.grey,
          selectedIconTheme: IconThemeData(
            size: 35,
          ),
          selectedItemColor: defaultColor),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
lightTheme() => ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backwardsCompatibility: false,
        color: Colors.white,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white, statusBarBrightness: Brightness.dark),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      primaryColorLight: HexColor("#292929"),
      backgroundColor: Colors.white,
      primarySwatch: defaultColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          selectedIconTheme: IconThemeData(
            size: 35,
          ),
          selectedItemColor: defaultColor),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
