import 'package:cheetah_mobile/components/display/menu.dart';
import 'package:cheetah_mobile/helpers/providers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../helpers/model.dart';

class MenuItemComponent extends StatelessWidget {
  final MenuItem item;
  final bool isGridView;
  const MenuItemComponent({super.key, required this.item, this.isGridView = true});

  onTap(BuildContext context, MenuItem item) {
    context.read<OrdersProvider>().add(item);
  }

  @override
  Widget build(BuildContext context) {
    return isGridView
        ? MenuCard(item: item, onTap: () => onTap(context, item))
        : MenuListItem(item: item, onTap: () => onTap(context, item));
  }
}
