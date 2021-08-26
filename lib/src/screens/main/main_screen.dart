import 'dart:async';

import '../../providers/user_provider.dart';
import '../loading/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = '/main_screen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<User> _sub;
  @override
  void initState() {
    super.initState();
    _sub = _auth.authStateChanges().listen((User user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed(LoadingScreen.routeName);
      }
    });
  }

  @override
  void dispose() {
    _sub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        body: Center(
          child: TextButton(
              child: Text("Sign out"),
              onPressed: () async {
                await Provider.of<UserProvider>(context, listen: false)
                    .logout();
              }),
        ),
      ),
    );
  }
}
