import 'package:cheetah_mobile/components/display/fields.dart';
import 'package:cheetah_mobile/helpers/mixins.dart';
import 'package:cheetah_mobile/helpers/validators.dart';
import 'package:cheetah_mobile/requests/accounts.dart';
import 'package:cheetah_mobile/views/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../components/function/future_input.dart';
import '../../helpers/providers.dart';
import '../../helpers/styles.dart';

final loginFormKey = GlobalKey<FormBuilderState>();

class LoginForm extends StatelessWidget with SnackbarMessenger {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final void Function() onSwitch;

  LoginForm({Key? key, required this.onSwitch}) : super(key: key);

  Future<void> handleLogin(BuildContext context) async {
    bool? validated = loginFormKey.currentState?.validate();
    if (validated == null || !validated) return;
    final form = loginFormKey.currentState?.fields;
    try {
       await login(
        form?["email"]?.value as String,
        form?["password"]?.value as String
      );
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => OrdersProvider()),
          ChangeNotifierProvider(create: (context) => MenuParamsProvider()),
        ],
        child: const MainPage(),
      )));
    } catch (e){
      sendError(context, e.toString());
    }
  }

  Widget buildLoginButton(BuildContext context){
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 42,
        width: 200,
        child: FutureButton(
          onPressed: () async => await handleLogin(context),
          child: const Text(
            'Login',
            style: TEXT_IMPORTANT,
          ),
        ),
      ),
    );
  }

  Widget buildRegisterBeckon(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const Text(
          'Belum punya akun? ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        TextButton(
          onPressed: onSwitch,
          child: const Text(
            'Daftar',
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildForm(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'The Savory Spoon',
          style: TextStyle(
            fontFamily: 'JosefinSans',
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        TextInputField(
          name: "email",
          validator: isNotEmpty("Email tidak boleh kosong"),
          label: "Email",
          hintText: "Masukkan email anda"
        ),
        const SizedBox(height: 20),
        TextInputField(
          name: "password",
          validator: isNotEmpty("Kata sandi tidak boleh kosong"),
          label: "Kata Sandi",
          hintText: "Masukkan kata sandi anda",
        ),
        const SizedBox(height: 20),
        buildRegisterBeckon(),
        const SizedBox(height: 60),
        buildLoginButton(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.transparent,
      body: Align(
        alignment: Alignment.center,
        child: ListView(
          children: [
            const SizedBox(
              height: 50,
            ),
            SvgPicture.asset(
              'assets/images/logo.svg',
            ),
            const SizedBox(height: 20),
            FormBuilder(
              key: loginFormKey,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.64),
                ),
                child: buildForm(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
