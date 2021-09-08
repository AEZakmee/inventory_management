import 'package:day_night_switcher/day_night_switcher.dart';
import 'package:flutter/material.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'constans.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key key,
  });
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: kLoginBackgroundGradient(context),
            ),
            accountName: Text(
              Provider.of<MainProvider>(context).currentUser.name,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.white),
            ),
            accountEmail: Text(
              Provider.of<MainProvider>(context).currentUser.email,
            ),
          ),
          ListTile(
            leading: DayNightSwitcherIcon(
              isDarkModeEnabled:
                  Provider.of<ThemeProvider>(context).showDarkButton,
              onStateChanged: (isEnabled) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .switchTheme();
              },
            ),
            title: Text('Dark mode'),
            onTap: () => Provider.of<ThemeProvider>(context, listen: false)
                .listTileClicked(),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Exit'),
            onTap: () {
              Provider.of<MainProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
