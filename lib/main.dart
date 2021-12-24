import 'package:chat_provider/pages/home_page.dart';
import 'package:chat_provider/pages/login_page.dart';
import 'package:chat_provider/pages/splash_page.dart';
import 'package:chat_provider/provider/authentication_provider.dart';
import 'package:chat_provider/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    SplashPage(
      key: UniqueKey(),
      onInitializationComplete: () {
        runApp(
          MainApp(),
        );
      },
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (context) {
            return AuthenticationProvider();
          },
        ),
      ],
      child: MaterialApp(
        title: 'Chat Provider',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          backgroundColor: Color.fromRGBO(36, 35, 49, 1.0),
          scaffoldBackgroundColor: Color.fromRGBO(36, 35, 49, 1.0),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color.fromRGBO(30, 29, 37, 1.0),
          ),
        ),
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/home': (context) => HomePage(),
        },
      ),
    );
  }
}
