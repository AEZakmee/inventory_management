import 'package:flutter/material.dart';
import 'package:inventory_management/src/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Center(
          child: TextButton(
            child: Text("Sign out"),
            onPressed: () async {
              await Provider.of<UserProvider>(context, listen: false).logout();
            },
          ),
        ),
      ),
    );
  }
}
