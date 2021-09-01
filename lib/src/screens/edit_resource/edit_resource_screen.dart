import 'package:flutter/material.dart';
import 'package:inventory_management/src/widgets/app_bar.dart';
import '../../providers/resources_provider.dart';
import '../../styles/colors.dart';
import 'package:provider/provider.dart';
import '../../size_config.dart';
import 'components/body.dart';

class EditResourceScreen extends StatefulWidget {
  static const String routeName = '/edit_resource';

  @override
  _EditResourceScreenState createState() => _EditResourceScreenState();
}

class _EditResourceScreenState extends State<EditResourceScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider(
      create: (_) => ResourceProvider(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Body(),
        appBar: buildAppBar(title: 'Resource Page', context: context),
      ),
    );
  }
}
