import 'package:cheetah_mobile/views/login/login.dart';
import 'package:cheetah_mobile/views/login/register.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLogin = true;
  void onSwitch(){
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLogin ?
      LoginForm(onSwitch: onSwitch) :
      RegisterForm(onSwitch: onSwitch);
  }
}