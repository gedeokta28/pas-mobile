import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';

import '../../../../core/presentation/widgets/custom_search_bar.dart';
import '../../../../core/static/dimens.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: primaryColor,
        title: CustomSearchBar(
          hint: "Search",
          height: kToolbarHeight - SIZE_MEDIUM,
          onSubmitted: (value) {},
          focusNode: FocusNode(),
        ),
        actions: [
          ClipRRect(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                child: const Padding(
                  padding:
                      EdgeInsets.only(left: 8.0, top: 5, right: 5, bottom: 5),
                  child: Icon(
                    Icons.account_circle,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
          ClipRRect(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.notifications,
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
          ClipRRect(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                child: const Padding(
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.shopping_cart,
                    size: 30.0,
                    color: Colors.white,
                  ),
                ),
                onTap: () {},
              ),
            ),
          ),
        ],
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.category_sharp,
            color: Colors.white,
            size: 30.0,
          ),
        ));
  }
}
