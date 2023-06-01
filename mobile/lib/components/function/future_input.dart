import 'package:cheetah_mobile/helpers/mixins.dart';
import 'package:flutter/material.dart';

class FutureButton extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onPressed;
  const FutureButton({super.key, required this.child, required this.onPressed});

  @override
  State<FutureButton> createState() => _FutureButtonState();
}

class _FutureButtonState extends State<FutureButton> with SnackbarMessenger {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return _isLoading ?
    ElevatedButton.icon(
      onPressed: null,
      icon: const CircularProgressIndicator(),
      label: widget.child,
    ) :
    ElevatedButton(
      onPressed: () {
        setState(() => _isLoading = true);
        widget.onPressed()
          .onError((err, stackTrace) {
            sendError(context, err.toString());
          })
          .whenComplete(() => _isLoading = false);
      },
      child: widget.child,
    );
  }
}