import 'package:chat_provider/provider/authentication_provider.dart';
import 'package:chat_provider/services/navigation_service.dart';
import 'package:chat_provider/widgets/custom_input_fields.dart';
import 'package:chat_provider/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;
  late NavigationService _navigationService;

  final _loginFormKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    _navigationService = GetIt.instance.get<NavigationService>();
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.03,
          vertical: _deviceHeight * 0.02,
        ),
        width: _deviceWidth * 0.97,
        height: _deviceHeight * 0.98,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            _pageTitle(),
            SizedBox(
              height: _deviceHeight * 0.04,
            ),
            _loginForm(),
            SizedBox(
              height: _deviceHeight * 0.05,
            ),
            _loginButton(),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
            _registerAccountLink(),
          ],
        ),
      ),
    );
  }

  Widget _pageTitle() {
    return Container(
      height: _deviceHeight * 0.10,
      child: Text(
        'Chat Provider',
        style: TextStyle(
          color: Colors.white,
          fontSize: 40.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Container(
      height: _deviceHeight * 0.18,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomTextFormField(
              onSaved: (_value) {
                setState(() {
                  _email = _value;
                });
              },
              regEx:
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
              hintText: 'Email',
              obscureText: false,
            ),
            CustomTextFormField(
              onSaved: (_value) {
                setState(() {
                  _password = _value;
                });
              },
              regEx: r".{8,}",
              hintText: 'Password',
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return RoundedButton(
      name: 'Login',
      height: _deviceHeight * 0.065,
      width: _deviceWidth * 0.65,
      onPressed: () {
        if (_loginFormKey.currentState!.validate()) {
          print('Email: $_email, Password: $_password');
          _loginFormKey.currentState!.save();
          print('Email: $_email, Password: $_password');
          _auth.loginUsingEmailAndPassword(_email!, _password!);
        }
      },
    );
  }

  Widget _registerAccountLink() {
    return GestureDetector(
      onTap: () {
        print('Clicked');
      },
      child: Container(
        child: Text(
          'Don\'t have an account?',
          style: TextStyle(
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
