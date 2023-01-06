import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/features/product/presentation/providers/app_bar_provider.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/widgets/network_image.dart';
import '../../../../core/static/assets.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/injection.dart';

class ProductAppBar extends StatelessWidget {
  final String productId;
  const ProductAppBar({
    Key? key,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => locator<AppBarProvider>()
          ..fetchProductDetail(productId).listen((event) {}),
        builder: (context, child) => Consumer<AppBarProvider>(
              builder: (context, provider, _) => SliverAppBar(
                pinned: true,
                snap: false,
                floating: true,
                expandedHeight: 230.0,
                flexibleSpace: FlexibleSpaceBar(
                    background: provider.isLoadingProduct
                        ? Stack(children: <Widget>[
                            SizedBox(
                                height: double.infinity,
                                width: double.infinity,
                                child: Image.asset(
                                  ASSETS_PLACEHOLDER,
                                  fit: BoxFit.fill,
                                )),
                          ])
                        : Stack(
                            children: <Widget>[
                              provider.listImage.isEmpty
                                  ? SizedBox(
                                      height: double.infinity,
                                      width: double.infinity,
                                      child: Image.asset(
                                        ASSETS_PLACEHOLDER,
                                        fit: BoxFit.fill,
                                      ))
                                  : SizedBox(
                                      height: double.infinity,
                                      width: double.infinity,
                                      child: DynamicCachedNetworkImage(
                                          imageUrl: provider.getIndex())),
                              provider.listImage.length < 2
                                  ? SizedBox()
                                  : Positioned(
                                      bottom: 0,
                                      right: 0,
                                      child: SingleChildScrollView(
                                        child: Container(
                                          height: 150.0,
                                          color: Colors.transparent,
                                          width: 90,
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            itemCount:
                                                provider.listImage.length,
                                            itemBuilder: (context, index) {
                                              var boxDecoration = BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  border: Border.all(
                                                      width: 2.0,
                                                      color: secondaryColor));
                                              return Padding(
                                                padding:
                                                    provider.listImage.length -
                                                                1 ==
                                                            index
                                                        ? EdgeInsets.only(
                                                            top: 10.0,
                                                            bottom: 10.0,
                                                            right: 10.0)
                                                        : EdgeInsets.only(
                                                            top: 10.0,
                                                            right: 10.0),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    provider.setIndexImage =
                                                        index;
                                                  },
                                                  child: Container(
                                                    decoration:
                                                        provider.indexImage ==
                                                                index
                                                            ? boxDecoration
                                                            : null,
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image.network(
                                                          provider
                                                              .listImage[index]
                                                              .url,
                                                          fit: BoxFit.fill,
                                                          height: 65,
                                                        )),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                            ],
                          )),
                leading: Padding(
                  padding: const EdgeInsets.only(
                      left: SIZE_MEDIUM, top: SIZE_SMALL, bottom: SIZE_SMALL),
                  child: ActionButton(
                    iconData: Icons.arrow_back_ios_rounded,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right: SIZE_MEDIUM,
                        top: SIZE_SMALL,
                        bottom: SIZE_SMALL),
                    child: ActionButton(
                      iconData: Icons.shopping_cart,
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ));
  }
}

class ActionButton extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final VoidCallback? onPressed;
  const ActionButton(
      {Key? key,
      required this.iconData,
      this.onPressed,
      this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      type: MaterialType.circle,
      child: IconButton(
        splashRadius: 20.0,
        padding: const EdgeInsets.all(0.0),
        color: Colors.white,
        onPressed: onPressed,
        icon: Icon(
          iconData,
          color: primaryColor,
        ),
      ),
    );
  }
}
