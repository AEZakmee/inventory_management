import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:inventory_management/src/providers/user_provider.dart';
import 'package:inventory_management/src/widgets/bottom_sheet.dart';
import '../../../widgets/text_widgets.dart';
import '../../../widgets/utilities.dart';
import '../../../model/resource.dart';
import '../../../providers/resource_provider.dart';
import '../../../widgets/pass_argument.dart';
import '../../../screens/edit_resource/edit_resource_screen.dart';
import 'package:provider/provider.dart';
import '../../../size_config.dart';

class ResourceRow extends StatelessWidget {
  const ResourceRow({Key key, this.resource}) : super(key: key);
  final Resource resource;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.30,
        child: Container(
          width: double.infinity,
          height: getProportionateScreenHeight(100),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: getProportionateScreenHeight(5),
              horizontal: getProportionateScreenWidth(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                cardHeadlineBig(resource.name, context),
                Text(
                  'Available: ' + getQuantityTypeString(resource),
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        fontSize: getProportionateScreenHeight(20),
                      ),
                ),
                Text(
                  'Used: ' + getQuantityTypeStringUsed(resource),
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        fontSize: getProportionateScreenHeight(20),
                      ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          resource.isFavourite ?? false
              ? IconSlideAction(
                  caption: 'Unfavorite',
                  color: Theme.of(context).accentColor,
                  icon: Icons.star,
                  onTap: () => Provider.of<MainProvider>(context, listen: false)
                      .switchFavourite(resource: resource),
                )
              : IconSlideAction(
                  caption: 'Add to Favorites',
                  color: Theme.of(context).accentColor,
                  icon: Icons.star_border,
                  onTap: () => Provider.of<MainProvider>(context, listen: false)
                      .switchFavourite(resource: resource),
                ),
          IconSlideAction(
            caption: 'Top up',
            color: Theme.of(context).secondaryHeaderColor,
            icon: Icons.add,
            onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) {
                  return BottomSheetCustomResource(
                    resource: resource,
                  );
                }),
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
            onTap: () => kInfoPopup(
              context: context,
              title: 'You are about to delete ${resource.name}!\nAre you sure?',
              function: () {
                Provider.of<ResourceProvider>(context, listen: false)
                    .deleteResource(resource);
              },
            ),
          ),
        ],
      ),
    );
  }
}
