import 'dart:async';
import 'package:inventory_management/src/model/user.dart';
import 'package:inventory_management/src/providers/user_provider.dart';
import 'package:inventory_management/src/widgets/disposable_widget.dart';
import 'package:provider/provider.dart';

import '../../size_config.dart';
import '../../widgets/navigation_bar.dart';
import '../loading/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = '/main_screen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with DisposableWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed(LoadingScreen.routeName);
      }
    }).canceledBy(this);
  }

  @override
  void dispose() {
    cancelSubscriptions();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (Provider.of<UserProvider>(context).currentUser.role != Roles.User)
      return Scaffold(
        bottomNavigationBar: NavBar(),
        body: Body(),
      );
    else
      return Scaffold(
        body: Center(
          child: Text('You dont have perms'),
        ),
      );
  }
}
