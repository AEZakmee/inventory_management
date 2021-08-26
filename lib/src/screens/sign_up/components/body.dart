// import 'dart:async';
//
// import '../../loading/loading_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
// import 'package:provider/provider.dart';
// import '../../../size_config.dart';
// import '../../../styles/colors.dart';
// import '../../../styles/constans.dart';
// import '../../../providers/login_provider.dart';
// import 'arrow_button.dart';
// import 'input_fields.dart';
// import 'top_buttons.dart';
//
// class Body extends StatefulWidget {
//   const Body({
//     Key key,
//   }) : super(key: key);
//
//   @override
//   _BodyState createState() => _BodyState();
// }
//
// class _BodyState extends State<Body> {
//   var _keyboardVisibilityController = KeyboardVisibilityController();
//   StreamSubscription<bool> _sub;
//   @override
//   void initState() {
//     super.initState();
//     _sub = _keyboardVisibilityController.onChange.listen((bool visible) {
//       Provider.of<LoginProvider>(context, listen: false)
//           .changeVisibility(visible);
//     });
//   }
//
//   @override
//   void dispose() {
//     _sub.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return KeyboardDismissOnTap(
//       child: Consumer<LoginProvider>(builder: (context, prov, child) {
//         return Stack(
//           children: [
//             Positioned(
//               top: 0,
//               right: 0,
//               left: 0,
//               child: AnimatedContainer(
//                 duration: kAnimDurationLogin,
//                 curve: kAnimTypeLogin,
//                 height:
//                     getProportionateScreenHeight(prov.overallPosition + 180),
//                 decoration: BoxDecoration(
//                   gradient: kLoginBackgroundGradient,
//                 ),
//               ),
//             ),
//             ArrowButtonBackground(
//               bottom: getProportionateScreenHeight(prov.isSignUp
//                   ? prov.signUpFieldPosition + prov.signUpFieldHeight - 50
//                   : prov.loginFieldPosition + prov.loginFieldHeight - 50),
//               hasShadow: true,
//             ),
//             AnimatedPositioned(
//               duration: kAnimDurationLogin,
//               curve: kAnimTypeLogin,
//               top: getProportionateScreenHeight(prov.isSignUp
//                   ? prov.signUpFieldPosition
//                   : prov.loginFieldPosition),
//               child: AnimatedContainer(
//                 duration: kAnimDurationLogin,
//                 curve: kAnimTypeLogin,
//                 height: getProportionateScreenHeight(prov.isSignUp
//                     ? prov.signUpFieldHeight
//                     : prov.loginFieldHeight),
//                 width: SizeConfig.screenWidth - getProportionateScreenWidth(40),
//                 margin: EdgeInsets.symmetric(
//                   horizontal: getProportionateScreenWidth(20),
//                 ),
//                 decoration: kBoxDecoration,
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                     horizontal: getProportionateScreenWidth(20),
//                   ),
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: [
//                         ButtonsRow(),
//                         InputFields(),
//                         if (prov.hasAuthError)
//                           Center(
//                             child: Text(
//                               prov.authErrorString,
//                               style: TextStyle(
//                                 color: kErrorColor,
//                                 fontSize: getProportionateScreenHeight(15),
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             ArrowButtonBackground(
//               bottom: getProportionateScreenHeight(prov.isSignUp
//                   ? prov.signUpFieldPosition + prov.signUpFieldHeight - 50
//                   : prov.loginFieldPosition + prov.loginFieldHeight - 50),
//               child: ArrowButton(
//                 onPress: () async {
//                   print("before");
//                   if (!prov.loginClicked) {
//                     print("after");
//                     var success =
//                         await Provider.of<LoginProvider>(context, listen: false)
//                             .signUp();
//                     if (success) {
//                       Navigator.pushReplacementNamed(
//                           context, LoadingScreen.routeName);
//                     }
//                   }
//                 },
//               ),
//             ),
//             if (!prov.keyboardOpened)
//               Positioned(
//                 bottom: getProportionateScreenHeight(30),
//                 left: 0,
//                 right: 0,
//                 child: Center(
//                   child: Text(
//                     "Forgot Password?",
//                     style: TextStyle(
//                       color: kTextColor,
//                       fontSize: getProportionateScreenHeight(15),
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         );
//       }),
//     );
//   }
// }
