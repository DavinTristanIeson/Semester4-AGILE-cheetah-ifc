import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:cheetah_mobile/helpers/providers.dart';
import 'package:cheetah_mobile/views/order/menu_item.dart';
import 'package:cheetah_mobile/views/order/ongoing_orders.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../helpers/model.dart';
import '../../requests/menu.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  final PagingController<int, MenuItem> _pagination =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagination.addPageRequestListener(fetchMenu);
    super.initState();
  }

  Future<void> fetchMenu(int page) async {
    try {
      final result = await getMenu(page);
      final isLastPage = page >= result.pages;
      _pagination.appendPage(result.data, isLastPage ? null : page + 1);
    } catch (error) {
      _pagination.error = error;
    }
  }

  Widget buildList() {
    return PagedListView<int, MenuItem>(
        pagingController: _pagination,
        builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, item, index) => Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: GAP_SM, horizontal: GAP_LG),
                child: MenuItemComponent(
                  item: item,
                  isGridView: false,
                ))));
  }

  Widget buildGrid() {
    return PagedGridView<int, MenuItem>(
        pagingController: _pagination,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 360.0, mainAxisExtent: 480.0),
        builderDelegate: PagedChildBuilderDelegate(
          itemBuilder: (context, item, index) => Padding(
              padding: const EdgeInsets.all(GAP_SM),
              child: MenuItemComponent(
                item: item,
                isGridView: true,
              )),
        ));
  }

  @override
  Widget build(BuildContext context) {
    bool isGridView = context.watch<OrdersProvider>().isGridView;
    return Material(
      type: MaterialType.transparency,
      child: Column(
        children: [
          SizedBox(
            height: 60.0,
            width: 100.0,
            child: ElevatedButton(
              child: const Text("Test"),
              onPressed: () => showBottomSheet(
                  context: context,
                  builder: (context) => const OngoingOrdersBottomSheet()),
            ),
          ),
          Expanded(child: isGridView ? buildGrid() : buildList()),
        ],
      ),
    );
  }
}
