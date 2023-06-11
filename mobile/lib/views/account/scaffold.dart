import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:cheetah_mobile/helpers/keys.dart';
import 'package:cheetah_mobile/helpers/styles.dart';
import 'package:cheetah_mobile/requests/accounts.dart';
import 'package:flutter/material.dart';

class AccountViewAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
  const AccountViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("The Savory Spoon",
      style: TextStyle(
        fontFamily: "JosefinSans",
        fontSize: 24,
        fontWeight: FontWeight.bold,
      )),
      actions: [
        TextButton(
          onPressed: () async {
            await logout();
            loginKey.currentState?.refetch();
          },
          child: Text("Logout", style: TEXT_LINK.copyWith(color: COLOR_SECONDARY)),
        )
      ],
    );
  }
}