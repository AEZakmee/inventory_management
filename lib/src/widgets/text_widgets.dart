import 'package:flutter/material.dart';

Widget editItemErrorText(String text, context) => Text(
      text,
      style: Theme.of(context)
          .textTheme
          .subtitle2
          .copyWith(color: Theme.of(context).errorColor),
    );
