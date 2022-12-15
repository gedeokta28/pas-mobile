import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/features/login/presentation/login_page.dart';

import '../../../../core/presentation/widgets/custom_search_bar.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/injection.dart';

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
          // ClipRRect(
          //   child: Material(
          //     color: Colors.transparent,
          //     child: InkWell(
          // child: const Padding(
          //   padding:
          //       EdgeInsets.only(left: 8.0, top: 5, right: 5, bottom: 5),
          //         child: Icon(
          //           Icons.account_circle,
          //           color: Colors.white,
          //           size: 30,
          //         ),
          //       ),
          //       onTap: () {
          //         Navigator.pushNamed(context, LoginPage.routeName);
          //       },
          //     ),
          //   ),
          // ),
          sessionHelper.isLoggedIn
              ? ClipRRect(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      child: const Padding(
                        padding: EdgeInsets.only(
                            left: 10.0, top: 5, right: 5, bottom: 5),
                        child: Icon(
                          Icons.notifications,
                          size: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      onTap: () {},
                    ),
                  ),
                )
              : const SizedBox(),
          ClipRRect(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                child: Padding(
                  padding: sessionHelper.isLoggedIn
                      ? const EdgeInsets.all(5)
                      : const EdgeInsets.only(
                          left: 15.0, top: 5, right: 5, bottom: 5),
                  child: const Icon(
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
