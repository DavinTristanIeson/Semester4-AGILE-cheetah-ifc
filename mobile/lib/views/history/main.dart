import 'package:cheetah_mobile/components/display/orders.dart';
import 'package:cheetah_mobile/helpers/mixins.dart';
import 'package:cheetah_mobile/helpers/model.dart';
import 'package:cheetah_mobile/requests/orders.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../helpers/constants.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> with SnackbarMessenger {
  final PagingController<int, MenuTransaction> _pagination =
      PagingController(firstPageKey: 0);

  Future<void> fetchHistory(int page) async {
    try {
      final PaginatedApiResult<MenuTransaction> result = await getHistory(page);
      final isLastPage = page >= result.pages;
      _pagination.appendPage(result.data, isLastPage ? null : page + 1);
    } catch (e){
      sendError(context, e.toString());
    }
  }

  @override
  void dispose() {
    _pagination.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _pagination.addPageRequestListener(fetchHistory);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PagedListView<int, MenuTransaction>(
      pagingController: _pagination,
      builderDelegate: PagedChildBuilderDelegate(
        itemBuilder: (context, item, index) => Padding(
          padding: const EdgeInsets.symmetric(
            vertical: GAP_SM, horizontal: GAP_LG
          ),
          child: MenuTransactionItem(
            item: item,
          )
        )
      )
    );
  }
}