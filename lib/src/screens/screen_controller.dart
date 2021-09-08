import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:inventory_management/src/widgets/drawer.dart';
import 'package:inventory_management/src/widgets/paddings.dart';
import '../model/user.dart';
import '../providers/user_provider.dart';
import '../screens/main/components/body.dart';
import '../screens/products/components/body.dart';
import '../screens/resources_screen/components/body.dart';
import '../widgets/disposable_widget.dart';
import '../widgets/pass_argument.dart';
import 'package:provider/provider.dart';
import '../size_config.dart';
import 'edit_resource/edit_resource_screen.dart';
import 'loading/loading_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = '/main_screen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with DisposableWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  PageController _pageController = PageController(
    initialPage: 0,
  );
  int _selectedIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        Navigator.of(context).pushReplacementNamed(LoadingScreen.routeName);
      }
    }).canceledBy(this);
  }

  @override
  void dispose() {
    cancelSubscriptions();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    if (Provider.of<MainProvider>(context).currentUser.role != Roles.User)
      return Scaffold(
        bottomNavigationBar: FancyBottomNavigation(
          key: _bottomNavigationKey,
          initialSelection: 0,
          onTabChangedListener: (value) {
            _selectedIndex = value;
            _pageController.jumpToPage(
              value,
            );
          },
          tabs: [
            TabData(iconData: Icons.home, title: "Home"),
            TabData(iconData: Icons.storage, title: "Resources"),
            TabData(iconData: Icons.widgets_sharp, title: "Products"),
            TabData(iconData: Icons.people, title: "Employees")
          ],
        ),
        body: PageView(
          controller: _pageController,
          clipBehavior: Clip.antiAlias,
          onPageChanged: (page) {
            if (_selectedIndex != page) {
              final FancyBottomNavigationState fState = _bottomNavigationKey
                  .currentState as FancyBottomNavigationState;
              fState.setPage(page);
            }
            setState(() {
              _selectedIndex = page;
            });
          },
          children: <Widget>[
            ChildWidget(
              screen: ScreenEnum.Main,
              listViewKey: _pageController,
            ),
            ChildWidget(screen: ScreenEnum.Resources),
            ChildWidget(screen: ScreenEnum.Products),
            ChildWidget(screen: ScreenEnum.Employees)
          ],
        ),
        floatingActionButton: buildFloatingActionButton(context),
        appBar: _selectedIndex == 0
            ? AppBar(
                elevation: 8,
                title: Text('Main menu'),
                centerTitle: true,
                leading: Builder(
                  builder: (context) => IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: getProportionateScreenHeight(30),
                    ),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  ),
                ),
              )
            : null,
        drawer: CustomDrawer(),
      );
    else
      return Scaffold(
        body: Center(
          child: Container(
            height: 100,
            child: Column(
              children: [
                Text('You don\'t have perms'),
                smallPadding(),
                TextButton(
                    onPressed: () {
                      Provider.of<MainProvider>(context, listen: false)
                          .logout();
                    },
                    child: Text('Sign out'))
              ],
            ),
          ),
        ),
      );
  }

  Widget buildFloatingActionButton(BuildContext context) {
    switch (_selectedIndex) {
      case 1:
        return FloatingActionButton.extended(
          icon: Icon(Icons.add),
          label: Text('Add Resource'),
          onPressed: () {
            Navigator.pushNamed(
              context,
              EditResourceScreen.routeName,
              arguments: ScreenArgumentsResource(null),
            );
          },
        );
      default:
        return null;
    }
  }
}

class ChildWidget extends StatelessWidget {
  final ScreenEnum screen;
  final listViewKey;
  const ChildWidget({Key key, this.screen, this.listViewKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (screen) {
      case ScreenEnum.Main:
        return SafeArea(
            child: MainBody(
          listViewKey: listViewKey,
        ));
      case ScreenEnum.Resources:
        return SafeArea(child: ResourcesBody());
      case ScreenEnum.Products:
        return SafeArea(child: ProductsBody());
      case ScreenEnum.Employees:
        return Center(
          child: Text('You don\'t have perms'),
        );
      default:
        return Container();
    }
  }
}

enum ScreenEnum { Main, Resources, Products, Employees }
