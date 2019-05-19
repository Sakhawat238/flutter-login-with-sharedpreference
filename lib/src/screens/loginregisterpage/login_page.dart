import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../homepage/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email;
  String password;

  final loginFormKey = GlobalKey<FormState>();
  bool _autoValidateLoginForm = false;
  bool _shouldObscureText = true;

  void toggleObscureFlag() {
    setState(() {
      _shouldObscureText = !_shouldObscureText;
    });
  }

  saveAuthData(bool value) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool('auth', value);
  }

  void login() {
    if (email == 'ab@xy.com' && password == '1234') {
      saveAuthData(true);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) {
            return HomePage();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: Form(
            key: loginFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                emailField(),
                SizedBox(
                  height: 10.0,
                ),
                passwordField(),
                SizedBox(
                  height: 25.0,
                ),
                loginButton(),
                forgetPassowrd(),
                noAccount(),
              ],
            ),
          ),
        ),
      ],
    ));
  }

  Widget emailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email Address *',
        hintText: 'you@example.com',
        icon: Icon(
          Icons.email,
          color: Colors.black87,
        ),
        labelStyle: TextStyle(
          color: Colors.black87,
        ),
        contentPadding: EdgeInsets.only(bottom: 10.0),
      ),
      keyboardType: TextInputType.emailAddress,
      autovalidate: _autoValidateLoginForm,
      validator: (String value) {
        if (value.contains('@') && value.contains('.'))
          return null;
        else
          return 'Email is invalid';
      },
      onSaved: (String value) {
        email = value;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password *',
        labelStyle: TextStyle(
          color: Colors.black87,
        ),
        icon: Icon(
          Icons.lock,
          color: Colors.black87,
        ),
        suffix: GestureDetector(
          onTap: toggleObscureFlag,
          child: _shouldObscureText
              ? Icon(FontAwesomeIcons.solidEye)
              : Icon(FontAwesomeIcons.solidEyeSlash),
        ),
        contentPadding: EdgeInsets.only(
          bottom: 10.0,
        ),
      ),
      obscureText: _shouldObscureText,
      validator: (String value) {},
      onSaved: (String value) {
        password = value;
      },
    );
  }

  Widget loginButton() {
    return ListTile(
      title: RaisedButton(
        onPressed: () {
          if (loginFormKey.currentState.validate()) {
            loginFormKey.currentState.save();
            login();
          } else {
            setState(() {
              _autoValidateLoginForm = true;
            });
          }
        },
        child: Text('Login'),
        color: Colors.cyan,
        textColor: Colors.white,
      ),
    );
  }

  Widget forgetPassowrd() {
    return Container(
      child: FlatButton(
        onPressed: () {},
        child: Text(
          "Forgot Password?",
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.black87,
            fontSize: 13.0,
          ),
        ),
      ),
    );
  }

  Widget noAccount() {
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't have an account?",
          ),
          SizedBox(
            width: 10.0,
          ),
          FlatButton(
            onPressed: () {},
            child: Text(
              'Sign Up',
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                color: Colors.cyan,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
