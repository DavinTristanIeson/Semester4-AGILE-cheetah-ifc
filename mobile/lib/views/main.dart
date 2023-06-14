import 'package:cheetah_mobile/components/function/appbar_brand.dart';
import 'package:cheetah_mobile/helpers/keys.dart';
import 'package:cheetah_mobile/views/account/scaffold.dart';
import 'package:cheetah_mobile/views/order/scaffold.dart';
import 'package:flutter/material.dart';

import '../components/display/image.dart';
import '../helpers/constants.dart';
import 'account/main.dart';
import 'history/main.dart';
import 'order/main.dart';

/* Pertemuan 7
- App Bar
- Bottom Navigation Bar */
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _view = 0;

  PreferredSizeWidget? buildAppBar() {
    if (_view == 0){
      return const OrderViewAppBar();
    } else if (_view == 2){
      return const AccountViewAppBar();
    }
    return AppBar(
      title: const TheSavorySpoonAppBarBrand(),
    );
  }

  Widget buildView() {
    switch (_view) {
      case 1:
        return const HistoryView();
      case 2:
        return const AccountView();
      case 0:
      default:
        return const OrderView();
    }
  }

  Widget buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: COLOR_DARK,
      selectedItemColor: COLOR_SECONDARY,
      unselectedItemColor: COLOR_PRIMARY,
      currentIndex: _view,
      onTap: (selected) {
        if (ongoingOrdersBottomSheetKey.currentContext != null){
          Navigator.of(ongoingOrdersBottomSheetKey.currentContext!).pop();
        }
        setState(() => _view = selected);
      },
      items: [
        BottomNavigationBarItem(
            icon: Icon(_view == 0 ? Icons.menu_book : Icons.menu_book_outlined),
            label: "Pesan"),
        BottomNavigationBarItem(
            icon: Icon(_view == 1 ? Icons.money : Icons.money_outlined),
            label: "Riwayat"),
        BottomNavigationBarItem(
            icon: Icon(_view == 2 ? Icons.person : Icons.person_outlined),
            label: "Akun")
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: BackgroundImage(
        asset: BACKGROUND_IMAGE_PATH,
        child: buildView(),
      ),
      bottomNavigationBar: buildBottomNavBar(context)
    );
  }
}
