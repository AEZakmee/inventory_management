import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:inventory_management/src/widgets/app_bar.dart';
import '../../providers/edit_resource_provider.dart';
import 'package:provider/provider.dart';
import '../../size_config.dart';
import 'components/body.dart';
import '../../widgets/pass_argument.dart';

class EditResourceScreen extends StatelessWidget {
  static const String routeName = '/edit_resource';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final args =
        ModalRoute.of(context).settings.arguments as ScreenArgumentsResource;

    return ChangeNotifierProvider(
      create: (_) => EditResourceProvider(args.resource),
      child: KeyboardDismissOnTap(
        child: Scaffold(
          body: Body(),
          appBar: buildAppBar(title: 'Resource Page', context: context),
        ),
      ),
    );
  }
}
