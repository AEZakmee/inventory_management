import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inventory_management/src/model/product.dart';
import 'package:inventory_management/src/model/resource.dart';
import 'package:inventory_management/src/providers/user_provider.dart';
import 'package:inventory_management/src/size_config.dart';
import 'package:inventory_management/src/widgets/paddings.dart';
import 'package:inventory_management/src/widgets/staggered_animations.dart';
import 'package:inventory_management/src/widgets/text_widgets.dart';
import 'package:provider/provider.dart';

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
              stream: Provider.of<UserProvider>(context).listResourcesFav,
              title: 'Favorite Resources',
              onSeeAllTap: () => listViewKey.jumpToPage(1),
            ),
            mediumPadding(),
            MainProductRow(
              stream: Provider.of<UserProvider>(context).listProductFav,
              title: 'Favorite Products',
              onSeeAllTap: () => listViewKey.jumpToPage(2),
            ),
          ],
        ),
      ),
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
                      (index) => Container(
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
                      (index) => Container(
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
