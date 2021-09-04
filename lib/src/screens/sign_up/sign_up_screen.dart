import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import '../../size_config.dart';
import 'components/body_updated.dart';
import '../../providers/login_provider.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/sign_up';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(),
      child: KeyboardDismissOnTap(
        child: Scaffold(
          body: Body(),
        ),
      ),
    );
  }
}
