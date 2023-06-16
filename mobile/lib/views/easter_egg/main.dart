import 'package:cheetah_mobile/components/display/image.dart';
import 'package:cheetah_mobile/helpers/styles.dart';
import 'package:cheetah_mobile/views/easter_egg/menu.dart';
import 'package:cheetah_mobile/views/easter_egg/picker.dart';
import 'package:cheetah_mobile/views/easter_egg/tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../helpers/constants.dart';

/* Pertemuan 9
Navigation Drawer */
class EasterEggPage extends StatelessWidget {
  const EasterEggPage({super.key});

  Widget buildDrawer(BuildContext context){
    final navigator = Navigator.of(context);
    return Drawer(
      backgroundColor: COLOR_PRIMARY_DARK,
      child: Column(
        children: [
          SizedBox(
            height: 160.0,
            child: BackgroundImage(
              asset: BACKGROUND_IMAGE_PATH,
              child: Column(
                children: [
                  Expanded(child: SvgPicture.asset(LOGO_PATH)),
                  const Text("The Savory Spoon", style: TextStyle(
                    fontSize: FS_LARGE,
                    fontWeight: FontWeight.bold,
                    color: COLOR_BRIGHT,
                  ))
                ]),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text("Kembali ke Beranda", style: TEXT_DEFAULT),
            onTap: () => navigator.popUntil((route) => route.isFirst),
          ),
          ListTile(
            title: const Text("Minggu 9: Tab Bar", style: TEXT_DEFAULT),
            onTap: () => navigator.push(MaterialPageRoute(builder: (context) => const TabBarShowcasePage())),
          ),
          ListTile(
            title: const Text("Minggu 11: Menu", style: TEXT_DEFAULT),
            onTap: () => navigator.push(MaterialPageRoute(builder: (context) => const MenuShowcasePage())),
          ),
          ListTile(
            title: const Text("Minggu 14 & 15: Date/Time/Image Picker", style: TEXT_DEFAULT),
            onTap: () => navigator.push(MaterialPageRoute(builder: (context) => const DateTimePickerThemes(child: PickerShowcasePage()))),
          ),
          // Tambah list tile di bawah untuk ke halaman tersendiri
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: buildDrawer(context),
      body: Container(
        decoration: const BoxDecoration(
          color: COLOR_PRIMARY_DARK,
        ),
        padding: const EdgeInsets.all(GAP_LG),
        child: const Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Text("Selamat!", style: TextStyle(
              fontSize: FS_LARGE,
              fontWeight: FontWeight.bold,
              color: Colors.yellow
            )),
            Text("Anda berhasil menemukan halaman rahasia! Silahkan lihat-lihat sekeliling dengan menekan tombol di kiri atas!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: FS_DEFAULT,
              color: COLOR_BRIGHT,
            )),
          ],
        ),
      )
    );
  }
}