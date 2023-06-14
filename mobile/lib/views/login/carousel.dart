import 'dart:async';

import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:flutter/material.dart';

import '../../components/display/image.dart';

/* Pertemuan 15
- Carousel */
class LoginViewCarousel extends StatefulWidget {

  const LoginViewCarousel({super.key});

  @override
  State<LoginViewCarousel> createState() => _LoginViewCarouselState();
}

class _LoginViewCarouselState extends State<LoginViewCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.8);
  late Timer _timer;
  int current = 0;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      final newPage =  (_controller.page?.round() ?? 0) + 1;
      setState(() {
        current = newPage;
      });
      _controller.animateToPage(
        newPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic);
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  final List<String> images = [
    "https://goldbelly.imgix.net/uploads/showcase_media_asset/image/126887/dry-aged-boneless-ribeye-steak-dinner-for-4.81c3bdc05fe6bdb2c2214709863120e0.jpg?ixlib=react-9.0.2&auto=format&ar=1%3A1",
    "https://goldbelly.imgix.net/uploads/showcase_media_asset/image/86731/memphis-pulled-pork-shoulder-4-lbs.089448f3aebd24fe82f223151314d853.jpg?ixlib=react-9.0.2&auto=format&ar=1%3A1",
    "https://goldbelly.imgix.net/uploads/showcase_media_asset/image/75464/carolina-pulled-pork-sandwich-pack.8e672a876d720c8471b08ffa47fbbbc1.jpg?ixlib=react-9.0.2&auto=format&ar=1%3A1",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
      ),
      height: 200.0,
      child: PageView.builder(
        controller: _controller,
        pageSnapping: true,
        onPageChanged: (page) => setState(() => current = page),
        itemBuilder: ((context, index) => AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
          margin: EdgeInsets.all(current == index ? GAP : GAP_LG),
          child: MaybeImage(
              url: images[index % 3],
            ),
        )
        )
      )
    );
  }
}