import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:flutter/material.dart';

import '../../helpers/styles.dart';

class OverInkwell extends StatelessWidget {
  final Widget child;
  final Color? splashColor;
  final void Function()? onTap;
  const OverInkwell({super.key,
    required this.child,
    this.splashColor,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          bottom: 0.0,
          child: child,
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: splashColor ?? Theme.of(context).colorScheme.onBackground,
              onTap: onTap,
            ),
          ),
        )
      ],
    );
  }
}

class DialogHeader extends StatelessWidget {
  final String? title;
  const DialogHeader({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Row(
        mainAxisAlignment: title != null ?
          MainAxisAlignment.spaceBetween :
          MainAxisAlignment.end,
        children: [
          if (title != null)
            Text(title!, style: TEXT_ITEM_TITLE),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }
}

class TextLink extends StatelessWidget {
  final void Function() onPressed;
  final String label;
  final double fontSize;
  const TextLink({
    super.key,
    required this.onPressed,
    required this.label,
    this.fontSize = FS_EMPHASIS});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
          fontSize: fontSize,
          fontFamily: FONT,
        ),
      ),
    );
  }
}