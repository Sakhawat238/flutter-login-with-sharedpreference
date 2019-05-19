import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens//homepage/home_page.dart';
import 'screens/loginregisterpage/login_page.dart';

class App extends StatelessWidget {
  Future<bool> loadAuthData() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool('auth');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awsome Flutter',
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: loadAuthData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return HomePage();
            } else {
              return LoginPage();
            }
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
