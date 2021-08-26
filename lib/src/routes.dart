import 'screens/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'screens/main/main_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SignUpScreen.routeName: (context) => SignUpScreen(),
  MainScreen.routeName: (context) => MainScreen(),
  LoadingScreen.routeName: (context) => LoadingScreen(),
};
