import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'providers/theme_provider.dart';
import 'screens/loading/loading_screen.dart';
import 'providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes.dart';

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer(
        builder: (context, ThemeProvider themeNotifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: LoadingScreen.routeName,
            routes: routes,
            theme: themeNotifier.getTheme(),
          );
        },
      ),
    );
  }
}
