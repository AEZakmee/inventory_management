import 'package:flutter/material.dart';
import 'package:inventory_management/src/widgets/paddings.dart';
import 'package:inventory_management/src/widgets/staggered_animations.dart';
import '../../../model/resource.dart';
import '../../../providers/user_provider.dart';
import '../../../screens/resources_screen/components/resource_row.dart';
import '../../../size_config.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<List<Resource>>(
          stream: Provider.of<UserProvider>(context).listResources,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
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
              ),
            );
          }),
    );
  }
}
