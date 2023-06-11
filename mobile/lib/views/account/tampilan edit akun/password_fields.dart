import 'package:flutter/material.dart';
import 'component.dart';

class PasswordFields extends StatelessWidget {
  final TextEditingController newPasswordController;
  final TextEditingController oldPasswordController;

  const PasswordFields({
    Key? key,
    required this.newPasswordController,
    required this.oldPasswordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16.0),
        const Text(
          'Password Baru',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        CustomTextField(
          controller: newPasswordController,
          hintText: '',
        ),
        if (newPasswordController.text.isNotEmpty) ...[
          const SizedBox(height: 16.0),
          const Text(
            'Password Lama',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          CustomTextField(
            controller: oldPasswordController,
            hintText: 'Masukkan password lama',
          ),
        ],
      ],
    );
  }
}
