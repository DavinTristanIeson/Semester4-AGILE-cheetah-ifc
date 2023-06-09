import 'package:cheetah_mobile/components/function/fetch_wrapper.dart';
import 'package:cheetah_mobile/helpers/keys.dart';
import 'package:cheetah_mobile/views/order/ordering.dart';
import 'package:cheetah_mobile/views/order/wait/main.dart';
import 'package:flutter/material.dart';

import '../../requests/orders.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return FetchWrapper(
      key: currentTransactionKey,
      fetch: getOngoing,
      builder: (context, data) {
        return WaitView(data!);
      },
      emptyComponent: const OrderingView(),
    );
  }
}