import 'package:flutter/material.dart';
import 'package:inventory_management/src/screens/edit_resource/components/pass_argument.dart';
import 'package:inventory_management/src/screens/edit_resource/edit_resource_screen.dart';
import 'package:inventory_management/src/widgets/app_bar.dart';
import '../../providers/resource_provider.dart';
import '../../styles/colors.dart';
import 'package:provider/provider.dart';
import '../../size_config.dart';
import 'components/body.dart';

class ResourcesScreen extends StatefulWidget {
  static const String routeName = '/resources';

  @override
  _ResourcesScreenState createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ChangeNotifierProvider(
      create: (_) => ResourceProvider(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Body(),
        appBar: buildAppBar(context: context, title: 'Resources'),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(
              context,
              EditResourceScreen.routeName,
              arguments: ScreenArgumentsResource(null),
            );
          },
          backgroundColor: kMainColorAccent,
          label: Text(
            'Add Resource',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: getProportionateScreenHeight(20),
            ),
          ),
          icon: Icon(
            Icons.add,
            color: kBackgroundColor,
            size: getProportionateScreenHeight(30),
          ),
        ),
      ),
    );
  }
}
