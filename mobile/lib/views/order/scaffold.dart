import 'package:cheetah_mobile/helpers/constants.dart';
import 'package:cheetah_mobile/helpers/mixins.dart';
import 'package:cheetah_mobile/helpers/providers.dart';
import 'package:cheetah_mobile/requests/menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ongoing_orders.dart';

class OrderViewAppBar extends StatefulWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
  const OrderViewAppBar({super.key});

  @override
  State<OrderViewAppBar> createState() => _OrderViewAppBarState();
}

class _OrderViewAppBarState extends State<OrderViewAppBar> with SnackbarMessenger {
  bool _isSearching = false;
  final FocusNode _focusSearch = FocusNode(canRequestFocus: true);
  final TextEditingController _search = TextEditingController(text: "");


  Widget buildRegularTitle(){
    return const Text("The Savory Spoon",
        style: TextStyle(
        fontFamily: "JosefinSans",
        fontSize: 24,
        fontWeight: FontWeight.bold,
    ));
  }
  
  Widget buildSearchTitle(BuildContext context){
    final provider = context.watch<MenuParamsProvider>();
    _search.text = provider.search;
    return Theme(
      data: ThemeData(
        textTheme: TextTheme(
          titleMedium: Theme.of(context).textTheme.bodyMedium,
        )
      ),
      child: TextField(
        controller: _search,
        focusNode: _focusSearch,
        decoration: const InputDecoration(
          border: InputBorder.none,
          fillColor: COLOR_SECONDARY,
          filled: true,
          hintText: 'Cari dengan nama',
        ),
        onSubmitted: (value) {
          setState(() => _isSearching = false);
          context.read<MenuParamsProvider>().setSearch(value);
        },
        onTapOutside: (_) => setState(() => _isSearching = false),
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
          return button;
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
      title: _isSearching ? buildSearchTitle(context) : buildRegularTitle(),
      actions: _isSearching ? [] : [
        IconButton(
          icon: const Icon(Icons.search, color: COLOR_SECONDARY),
          onPressed: (){
            setState(() => _isSearching = true);
            _focusSearch.requestFocus();
          },
        ),
        buildFilterButton(context),
        IconButton(
          icon: provider.isGridView ?
            const Icon(Icons.grid_3x3, color: COLOR_SECONDARY) :
            const Icon(Icons.list, color: COLOR_SECONDARY),
          onPressed: provider.toggleGridView,
        ),
      ],
    );
  }
}
class OrderViewFAB extends StatelessWidget {
  const OrderViewFAB({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.list_alt),
      onPressed: () {
        showBottomSheet(
          context: context,
          builder: (context) => ChangeNotifierProvider.value(
            value: context.read<OrdersProvider>(),
            child: const OngoingOrdersBottomSheet()
          )
        );
      }
    );
  }
}

class OrderFilterPopup extends StatelessWidget {
  final String? category;
  final List<String> filterCategories;
  final void Function(String?)? onSelected;
  const OrderFilterPopup({super.key, required this.category, required this.filterCategories, this.onSelected});

  Widget buildDialogHeader(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
      ),
    );
  }

  String formatCategory(String category){
    return (category[0].toUpperCase() + category.substring(1))
      .split('-').join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MenuParamsProvider>();
    return Material(
      child: Column(
        children: [
          buildDialogHeader(context),
          Expanded(
            child: ListView.builder(
              itemCount: provider.filterCategories.length,
              itemBuilder: (context, idx) {
                String category = provider.filterCategories[idx];
                return RadioListTile(
                  activeColor: COLOR_DARK,
                  groupValue: provider.category,
                  value: category,
                  title: Text(formatCategory(category), style: Theme.of(context).textTheme.titleMedium),
                  onChanged: (String? value) {
                    if (onSelected != null)
                      onSelected!(value);
                    Navigator.of(context).pop();
                  },
                );
              }
            ),
          )
        ],
      ),
    );
  }
}