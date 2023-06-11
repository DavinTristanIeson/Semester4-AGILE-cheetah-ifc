import 'package:flutter/material.dart';
import 'name_fields.dart';
import 'component.dart';
import 'email_fields.dart';
import 'password_fields.dart';
import 'button.dart';
import 'gender.dart';
import 'phone_fields.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _selectedGender = 'pria';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding:
            const EdgeInsets.only(bottom: 24, left: 16, right: 16, top: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            EmailField(
              controller: _emailController,
            ),
            PasswordFields(
              newPasswordController: _passwordController,
              oldPasswordController: _oldPasswordController,
            ),
            NameField(controller: _nameController),
            GenderSelection(
              selectedGender: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value;
                });
              },
            ),
            PhoneField(
              controller: _phoneController,
            ),
            const SizedBox(height: 16.0),
            SaveButton(
              onPressed: () {
                if (_passwordController.text.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Masukkan Password Lama'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextField(
                            controller: _oldPasswordController,
                            hintText: 'Masukkan password lama',
                          ),
                        ],
                      ),
                      actions: [
                        SaveButton(
                          onPressed: () {
                            // Validasi password lama dan simpan data jika valid
                            // ...
                            Navigator.pop(context); // Tutup dialog
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Perubahan berhasil disimpan'),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  // Simpan data jika password baru tidak diisi
                  // ...
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Perubahan berhasil disimpan'),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 16.0),
            DeleteAccountButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Masukkan Password Lama'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomTextField(
                          controller: _oldPasswordController,
                          hintText: 'Masukkan password lama',
                        ),
                      ],
                    ),
                    actions: [
                      DeleteAccountButton(
                        onPressed: () {
                          // Validasi password lama dan hapus akun jika valid
                          // ...
                          Navigator.pop(context); // Tutup dialog
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Akun berhasil dihapus'),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
