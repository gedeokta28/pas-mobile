import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/product/presentation/product_detail_page.dart';
import 'package:provider/provider.dart';

import '../../../../core/static/app_config.dart';
import '../../../../core/static/assets.dart';
import '../../../cart/presentation/providers/cart_provider.dart';
import '../../data/models/product_list_response_model.dart';

class CardWidget extends StatelessWidget {
  final Product product;

  const CardWidget({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> _homeWidget() {
      return [
        ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: product.images.isEmpty && product.photourl == null
                ? Image.asset(
                    ASSETS_PLACEHOLDER,
                    height: App(context).appHeight(15),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                : product.photourl != null
                    ? Image.network(
                        product.photourl,
                        fit: BoxFit.cover,
                        height: App(context).appHeight(15),
                        width: double.infinity,
                      )
                    : product.images.isNotEmpty && product.photourl == null
                        ? Image.network(product.images[0].url,
                            fit: BoxFit.cover,
                            height: App(context).appHeight(15),
                            width: double.infinity)
                        : Image.asset(
                            ASSETS_PLACEHOLDER,
                            height: App(context).appHeight(15),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ))
      ];
    }

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetailPage.routeName,
                arguments: ProductDetailArguments(
                    productId: product.stockid,
                    categoryId: product.category.categoryid))
            .then((_) {
          final provider = Provider.of<CartProvider>(
            context,
            listen: false,
          );
          provider.countTotalCartItem();
        });
      },
      child: Container(
        width: App(context).appWidth(45),
        margin: const EdgeInsets.only(
            left: 12,
            right: 5,
            top: 15,
            bottom: 10), // bottom:20 == error police line
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              fit: StackFit.loose,
              alignment: AlignmentDirectional.bottomStart,
              children: _homeWidget(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          product.brand.brandname,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        SizedBox(
                          height: App(context).appHeight(4),
                          child: Text(
                            product.stockname,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'Rp',
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                convertPrice(product.hrg1),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
