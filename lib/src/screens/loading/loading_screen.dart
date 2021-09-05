import '../screen_controller.dart';
import '../sign_up/sign_up_screen.dart';
import '../../providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingScreen extends StatefulWidget {
  static const String routeName = '/loading_screen';
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    _handleUserJoin();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleUserJoin() async {
    bool isLogged =
        await Provider.of<UserProvider>(context, listen: false).isLoggedIn();
    if (isLogged) {
      Navigator.pushReplacementNamed(context, MainScreen.routeName);
    } else {
      Navigator.pushReplacementNamed(context, SignUpScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("LOADING"),
      ),
    );
  }
}
