import 'package:flutter/material.dart';
import 'package:inventory_management/src/providers/resource_provider.dart';
import 'package:inventory_management/src/widgets/staggered_animations.dart';
import 'package:inventory_management/src/widgets/text_widgets.dart';
import '../../../model/resource.dart';
import '../../../providers/user_provider.dart';
import '../../../screens/resources_screen/components/resource_row.dart';
import '../../../size_config.dart';
import 'package:provider/provider.dart';

class ResourcesBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResourceProvider(),
      child: StreamBuilder<List<Resource>>(
          stream: Provider.of<UserProvider>(context).listResources,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data.length == 0) {
              return Center(
                child: cardHeadlineMedium("There are no resources", context),
              );
            }
            return SingleChildScrollView(
                child: StaggeredColumn(
              children: [
                ...List.generate(
                  snapshot.data.length,
                  (index) => ResourceRow(
                    resource: snapshot.data[index],
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(100),
                ),
              ],
            ));
          }),
    );
  }
}
