import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/widgets/custom_search_bar.dart';
import '../../../features/search/presentation/providers/search_provider.dart';
import '../../static/dimens.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(builder: (context, search, _) {
      return AppBar(
        centerTitle: false,
        titleSpacing: 10,
        backgroundColor: Colors.white,
        title: Consumer<SearchProvider>(builder: (context, search, _) {
          return CustomSearchBar(
            hint: "Cari Produk",
            height: kToolbarHeight - SIZE_MEDIUM,
            controller: search.controller,
            onSubmitted: (value) {
              search.filterProduct(value).listen((event) {});
            },
            onClear: () {
              search.controller.clear();
            },
            focusNode: search.focusNode,
            onFocus: (focus) => search.setFocus = focus,
            onChanged: (value) {
              search.searchProductList(value).listen((event) {});
            },
          );
        }),
        leading: IconButton(
          splashRadius: 20.0,
          onPressed: () {
            search.unfocus();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
      );
    });
  }
}
