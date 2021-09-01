import 'package:flutter/material.dart';
import 'package:inventory_management/src/providers/user_provider.dart';
import 'package:inventory_management/src/screens/edit_product/edit_product_screen.dart';
import 'package:inventory_management/src/screens/edit_resource/edit_resource_screen.dart';
import 'package:inventory_management/src/screens/products/products_screen.dart';
import 'package:inventory_management/src/styles/colors.dart';
import 'package:inventory_management/src/styles/constans.dart';
import 'package:provider/provider.dart';

import '../size_config.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white60,
        boxShadow: [kBoxShadowLite],
      ),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              icon: Icons.storage,
              title: "Edit resource",
              press: () {
                //Provider.of<UserProvider>(context, listen: false).editItemId =
                //"0016411c-a76b-45dd-995f-210d71f1c97d";
                Navigator.pushNamed(context, EditResourceScreen.routeName);
              },
            ),
            NavItem(
              icon: Icons.widgets_sharp,
              title: 'Products',
              press: () {
                Navigator.pushNamed(context, ProductsScreen.routeName);
              },
            ),
            NavItem(
              icon: Icons.people,
              title: 'Edit product',
              press: () {
                Navigator.pushNamed(context, EditProductScreen.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class NavItem extends StatelessWidget {
  const NavItem({
    Key key,
    @required this.icon,
    @required this.title,
    @required this.press,
  }) : super(key: key);
  final String title;
  final GestureTapCallback press;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Container(
        padding: EdgeInsets.all(getProportionateScreenHeight(5)),
        height: getProportionateScreenHeight(50),
        width: getProportionateScreenWidth(100),
        child: Column(
          children: [
            Flexible(
              child: Icon(
                icon,
                color: kMainColor,
              ),
            ),
            Spacer(),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: kMainColor,
              ),
              maxLines: 1,
            )
          ],
        ),
      ),
    );
  }
}
