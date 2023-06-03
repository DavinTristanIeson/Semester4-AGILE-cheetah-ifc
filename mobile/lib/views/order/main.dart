import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:cheetah_mobile/helpers/providers.dart';
import 'package:cheetah_mobile/views/order/menu_item.dart';
import 'package:cheetah_mobile/views/order/scaffold.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

import '../../helpers/model.dart';
import '../../requests/menu.dart';

class OrderView extends StatelessWidget {
  // Wrapper agar MainView tidak akan bertanggungjawab atas state management, dan karena tidak bisa watch
  // nilai provider dalam initState
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<OrdersProvider>();
    return _OrderView(search: provider.search, category: provider.category,);
  }
}

class _OrderView extends StatefulWidget {
  final String search;
  final String? category;

  const _OrderView({super.key, required this.search, required this.category});

  @override
  State<_OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<_OrderView> {

  final PagingController<int, MenuItem> _pagination =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagination.addPageRequestListener(fetchMenu);
    super.initState();
  }

  Future<void> fetchMenu(int page) async {
    try {
      print(widget.search);
      print(widget.category);
      final result = await getMenu(page, search: widget.search, category: widget.category);
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
    bool isGridView = context.watch<OrdersProvider>().isGridView;
    return Stack(
      children: [
        Material(
          type: MaterialType.transparency,
          child: isGridView ? buildGrid(context) : buildList(),
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
