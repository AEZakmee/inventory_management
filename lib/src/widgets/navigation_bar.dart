import 'package:flutter/material.dart';
import '../screens/edit_product/edit_product_screen.dart';
import '../screens/products/products_screen.dart';
import '../screens/resources_screen/resources_screen.dart';
import '../size_config.dart';
import 'constans.dart';

class NavBar extends StatelessWidget {
  const NavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).bottomAppBarColor,
        boxShadow: [kBoxShadowLite(context)],
      ),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              icon: Icons.storage,
              title: "Resources",
              press: () {
                Navigator.pushNamed(context, ResourcesScreen.routeName);
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
              title: 'Employees',
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
        height: getProportionateScreenHeight(60),
        width: getProportionateScreenWidth(100),
        child: Column(
          children: [
            Flexible(
              child: Icon(
                icon,
                color: Theme.of(context).primaryColor,
                size: getProportionateScreenHeight(30),
              ),
            ),
            Spacer(),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: getProportionateScreenWidth(15),
              ),
              maxLines: 1,
            )
          ],
        ),
      ),
    );
  }
}
