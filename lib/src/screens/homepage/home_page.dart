import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../loginregisterpage/login_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        backgroundColor: Colors.cyan,
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.close),
        onPressed: () async {
          SharedPreferences sp = await SharedPreferences.getInstance();
          sp.setBool('auth', false);
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return LoginPage();
              },
            ),
            (Route<dynamic> route) => false,
          );
        },
      ),
    );
  }
}
