import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/features/search/data/models/filter_product_model.dart';

import '../../../../core/static/app_config.dart';
import '../../../../core/utility/helper.dart';

class CustomCardFilter extends StatelessWidget {
  final ProductFilter product;

  const CustomCardFilter({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: (size.height) / 8,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  image: product.images.isEmpty && product.photourl == null
                      ? const DecorationImage(
                          image: AssetImage(ASSETS_PLACEHOLDER),
                          fit: BoxFit.cover)
                      : product.photourl != null
                          ? DecorationImage(
                              image: NetworkImage(
                                product.photourl,
                              ),
                              fit: BoxFit.cover)
                          : product.images.isNotEmpty &&
                                  product.photourl == null
                              ? DecorationImage(
                                  image: NetworkImage(
                                    product.images[0].url,
                                  ),
                                  fit: BoxFit.cover)
                              : const DecorationImage(
                                  image: AssetImage(ASSETS_PLACEHOLDER),
                                  fit: BoxFit.cover)),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
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
