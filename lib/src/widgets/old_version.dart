import 'package:flutter/material.dart';

class OldVersionScreen extends StatefulWidget {
  static const String routeName = '/old_version_screen';
  @override
  _OldVersionScreenState createState() => _OldVersionScreenState();
}

class _OldVersionScreenState extends State<OldVersionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:
            Text("You are using older version, update so you can use the app"),
      ),
    );
  }
}
