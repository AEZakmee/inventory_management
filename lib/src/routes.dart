import 'package:inventory_management/src/widgets/old_version.dart';

import 'screens/screen_controller.dart';
import 'screens/edit_resource/add_quantity_screen.dart';
import 'screens/edit_resource/edit_resource_screen.dart';
import 'screens/loading/loading_screen.dart';
import 'package:flutter/material.dart';
import 'screens/sign_up/sign_up_screen.dart';
import 'screens/edit_product/edit_product_screen.dart';

final Map<String, WidgetBuilder> routes = {
  SignUpScreen.routeName: (context) => SignUpScreen(),
  MainScreen.routeName: (context) => MainScreen(),
  LoadingScreen.routeName: (context) => LoadingScreen(),
  EditProductScreen.routeName: (context) => EditProductScreen(),
  EditResourceScreen.routeName: (context) => EditResourceScreen(),
  EditResourceQuantityScreen.routeName: (context) =>
      EditResourceQuantityScreen(),
  OldVersionScreen.routeName: (context) => OldVersionScreen(),
};
