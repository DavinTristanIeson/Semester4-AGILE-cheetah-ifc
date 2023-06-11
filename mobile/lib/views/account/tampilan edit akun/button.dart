import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SaveButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text(
        'Simpan',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class DeleteAccountButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DeleteAccountButton({Key? key, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red, // Warna latar merah
      ),
      child: const Text(
        'Delete Account',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
