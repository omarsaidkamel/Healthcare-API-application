import 'package:flutter/material.dart';
import 'package:login/UI/loginUi.dart';
import 'MainHC.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/Login',
        routes: {
          '/Login': (context) => Login(),
          '/Main': (context) => MainHC(),
        },
      ),
    );
