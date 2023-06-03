import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  final String asset;
  // Number between 0 to 1 that determines how dark the image is
  final double? darkenRate;
  final Widget? child;
  const BackgroundImage(
      {super.key, required this.asset, this.child, this.darkenRate});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
          image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Color.fromRGBO(0, 0, 0, darkenRate ?? 0.5), BlendMode.darken),
              fit: BoxFit.cover,
              image: AssetImage(asset))),
      child: child,
    );
  }
}


class MaybeImage extends StatelessWidget {
  final String url;
  final BoxFit? fit;
  final double? width;
  final double? height;
  const MaybeImage({super.key, required this.url, this.fit, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      width: width,
      height: height,
      image: NetworkImage(url),
      placeholder: const AssetImage(FALLBACK_IMAGE_PATH),
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset(
          FALLBACK_IMAGE_PATH,
          fit: fit ?? BoxFit.cover,
        );
      },
      fit: fit ?? BoxFit.cover,
    );
  }
}
