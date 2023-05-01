import 'package:flutter/material.dart';
import 'package:flutter_application_login/pages/login_page.dart';

void main() {
  runApp(MaterialApp(
    title: 'login app',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const LoginPage(),
  ));
}
