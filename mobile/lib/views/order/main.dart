import 'package:cheetah_mobile/components/display/menu.dart';
import 'package:cheetah_mobile/components/function/fetch_wrapper.dart';
import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:cheetah_mobile/helpers/providers.dart';
import 'package:cheetah_mobile/requests/menu.dart';
import 'package:cheetah_mobile/views/order/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/model.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    List<MenuItem> data = context.watch<MenuItemProvider>().items;
    return Material(
        type: MaterialType.transparency,
        child: ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            itemBuilder: (context, idx) => Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: GAP_SM, horizontal: GAP_LG),
                child: MenuItemComponent(item: data[idx]))));
  }
}
