import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:cheetah_mobile/helpers/providers.dart';
import 'package:cheetah_mobile/views/order/menu_item.dart';
import 'package:cheetah_mobile/views/order/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../helpers/model.dart';
import '../../requests/menu.dart';

class OrderingView extends StatefulWidget {
  const OrderingView({super.key});

  @override
  State<OrderingView> createState() => _OrderingViewState();
}

class _OrderingViewState extends State<OrderingView> {
  String search = "";
  String? category;
  final PagingController<int, MenuItem> _pagination =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    final provider = context.read<MenuParamsProvider>();
    search = provider.search;
    category = provider.category;
    _pagination.addPageRequestListener(fetchMenu);
    super.initState();
  }

  @override
  void dispose() {
    _pagination.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies(){
    final provider = context.read<MenuParamsProvider>();
    search = provider.search;
    category = provider.category;
    _pagination.refresh();
    super.didChangeDependencies();
  }

  Future<void> fetchMenu(int page) async {
    try {
      final result = await getMenu(page, search: search, category: category);
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

  Widget buildGrid(BuildContext context) {
    MediaQueryData screen = MediaQuery.of(context);
    return PagedGridView<int, MenuItem>(
        pagingController: _pagination,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: screen.size.width <= 375.0 ? 400.0 : 300.0,
            mainAxisExtent: 332.0
          ),
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
    final provider = context.watch<MenuParamsProvider>();
    return Stack(
      children: [
        Material(
          type: MaterialType.transparency,
          child: provider.isGridView ? buildGrid(context) : buildList(),
        ),
        const Positioned(
          bottom: 0.0,
          right: 0.0,
          child: Padding(
            padding: EdgeInsets.all(GAP_LG),
            child: OrderViewFAB()
          )
        ),
      ],
    );
  }
}
