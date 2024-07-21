import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/features/product/presentation/widgets/related_product.dart';
import 'package:pas_mobile/features/search/data/models/filter_product_model.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/static/app_config.dart';
import '../../../../core/static/assets.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/helper.dart';

class ProductFilterDescription extends StatelessWidget {
  final ProductFilter product;
  const ProductFilterDescription({Key? key, required this.product})
      : super(key: key);

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
                      fontSize: 16.0,
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
          const Divider(),
          smallVerticalSpacing(),
          const Text(
            'Detail Produk',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          smallVerticalSpacing(),
          const ReadMoreText(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam eu turpis molestie, dictum est a, mattis tellus. Sed dignissim, metus nec fringilla accumsan, risus sem sollicitudin lacus, ut interdum tellus elit sed risus. Maecenas eget condimentum velit, sit amet feugiat lectus. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos.',
              trimLines: 4,
              style:
                  TextStyle(fontSize: 13.0, color: Colors.black, height: 1.5),
              trimMode: TrimMode.Line,
              trimCollapsedText: 'Baca selengkapnya',
              trimExpandedText: ' Tampilkan lebih sedikit',
              lessStyle: TextStyle(
                  fontSize: 13.0,
                  color: secondaryColor,
                  fontWeight: FontWeight.bold),
              moreStyle: TextStyle(
                  fontSize: 13.0,
                  color: secondaryColor,
                  fontWeight: FontWeight.bold)),
          mediumVerticalSpacing(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Brand',
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              CachedNetworkImage(
                height: App(context).appHeight(4),
                width: App(context).appWidth(8),
                imageUrl:
                    'https://mediabalitech.com/mediabalitech.com/admin-pas/public/assets/images/logo-pas.png',
                placeholder: (context, url) => Image.asset(
                  LOADING_GIF,
                  fit: BoxFit.fill,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  ASSETS_PLACEHOLDER,
                  fit: BoxFit.fill,
                ),
                imageBuilder: (context, imageProvider) => Image(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
          smallVerticalSpacing(),
          const Divider(),
          smallVerticalSpacing(),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Informasi Tambahan',
                style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              Text(
                'Berat : 1kg',
                style: TextStyle(fontSize: 14.0, color: Colors.black),
              ),
            ],
          ),
          smallVerticalSpacing(),
          const Divider(),
          smallVerticalSpacing(),
          const Text(
            'Related Produk',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          SizedBox(
            height: 8.0,
          ),
          const RelatedProductList(),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
