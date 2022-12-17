import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/features/category/presentation/category_page.dart';
import 'package:pas_mobile/features/login/presentation/login_page.dart';
import 'package:pas_mobile/features/notification/presentation/notif_page.dart';
import 'package:pas_mobile/features/search/presentation/pages/search_page.dart';

import '../../../../core/presentation/widgets/custom_back_button.dart';
import '../../../../core/presentation/widgets/custom_search_bar.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/injection.dart';
import '../../../cart/presentation/cart_page.dart';

class HomeAppBar extends StatelessWidget {
  final bool isFromHome;
  const HomeAppBar({Key? key, this.isFromHome = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: false,
        titleSpacing: 0,
        backgroundColor: primaryColor,
        title: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, SearchPage.routeName);
          },
          child: CustomSearchBar(
            hint: "Search",
            isFromHome: true,
            height: kToolbarHeight - SIZE_MEDIUM,
            onSubmitted: (value) {},
            focusNode: FocusNode(),
          ),
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
                      onTap: () {
                        Navigator.pushNamed(
                            context, NotificationPage.routeName);
                      },
                    ),
                  ),
                )
              : const SizedBox(
                  width: 10.0,
                ),
          sessionHelper.isLoggedIn
              ? ClipRRect(
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
                      onTap: () {
                        Navigator.pushNamed(context, CartPage.routeName);
                      },
                    ),
                  ),
                )
              : const SizedBox(),
        ],
        leading: isFromHome
            ? IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRight,
                      child: const CategoryPage(),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.category_sharp,
                  color: Colors.white,
                  size: 30.0,
                ),
              )
            : const CustomBackButton(
                iconTint: Colors.white,
              ));
  }
}
