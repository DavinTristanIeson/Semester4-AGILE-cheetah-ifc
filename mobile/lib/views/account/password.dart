import 'package:cheetah_mobile/helpers/styles.dart';
import 'package:flutter/material.dart';

import '../../helpers/constants.dart';

/* Pertemuan 3
- Text Button
- Text Field */
class RequirePasswordDialog extends StatefulWidget {
  final String title;
  final String? description;
  final Widget Function(BuildContext, TextEditingController) actionBuilder;
  const RequirePasswordDialog({
    super.key,
    required this.title,
    this.description,
    required this.actionBuilder
  });

  @override
  State<RequirePasswordDialog> createState() => _RequirePasswordDialogState();
}

class _RequirePasswordDialogState extends State<RequirePasswordDialog> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.description != null)
            Padding(
              padding: const EdgeInsets.only(bottom: GAP_LG),
              child: Text(widget.description!, style: TEXT_DEFAULT)
            ),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Masukkan kata sandi sekarang',
            ),
            obscureText: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () { Navigator.pop(context); },
          child: const Text("BATAL", style: TEXT_LINK),
        ),
        widget.actionBuilder(context, _controller),
      ]);
  }
}