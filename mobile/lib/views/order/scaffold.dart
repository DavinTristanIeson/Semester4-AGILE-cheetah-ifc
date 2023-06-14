import 'package:cheetah_mobile/components/function/appbar_brand.dart';
import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:cheetah_mobile/helpers/keys.dart';
import 'package:cheetah_mobile/helpers/mixins.dart';
import 'package:cheetah_mobile/helpers/providers.dart';
import 'package:cheetah_mobile/requests/menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dialog.dart';
import 'ongoing_orders.dart';

class OrderViewAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
  const OrderViewAppBar({super.key});

  @override
  State<OrderViewAppBar> createState() => _OrderViewAppBarState();
}

class _OrderViewAppBarState extends State<OrderViewAppBar> with SnackbarMessenger {
  final TextEditingController _search = TextEditingController(text: "");
  
  Widget buildSearchTitle(BuildContext context){
    final provider = context.watch<MenuParamsProvider>();
    _search.text = provider.search;
    return Padding(
      padding: const EdgeInsets.all(GAP),
      child: TextField(
        controller: _search,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.only(left: GAP_LG, right: GAP),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(40.0)),
            borderSide: BorderSide.none,
          ),
          fillColor: COLOR_SECONDARY,
          filled: true,
          hintText: 'Cari dengan nama',
        ),
        onSubmitted: (value) {
          context.read<MenuParamsProvider>().setSearch(value);
        },
      ),
    );
  }

  Widget buildFilterButton(BuildContext context){
    final provider = context.watch<MenuParamsProvider>();
    final IconButton button = IconButton(
      icon: const Icon(Icons.filter_alt, color: COLOR_SECONDARY),
      onPressed: (){
        showDialog(
          context: context,
          builder: (context) => ChangeNotifierProvider<MenuParamsProvider>.value(
            value: provider,
            builder: (context, _) => OrderFilterPopup(
              filterCategories: provider.filterCategories,
              category: provider.category,
              onSelected: (category) => context.read<MenuParamsProvider>().setCategory(category),
            ),
          ));
      },
    );
    const IconButton disabledButton = IconButton(
      icon: Icon(Icons.filter_alt, color: COLOR_SECONDARY),
      onPressed: null,
    );
    if (provider.filterCategories.isNotEmpty){
      return button;
    }
    return FutureBuilder(
      future: getFilterCategories(),
      builder: (context, data) {
        if (data.hasData){
          provider.filterCategories = data.data!;
          return Tooltip(message: "Filter berdasarkan kategori", child: button);
        } else if (data.hasError){
          sendError(context, data.error.toString());
          return disabledButton;
        } else {
          return disabledButton;
        }
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MenuParamsProvider>();
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          if (MediaQuery.of(context).size.width > 768)
            const Padding(
              padding: EdgeInsets.only(right: GAP_LG),
              child: TheSavorySpoonAppBarBrand()
            ),
          Expanded(child: buildSearchTitle(context))
        ]
      ),
      actions: [
        buildFilterButton(context),
        Tooltip(
          message: provider.isGridView ? "Mode List" : "Mode Grid",
          child: IconButton(
            icon: provider.isGridView ?
              const Icon(Icons.list, color: COLOR_SECONDARY) :
              const Icon(Icons.grid_3x3, color: COLOR_SECONDARY),
            onPressed: provider.toggleGridView,
          ),
        ),
      ],
    );
  }
}

/* Pertemuan 7
- Floating Action Button

Pertemuan 13
- Tooltip */
class OrderViewFAB extends StatelessWidget {
  const OrderViewFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "Buka Pesanan Sekarang",
      child: FloatingActionButton(
        child: const Icon(Icons.list_alt),
        onPressed: () {
          showBottomSheet(
            context: context,
            builder: (context) => ChangeNotifierProvider.value(
              value: context.read<OrdersProvider>(),
              child: OngoingOrdersBottomSheet(key: ongoingOrdersBottomSheetKey)
            )
          );
        }
      ),
    );
  }
}