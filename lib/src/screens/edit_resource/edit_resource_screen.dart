import 'package:flutter/material.dart';
import 'package:inventory_management/src/widgets/app_bar.dart';
import '../../providers/resources_provider.dart';
import '../../styles/colors.dart';
import 'package:provider/provider.dart';
import '../../size_config.dart';
import 'components/body.dart';
import 'components/pass_argument.dart';

class EditResourceScreen extends StatelessWidget {
  static const String routeName = '/edit_resource';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final args =
        ModalRoute.of(context).settings.arguments as ScreenArgumentsResource;

    return ChangeNotifierProvider(
      create: (_) => ResourceProvider(args.resource),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Body(),
        appBar: buildAppBar(title: 'Resource Page', context: context),
      ),
    );
  }
}
