import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:cheetah_mobile/helpers/keys.dart';
import 'package:cheetah_mobile/helpers/mixins.dart';
import 'package:cheetah_mobile/helpers/model.dart';
import 'package:cheetah_mobile/requests/accounts.dart';
import 'package:cheetah_mobile/views/account/password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../components/display/fields.dart';
import '../../helpers/styles.dart';
import '../../helpers/validators.dart';

final accountFormKey = GlobalKey<FormBuilderState>();
class AccountForm extends StatelessWidget with SnackbarMessenger {
  final UserAccount account;
  const AccountForm(this.account, {super.key});

  void updateAccount(BuildContext context, String? verify) async {
    final form = accountFormKey.currentState?.fields;
    try {
      await updateAccountInfo(
        email: form?["email"]?.value,
        name: form?["name"]?.value,
        password: form?["password"]?.value,
        gender: form?["gender"]?.value,
        telp: form?["telp"]?.value,
        verify: verify,
      );
      // ignore: use_build_context_synchronously
      sendSuccess(context, "Informasi akun berhasil diubah!");
      accountKey.currentState?.refetch();
    } catch (e) {
      sendError(context, e.toString());
    }
  }

  void onSave(BuildContext context){
    bool? validated = accountFormKey.currentState?.validate();
    if (validated == null || !validated) return;
    final form = accountFormKey.currentState?.fields;
    final String? newPassword = form?["password"]?.value;
    if (newPassword == null || newPassword.isEmpty) {
      updateAccount(context, null);
      return;
    }
    showDialog(
      context: context,
      builder: (ctx) => RequirePasswordDialog(
        title: "Konfirmasi Mengubah Password",
        description: "Kelihatannya anda ingin mengubah password anda. Mohon masukkan kata sandi sekarang anda untuk konfirmasi aksi ini.",
        actionBuilder: (ctx, controller) => TextButton(
          onPressed: () {
            if (controller.text.isNotEmpty){
              Navigator.of(ctx).pop();
              updateAccount(context, controller.text);
            }
          },
          child: const Text("SIMPAN", style: TEXT_HIGHLIGHT),
        )
      )
    );
  }

  void onDeleteAccount(BuildContext context){
    showDialog(
      context: context,
      builder: (ctx) => RequirePasswordDialog(
        title: "Konfirmasi Hapus Akun",
        description: "Kelihatannya anda ingin menghapus akun anda. Mohon masukkan kata sandi sekarang anda untuk konfirmasi aksi ini.",
        actionBuilder: (ctx, controller) => TextButton(
          onPressed: () async {
            if (controller.text.isNotEmpty){
              Navigator.of(ctx).pop();
              try {
                await deleteAccount(controller.text);
                loginKey.currentState?.refetch();
              } catch (e) {
                sendError(context, e.toString());
              }
            }
          },
          child: const Text("HAPUS", style: TEXT_HIGHLIGHT),
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16, top: 12),
        child: FormBuilder(
          key: accountFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextInputField(
                name: "email",
                label: "Email",
                validator: validateEmail,
                initialValue: account.email,
                theme: InputFieldTheme.Light,
                hintText: "Email"),
              const SizedBox(height: 20),
              const TextInputField(
                name: "password",
                label: "Kata Sandi Baru",
                validator: validateNewPassword,
                theme: InputFieldTheme.Light,
                obscureText: true,
                hintText: "Kata sandi baru"),
              const SizedBox(height: 20),
              TextInputField(
                name: "name",
                label: "Nama",
                validator: validateName,
                theme: InputFieldTheme.Light,
                initialValue: account.name,
                hintText: "Nama"),
              const SizedBox(height: 20),
              RadioInputField(
                name: "gender",
                label: "Jenis Kelamin",
                options: const [
                  RadioOption(true, "Pria"),
                  RadioOption(false, "Wanita")
                ],
                theme: InputFieldTheme.Light,
                initialValue: account.gender == Gender.Male,
                validator: validateGender,
              ),
              const SizedBox(height: 20),
              TextInputField(
                  name: "telp",
                  label: "No. Telp",
                  validator: validatePhone,
                  theme: InputFieldTheme.Light,
                  initialValue: account.telp,
                  hintText: "No. Telp"),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => onSave(context),
                icon: const Icon(Icons.save),
                label: const Text("Simpan"),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: COLOR_ERROR_CONTAINER
                ),
                onPressed: () => onDeleteAccount(context),
                icon: const Icon(Icons.delete),
                label: const Text("Hapus"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
