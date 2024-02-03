import 'dart:ui' show PointerDeviceKind;



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iserve_billing/screens/notes/note_home_try.dart';

import 'package:iserve_billing/screens/vidz.dart';
import 'package:iserve_billing/settings.dart';
import 'package:iserve_billing/sign_ups/login_page.dart';


import 'localiztion.dart';
import 'maps/map_page.dart';
import 'navs.dart';



void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations:LocalString(),
      locale: Locale('en','US'),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
        },
      ),
      debugShowCheckedModeBanner: false,
      home:BottomNavigationExample(),//VideoApp(),//BottomNavigationExample(),//MapPage(),//BottomNavigationExample(),//LoginScreen(),//BottomNavigationExample(),//HomePage(),//HomeScreen(),//BottomNavigationExample(),//LoginPage(),//BottomNavigationExample(),//DashboardScreen(),//BottomNavigationExample(),//MetersList(),//Home(),//PlanetList(),//Home(),// const HomeScreen(),
     // theme: AppTheme.lightAppTheme,
    );
  }
}
