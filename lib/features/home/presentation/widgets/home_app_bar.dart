import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:pas_mobile/core/presentation/widgets/custom_simple_dialog.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/core/utility/session_helper.dart';
import 'package:pas_mobile/features/cart/presentation/providers/cart_provider.dart';
import 'package:pas_mobile/features/category/presentation/category_page.dart';
import 'package:pas_mobile/features/notification/presentation/notif_page.dart';
import 'package:pas_mobile/features/notification/presentation/notification_provider.dart';
import 'package:pas_mobile/features/search/presentation/pages/search_page.dart';
import 'package:provider/provider.dart';

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
            hint: "Cari produk",
            isFromHome: true,
            height: kToolbarHeight - SIZE_MEDIUM,
            onSubmitted: (value) {},
            focusNode: FocusNode(),
          ),
        ),
        actions: [
          sessionHelper.isLoggedIn
              ? AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Stack(
                    children: [
                      Consumer<NotificationProvider>(
                          builder: (context, provider, _) =>
                              LayoutBuilder(builder: (_, constraints) {
                                return Center(
                                  child: ClipRRect(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        child: Padding(
                                          padding: sessionHelper.isLoggedIn
                                              ? const EdgeInsets.all(5)
                                              : const EdgeInsets.only(
                                                  left: 15.0,
                                                  top: 5,
                                                  right: 5,
                                                  bottom: 5),
                                          child: const Icon(
                                            Icons.notifications,
                                            size: 30.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.pushNamed(context,
                                                  NotificationPage.routeName)
                                              .then((_) {
                                            provider.calculateNotif();
                                            logMe(provider.countNotifOrder);
                                            logMe(provider.countNotif);
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              })),
                      Consumer<NotificationProvider>(
                        builder: (context, provider, _) =>
                            LayoutBuilder(builder: (_, constraints) {
                          if ((provider.countNotifOrder +
                                  provider.countNotif) ==
                              0) {
                            return const SizedBox.shrink();
                          } else {
                            final size = (constraints.maxWidth / 2) - 15.0;
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                        context, NotificationPage.routeName)
                                    .then((_) {
                                  provider.calculateNotif();
                                  logMe(provider.countNotifOrder);
                                  logMe(provider.countNotif);
                                });
                              },
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  margin: const EdgeInsets.all(12.0),
                                  padding: const EdgeInsets.all(2.0),
                                  width: size,
                                  height: size,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: ERROR_RED_COLOR,
                                  ),
                                ),
                              ),
                            );
                          }
                        }),
                      )
                    ],
                  ),
                )
              : const SizedBox(
                  width: 10.0,
                ),
          sessionHelper.isLoggedIn
              ? AspectRatio(
                  aspectRatio: 1 / 1,
                  child: Stack(
                    children: [
                      Consumer<CartProvider>(
                          builder: (context, provider, _) =>
                              LayoutBuilder(builder: (_, constraints) {
                                return Center(
                                  child: ClipRRect(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        child: Padding(
                                          padding: sessionHelper.isLoggedIn
                                              ? const EdgeInsets.all(5)
                                              : const EdgeInsets.only(
                                                  left: 15.0,
                                                  top: 5,
                                                  right: 5,
                                                  bottom: 5),
                                          child: const Icon(
                                            Icons.shopping_cart,
                                            size: 30.0,
                                            color: Colors.white,
                                          ),
                                        ),
                                        onTap: () {
                                          if (locator<Session>()
                                                  .sessionCustomerId ==
                                              '') {
                                            showDialog(
                                                barrierDismissible: false,
                                                context: context,
                                                builder: (context) {
                                                  return CustomSimpleDialog(
                                                      text:
                                                          'Pilih Customer Terlebih Dahulu !',
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      });
                                                });
                                          } else {
                                            Navigator.pushNamed(
                                                    context, CartPage.routeName)
                                                .then((_) {
                                              provider.countTotalCartItem();
                                            });
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              })),
                      Consumer<CartProvider>(
                        builder: (context, provider, _) =>
                            LayoutBuilder(builder: (_, constraints) {
                          if (provider.isLoadCart) {
                            return const SizedBox.shrink();
                          } else {
                            final size = (constraints.maxWidth / 2) - 8.0;
                            if (provider.totalCartItem == 0) {
                              return const SizedBox.shrink();
                            }
                            return InkWell(
                              onTap: () {
                                if (locator<Session>().sessionCustomerId ==
                                    '') {
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return CustomSimpleDialog(
                                            text:
                                                'Pilih Customer Terlebih Dahulu !',
                                            onTap: () {
                                              Navigator.pop(context);
                                            });
                                      });
                                } else {
                                  Navigator.pushNamed(
                                          context, CartPage.routeName)
                                      .then((_) {
                                    provider.countTotalCartItem();
                                  });
                                }
                              },
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                    margin: const EdgeInsets.all(7.0),
                                    padding: const EdgeInsets.all(2.0),
                                    width: size,
                                    height: size,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ERROR_RED_COLOR,
                                    ),
                                    child: AutoSizeText(
                                      provider.totalCartItem.toString(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      minFontSize: 8.0,
                                    )),
                              ),
                            );
                          }
                        }),
                      )
                    ],
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
                // icon: const Icon(
                //   Icons.category_sharp,
                //   color: Colors.white,
                //   size: 30.0,
                // ),
                icon: Image.asset(CATEGORY_ICON),
              )
            : const CustomBackButton(
                iconTint: Colors.white,
              ));
  }
}
