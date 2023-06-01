import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final String asset;
  // Number between 0 to 1 that determines how dark the image is
  final double? darkenRate;
  final Widget? child;
  const BackgroundImage({super.key, required this.asset, this.child, this.darkenRate});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          colorFilter: ColorFilter.mode(Color.fromRGBO(0, 0, 0, darkenRate ?? 0.5), BlendMode.darken),
          fit: BoxFit.cover,
          image: AssetImage(asset)
        )
      ),
      child: child,
    );
  }
}