import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../widgets/paddings.dart';
import '../../../widgets/utilities.dart';
import '../../../screens/edit_resource/add_quantity_screen.dart';
import '../../../model/resource.dart';
import '../../../providers/resource_provider.dart';
import '../../../widgets/pass_argument.dart';
import '../../../screens/edit_resource/edit_resource_screen.dart';
import '../../../widgets/constans.dart';
import 'package:provider/provider.dart';

import '../../../size_config.dart';

class ResourceRow extends StatelessWidget {
  const ResourceRow({Key key, this.resource}) : super(key: key);
  final Resource resource;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: kMiniPadding),
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.30,
        child: Container(
          width: double.infinity,
          height: getProportionateScreenHeight(100),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [kBoxShadowLite(context)],
          ),
        ),
        actions: <Widget>[
          IconSlideAction(
            caption: 'Add to Favorites',
            color: Theme.of(context).accentColor,
            icon: Icons.star,
            onTap: () => null,
          ),
          IconSlideAction(
            caption: 'Top up',
            color: Theme.of(context).secondaryHeaderColor,
            icon: Icons.add,
            onTap: () => Navigator.pushNamed(
              context,
              EditResourceQuantityScreen.routeName,
              arguments: ScreenArgumentsResource(resource),
            ),
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Edit',
            color: Theme.of(context).primaryColorLight,
            icon: Icons.edit,
            onTap: () => Navigator.pushNamed(
              context,
              EditResourceScreen.routeName,
              arguments: ScreenArgumentsResource(resource),
            ),
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Theme.of(context).primaryColor,
            icon: Icons.delete,
            onTap: () => kDeletePopup(
              context: context,
              title: 'You are about to delete ${resource.name}!\nAre you sure?',
              function: () {
                Provider.of<ResourceProvider>(context, listen: false)
                    .deleteResource(resource.uniqueID);
              },
            ),
          ),
        ],
      ),
    );
    // return InkWell(
    //   onTap: () {
    //     Navigator.pushNamed(
    //       context,
    //       EditResourceQuantityScreen.routeName,
    //       arguments: ScreenArgumentsResource(resource),
    //     );
    //   },
    //   child: Padding(
    //     padding: EdgeInsets.symmetric(
    //       horizontal: getProportionateScreenWidth(10),
    //       vertical: getProportionateScreenHeight(5),
    //     ),
    //     child: Container(
    //       width: double.infinity,
    //       decoration: BoxDecoration(
    //         color: kBackgroundColor,
    //         boxShadow: [kBoxShadowLite],
    //         borderRadius: kBorderRadiusLite,
    //       ),
    //       child: Row(
    //         children: [
    //           Expanded(
    //             flex: 5,
    //             child: Padding(
    //               padding: EdgeInsets.symmetric(
    //                 horizontal: getProportionateScreenWidth(10),
    //                 vertical: getProportionateScreenHeight(10),
    //               ),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   SingleChildScrollView(
    //                     scrollDirection: Axis.horizontal,
    //                     child: Text(
    //                       resource.name,
    //                       style: TextStyle(
    //                         color: kMainColor,
    //                         fontSize: getProportionateScreenWidth(25),
    //                         fontWeight: FontWeight.w500,
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(
    //                     height: getProportionateScreenHeight(2),
    //                   ),
    //                   Text(
    //                     getQuantityTypeString(resource),
    //                     style: TextStyle(
    //                       color: kTextColor,
    //                       fontSize: getProportionateScreenWidth(20),
    //                       fontWeight: FontWeight.w300,
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ),
    //           Expanded(
    //             flex: 3,
    //             child: Row(
    //               children: [
    //                 Spacer(),
    //                 IconButton(
    //                   padding: EdgeInsets.all(
    //                     getProportionateScreenHeight(10),
    //                   ),
    //                   color: kMainColor,
    //                   icon: Icon(Icons.edit),
    //                   iconSize: getProportionateScreenHeight(35),
    //                   onPressed: () {
    //                     Navigator.pushNamed(
    //                       context,
    //                       EditResourceScreen.routeName,
    //                       arguments: ScreenArgumentsResource(resource),
    //                     );
    //                   },
    //                 ),
    //                 IconButton(
    //                   padding: EdgeInsets.all(
    //                     getProportionateScreenHeight(10),
    //                   ),
    //                   color: kMainColor,
    //                   icon: Icon(Icons.delete),
    //                   iconSize: getProportionateScreenHeight(35),
    //                   onPressed: () {
    //                     kDeletePopup(
    //                       context: context,
    //                       title:
    //                           'You are about to delete ${resource.name}!\nAre you sure?',
    //                       function: () {
    //                         Provider.of<ResourceProvider>(context,
    //                                 listen: false)
    //                             .deleteResource(resource.uniqueID);
    //                       },
    //                     );
    //                   },
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }
}
