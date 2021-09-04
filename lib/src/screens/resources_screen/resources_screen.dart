import 'package:flutter/material.dart';
import '../../widgets/pass_argument.dart';
import '../../screens/edit_resource/edit_resource_screen.dart';
import '../../widgets/app_bar.dart';
import '../../providers/resource_provider.dart';
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
          label: Text(
            'Add Resource',
          ),
          icon: Icon(
            Icons.add,
            size: getProportionateScreenHeight(30),
          ),
        ),
      ),
    );
  }
}
