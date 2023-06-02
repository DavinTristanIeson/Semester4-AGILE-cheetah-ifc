import 'package:cheetah_mobile/requests/accounts.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: const Text("Login"),
        onPressed: () {
          login("davin.tristan@gmail.com", "davintristan");
        });
  }
}
