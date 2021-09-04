import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';
import '../../../widgets/constans.dart';
import '../../../providers/login_provider.dart';

class InputFields extends StatefulWidget {
  @override
  _InputFieldsState createState() => _InputFieldsState();
}

class _InputFieldsState extends State<InputFields> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: getProportionateScreenHeight(20),
      ),
      child: Column(
        children: [
          LoginInputField(
            icon: MaterialCommunityIcons.email_outline,
            hintText: "Enter Email",
            isEmail: true,
            label: "Email",
            dataField: DataField.Email,
          ),
          LoginInputField(
            icon: MaterialCommunityIcons.lock,
            hintText: "Enter Password",
            isPassword: true,
            label: "Password",
            dataField: DataField.Password,
          ),
          AnimatedCrossFade(
            firstChild: SizedBox.shrink(),
            secondChild: LoginInputField(
              icon: MaterialCommunityIcons.worker,
              hintText: "Enter Username",
              label: "Username",
              dataField: DataField.Username,
            ),
            crossFadeState: !Provider.of<LoginProvider>(context).isSignUp
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: kAnimDurationLogin,
            reverseDuration: Duration(seconds: 0),
          )
          // if (Provider.of<LoginProvider>(context).isSignUp)
          //   LoginInputField(
          //     icon: MaterialCommunityIcons.worker,
          //     hintText: "Enter Username",
          //     label: "Username",
          //     dataField: DataField.Username,
          //   ),
        ],
      ),
    );
  }
}

class LoginInputField extends StatelessWidget {
  const LoginInputField({
    Key key,
    @required this.icon,
    @required this.hintText,
    this.isPassword = false,
    this.isEmail = false,
    @required this.label,
    @required this.dataField,
  }) : super(key: key);

  final IconData icon;
  final String hintText;
  final String label;
  final bool isPassword;
  final bool isEmail;
  final DataField dataField;
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, prov, child) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: getProportionateScreenHeight(
            prov.buttonPressed
                ? prov.hasError(dataField)
                    ? 10
                    : 15
                : 15,
          ),
        ),
        child: TextField(
          obscureText: isPassword,
          showCursor: true,
          onChanged: (String data) => prov.changeData(dataField, data),
          keyboardType:
              isEmail ? TextInputType.emailAddress : TextInputType.text,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
            errorText: prov.buttonPressed
                ? prov.hasError(dataField)
                    ? prov.getErrorMessage(dataField)
                    : null
                : null,
            hintText: hintText,
          ),
        ),
      );
    });
  }
}
