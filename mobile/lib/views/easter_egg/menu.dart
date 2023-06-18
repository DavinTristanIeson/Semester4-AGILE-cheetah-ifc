import 'dart:math';

import 'package:cheetah_mobile/helpers/styles.dart';
import 'package:flutter/material.dart';

import '../../helpers/constants.dart';

enum FilterColor {
  Merah,
  Hijau,
  Biru,
}
/* Pertemuan 11
- Menu */
class MenuShowcasePage extends StatefulWidget {
  const MenuShowcasePage({super.key});

  @override
  State<MenuShowcasePage> createState() => _MenuShowcasePageState();
}

class _MenuShowcasePageState extends State<MenuShowcasePage> {
  List<FilterColor> filters = [];
  final rng = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  Widget buildBody(){
    int redLimit = filters.contains(FilterColor.Merah) ? 1 : 255;
    int blueLimit = filters.contains(FilterColor.Biru) ? 1 : 255;
    int greenLimit = filters.contains(FilterColor.Hijau) ? 1 : 255;
    return ListView.builder(
      itemBuilder: (context, idx) {
        int red = rng.nextInt(redLimit);
        int green = rng.nextInt(greenLimit);
        int blue = rng.nextInt(blueLimit);
        double luminance = 0.299 * red + 0.587 * green + 0.114 * blue;
        return Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(red, green, blue, 1)
          ),
          height: GAP_LG * 4,
          child: Center(
            child: Text("R: $red, G: $green, B: $blue",
            style: TEXT_IMPORTANT.copyWith(color: luminance > 96 ? Colors.black : Colors.white),
            textAlign: TextAlign.center,
          )),
        );
      }
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text("Demonstrasi Menu"),
      actions: [
        PopupMenuButton(
          itemBuilder: (context) => <PopupMenuEntry>[
            for (final color in FilterColor.values)
              PopupMenuItem(
                onTap: () => setState(() {
                  if (filters.contains(color)) filters.remove(color);
                  else filters.add(color);
                }),
                child: Row(
                  children: [
                    Text("Tanpa ${color.name}"),
                    if (filters.contains(color))
                      const Icon(Icons.check),
                  ],
                )
              ),
            const PopupMenuDivider(),
            PopupMenuItem(
              onTap: () => setState(() => filters.clear()),
              child: const Text("Pakai Semua Warna"),
            )
          ]
        )
      ]
    );
  }
}