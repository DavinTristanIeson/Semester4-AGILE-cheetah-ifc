
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../components/function/fetch_wrapper.dart';
import 'model.dart';

final GlobalKey<FetchWrapperState<MenuTransaction?>> currentTransactionKey = GlobalKey();
final GlobalKey<FormBuilderState> loginFormKey = GlobalKey();
