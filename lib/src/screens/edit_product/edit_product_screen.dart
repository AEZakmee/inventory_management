import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/pass_argument.dart';
import '../../providers/edit_product_provider.dart';
import 'package:provider/provider.dart';
import '../../size_config.dart';
import 'components/body.dart';

class EditProductScreen extends StatelessWidget {
  static const String routeName = '/edit_product';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final args =
        ModalRoute.of(context).settings.arguments as ScreenArgumentsProduct;
    return ChangeNotifierProvider(
      create: (_) => EditProductProvider(args.product),
      child: KeyboardDismissOnTap(
        child: Scaffold(
          body: Body(),
          appBar: buildAppBar(title: 'Product Page', context: context),
        ),
      ),
    );
  }
}
