import 'package:flutter/material.dart';
import '../styles/constans.dart';
import '../styles/colors.dart';
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
              color: kErrorColor,
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
    @required this.isLoading,
  }) : super(key: key);
  final Widget child;
  final bool hasLoadingError;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: !hasLoadingError ? child : LoadingErrorWidget(),
      secondChild: Center(
        child: CircularProgressIndicator(),
      ),
      crossFadeState:
          !isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: kAnimDurationLogin,
      reverseDuration: Duration(seconds: 0),
    );
  }
}
