import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';
import '../../../providers/login_provider.dart';
import '../../../widgets/constans.dart';

class ButtonsRow extends StatelessWidget {
  const ButtonsRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        getProportionateScreenHeight(15),
      ),
      child: Consumer<LoginProvider>(builder: (context, loginProv, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            RowButton(
              buttonText: "LOGIN",
              isSelectedButton: loginProv.loginType == LoginType.Login,
              onTap: () => loginProv.toggleLoginType(),
            ),
            RowButton(
              buttonText: "SIGNUP",
              isSelectedButton: loginProv.loginType == LoginType.SignUp,
              onTap: () => loginProv.toggleLoginType(),
            ),
          ],
        );
      }),
    );
  }
}

class RowButton extends StatelessWidget {
  const RowButton({
    Key key,
    @required this.buttonText,
    @required this.isSelectedButton,
    this.onTap,
  }) : super(key: key);

  final String buttonText;
  final bool isSelectedButton;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            buttonText,
            style: isSelectedButton
                ? Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Theme.of(context).buttonColor)
                : Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Theme.of(context).disabledColor),
          ),
          AnimatedContainer(
            duration: kAnimDurationLogin,
            curve: kAnimTypeLogin,
            margin: EdgeInsets.only(top: 3),
            height: 2,
            width: isSelectedButton ? getProportionateScreenWidth(60) : 0,
            color: Theme.of(context).accentColor,
          )
        ],
      ),
    );
  }
}
