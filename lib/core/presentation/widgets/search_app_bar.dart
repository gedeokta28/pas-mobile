import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/helper.dart';
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
              search.setSearch = true;
            },
            focusNode: search.focusNode,
            onFocus: (focus) => search.setFocus = focus,
            onChanged: (value) {
              // if (value == "") {
              //   logMe("emptyyyy");
              //   search.clearList();
              // }
              search.setSearch = value;
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