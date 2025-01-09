import 'package:flutter/material.dart';
import 'package:flutter_project/Pages/ContactReadPage.dart';
import 'package:flutter_project/Pages/HomePage.dart';
import 'package:flutter_project/Pages/RegisterPage.dart';
import 'package:flutter_project/Pages/WelcomePage.dart';
import 'Pages/LoginPage.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => MyHome(),
      'register': (context) => MyRegister(),
      'login': (context) => MyLogin(),
      'welcome': (context) => MyWelcome(),
      'contactRead': (context) => MyContactReadPage()
    },
  )); //MaterailApp
}
