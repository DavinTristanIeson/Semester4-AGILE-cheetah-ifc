import 'package:flutter/material.dart';

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
            Text(title!, style: Theme.of(context).textTheme.displayMedium),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }
}