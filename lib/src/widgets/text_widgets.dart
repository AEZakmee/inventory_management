import 'package:flutter/material.dart';

import '../size_config.dart';

Widget editItemErrorText(String text, context) => Text(
      text,
      style: Theme.of(context)
          .textTheme
          .subtitle2
          .copyWith(color: Theme.of(context).errorColor),
    );

Widget editItemHeadlineText(String text, context) => Text(
      text,
      style: Theme.of(context).textTheme.headline4.copyWith(
            fontSize: getProportionateScreenWidth(32),
          ),
    );

Widget cardHeadlineBig(String text, context) => Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      softWrap: false,
      style: Theme.of(context).textTheme.headline5.copyWith(
            fontSize: getProportionateScreenHeight(30),
          ),
    );

Widget cardHeadlineMedium(String text, context) => Text(
      text,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      softWrap: false,
      style: Theme.of(context).textTheme.headline5.copyWith(
            fontSize: getProportionateScreenHeight(25),
          ),
    );
