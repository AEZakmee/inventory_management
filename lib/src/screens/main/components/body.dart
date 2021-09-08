import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:inventory_management/src/model/prev_order.dart';
import 'package:inventory_management/src/model/product.dart';
import 'package:inventory_management/src/model/resource.dart';
import 'package:inventory_management/src/providers/user_provider.dart';
import 'package:inventory_management/src/size_config.dart';
import 'package:inventory_management/src/widgets/bottom_sheet.dart';
import 'package:inventory_management/src/widgets/paddings.dart';
import 'package:inventory_management/src/widgets/staggered_animations.dart';
import 'package:inventory_management/src/widgets/text_widgets.dart';
import 'package:inventory_management/src/widgets/utilities.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class MainBody extends StatelessWidget {
  final PageController listViewKey;
  const MainBody({Key key, this.listViewKey}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            mediumPadding(),
            MainResourceRow(
              stream: Provider.of<MainProvider>(context).listResourcesFav,
              title: 'Favorite Resources',
              onSeeAllTap: () => listViewKey.jumpToPage(1),
            ),
            mediumPadding(),
            MainProductRow(
              stream: Provider.of<MainProvider>(context).listProductFav,
              title: 'Favorite Products',
              onSeeAllTap: () => listViewKey.jumpToPage(2),
            ),
            mediumPadding(),
            PreviousOrders(),
          ],
        ),
      ),
    );
  }
}

class PreviousOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<PrevOrder>>(
      stream: Provider.of<MainProvider>(context).prevOrders,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SizedBox.shrink();
        }
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(4),
                  ),
                  child: cardHeadlineMedium('Previous Orders', context),
                ),
                Spacer(),
              ],
            ),
            smallPadding(),
            StaggeredColumn(
              children: [
                ...List.generate(
                  snapshot.data.length,
                  (index) => Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    child: Card(
                      elevation: 8,
                      child: Container(
                        height: getProportionateScreenHeight(80),
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: getProportionateScreenHeight(5),
                            horizontal: getProportionateScreenWidth(10),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              cardHeadlineMediumSmall(
                                  snapshot.data[index].log.log.substring(17),
                                  context),
                              Text(
                                'Ordered by: ' +
                                    snapshot.data[index].log.employee,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2
                                    .copyWith(
                                      fontSize:
                                          getProportionateScreenHeight(20),
                                    ),
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Spacer(),
                                  Text(
                                    timeago.format(
                                        snapshot.data[index].log.dateTime),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline2
                                        .copyWith(
                                          fontSize:
                                              getProportionateScreenHeight(17),
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'Undo',
                        color: Theme.of(context).primaryColor,
                        icon: Icons.undo,
                        onTap: () => kInfoPopup(
                          context: context,
                          title:
                              'Are you sure you want to revert ${snapshot.data[index].product.name} order?',
                          function: () async {
                            await Provider.of<MainProvider>(context,
                                    listen: false)
                                .revertOrder(snapshot.data[index]);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class MainResourceRow extends StatelessWidget {
  const MainResourceRow({
    Key key,
    this.stream,
    this.title,
    this.onSeeAllTap,
  }) : super(key: key);
  final Stream<List<Resource>> stream;
  final String title;
  final Function onSeeAllTap;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Resource>>(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data.length == 0) {
          return SizedBox.shrink();
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(4),
                  ),
                  child: cardHeadlineMedium(title, context),
                ),
                Spacer(),
                if (onSeeAllTap != null)
                  InkWell(
                    onTap: onSeeAllTap,
                    child: cardHeadlineSmall3('See All', context),
                  ),
              ],
            ),
            smallPadding(),
            Container(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: StaggeredRow(
                  children: [
                    ...List.generate(
                      snapshot.data.length,
                      (index) => InkWell(
                        onTap: () => showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return BottomSheetCustomResource(
                                resource: snapshot.data[index],
                              );
                            }),
                        child: Container(
                          width: getProportionateScreenWidth(130),
                          height: getProportionateScreenHeight(130),
                          child: Card(
                            elevation: 8,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenHeight(5),
                                horizontal: getProportionateScreenWidth(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  cardHeadlineSmall(
                                      snapshot.data[index].name, context),
                                  smallPadding(),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class MainProductRow extends StatelessWidget {
  const MainProductRow({
    Key key,
    this.stream,
    this.title,
    this.onSeeAllTap,
  }) : super(key: key);
  final Stream<List<Product>> stream;
  final String title;
  final Function onSeeAllTap;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Product>>(
      stream: stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data.length == 0) {
          return SizedBox.shrink();
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: getProportionateScreenWidth(4),
                  ),
                  child: cardHeadlineMedium(title, context),
                ),
                Spacer(),
                if (onSeeAllTap != null)
                  InkWell(
                    onTap: onSeeAllTap,
                    child: cardHeadlineSmall3('See All', context),
                  ),
              ],
            ),
            smallPadding(),
            Container(
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: StaggeredRow(
                  children: [
                    ...List.generate(
                      snapshot.data.length,
                      (index) => InkWell(
                        onTap: () => showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return BottomSheetCustomProduct(
                                product: snapshot.data[index],
                              );
                            }),
                        child: Container(
                          width: getProportionateScreenWidth(130),
                          height: getProportionateScreenHeight(130),
                          child: Card(
                            elevation: 8,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: getProportionateScreenHeight(5),
                                horizontal: getProportionateScreenWidth(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  cardHeadlineSmall(
                                      snapshot.data[index].name, context),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
