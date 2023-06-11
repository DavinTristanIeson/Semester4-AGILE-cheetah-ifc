import 'package:cheetah_mobile/components/function/fetch_wrapper.dart';
import 'package:cheetah_mobile/helpers/keys.dart';
import 'package:flutter/material.dart';

import '../../requests/accounts.dart';
import 'form.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return FetchWrapper(
      key: accountKey,
      fetch: getAccount,
      builder: (context, data) {
        return AccountForm(data);
      }
    );
  }
}