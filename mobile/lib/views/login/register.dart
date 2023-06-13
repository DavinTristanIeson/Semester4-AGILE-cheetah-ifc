import 'package:cheetah_mobile/components/display/fields.dart';
import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:cheetah_mobile/helpers/mixins.dart';
import 'package:cheetah_mobile/helpers/styles.dart';
import 'package:cheetah_mobile/helpers/validators.dart';
import 'package:flutter/material.dart';
import 'package:cheetah_mobile/requests/accounts.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';

import '../../components/display/interaction.dart';
import '../../components/function/future_input.dart';
import '../../helpers/keys.dart';
import 'carousel.dart';

final registerFormKey = GlobalKey<FormBuilderState>();

class RegisterForm extends StatelessWidget with SnackbarMessenger {
  final void Function() onSwitch;
  const RegisterForm({super.key, required this.onSwitch});

  Widget buildRegisterButton(BuildContext context) {
    return FutureButton(
      style: BUTTON_PRIMARY,
      onPressed: () async {
        bool? validated = registerFormKey.currentState?.validate();
        if (validated == null || !validated) return;
        final form = registerFormKey.currentState?.fields;
        try {
          await register(
            form?["email"]?.value as String,
            form?["password"]?.value as String,
            form?["name"]?.value as String,
            form?["gender"]?.value as bool,
            form?["telp"]?.value as String,
          );
          loginKey.currentState!.refetch();
        } catch (e){
          sendError(context, e.toString());
        }
      },
      child: const Text('Register', style: TEXT_IMPORTANT),
    );
  }

  Widget buildLoginBeckon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Sudah punya akun?',
          style: TextStyle(
            color: COLOR_SECONDARY,
            fontSize: 16,
          ),
        ),
        TextLink(
          onPressed: onSwitch,
          label: "Masuk",
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                const LoginViewCarousel(),
                Positioned.fill(
                  child: SvgPicture.asset(
                    LOGO_PATH,
                  ),
                ),
              ],
            ),
            const Text(
              'Register',
              style: TextStyle(
                fontFamily: 'Josefin Sans',
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            FormBuilder(
              key: registerFormKey,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.64),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const TextInputField(
                        name: "email",
                        label: "Email",
                        validator: validateEmail,
                        hintText: "Masukkan email anda"),
                    const SizedBox(height: 20),
                    const TextInputField(
                        name: "password",
                        label: "Kata Sandi",
                        validator: validatePassword,
                        obscureText: true,
                        hintText: "Masukkan kata sandi anda"),
                    const SizedBox(height: 20),
                    const TextInputField(
                        name: "name",
                        label: "Nama",
                        validator: validateName,
                        hintText: "Masukkan nama anda"),
                    const SizedBox(height: 20),
                    const RadioInputField(
                      name: "gender",
                      label: "Jenis Kelamin",
                      options: [
                        RadioOption(true, "Pria"),
                        RadioOption(false, "Wanita")
                      ],
                      theme: InputFieldTheme.Dark,
                      validator: validateGender,
                    ),
                    const SizedBox(height: 20),
                    const TextInputField(
                        name: "telp",
                        label: "No. Telp",
                        validator: validatePhone,
                        hintText: "Masukkan nomor telepon anda"),
                    const SizedBox(height: 20),
                    buildLoginBeckon(),
                    const SizedBox(height: 20),
                    buildRegisterButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
