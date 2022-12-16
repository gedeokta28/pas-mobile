import 'package:flutter/material.dart';
import 'package:pas_mobile/features/home/data/models/product_list_response_model.dart';

import '../../../../core/static/dimens.dart';
import '../../../../core/utility/helper.dart';

class ProductDescription extends StatelessWidget {
  final Product product;
  const ProductDescription({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: SIZE_MEDIUM),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  product.stockname,
                  style: const TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.normal),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                const Text(
                  'Rp',
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  convertPrice(product.hrg1),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          Divider(),
          smallVerticalSpacing(),
          Text(
            'Detail Produk',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          smallVerticalSpacing(),
          Row(
            children: [
              Flexible(
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.',
                  style: TextStyle(fontSize: 13.0, color: Colors.black),
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
