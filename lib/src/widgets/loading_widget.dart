import 'package:flutter/material.dart';
import 'constans.dart';
import '../size_config.dart';

class LoadingErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            "Error loading data",
            style: TextStyle(
              color: Theme.of(context).errorColor,
              fontSize: getProportionateScreenHeight(30),
            ),
          ),
          //todo better button
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Go back'),
          )
        ],
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    Key key,
    @required this.child,
    @required this.hasLoadingError,
  }) : super(key: key);
  final Widget child;
  final bool hasLoadingError;
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: child,
      secondChild: LoadingErrorWidget(),
      crossFadeState: !hasLoadingError
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: kAnimDurationLogin,
      reverseDuration: Duration(seconds: 0),
    );
  }
}
