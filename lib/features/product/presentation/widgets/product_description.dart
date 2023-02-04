import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/features/product/presentation/providers/product_provider.dart';
import 'package:pas_mobile/features/product/presentation/widgets/related_product.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/static/app_config.dart';
import '../../../../core/static/assets.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/injection.dart';
import '../../../login/presentation/login_page.dart';
import 'dialog_price.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, provider, _) {
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
                    provider.productDetail.stockname,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Rp',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        convertPrice(provider.productDetail.hrg1),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (sessionHelper.isLoggedIn == false) {
                        Navigator.pushNamed(context, LoginPage.routeName);
                      } else {
                        await DialogPrice.displayDialogOKCallBack(
                            context, "Harga Grosir", provider.productDetail);
                      }
                    },
                    child: Container(
                      height: 25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border:
                              Border.all(width: 1.0, color: secondaryColor)),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Lihat Harga Grosir",
                              style: TextStyle(
                                  fontSize: 12,
                                  color: secondaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
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
            ReadMoreText(provider.productDetail.stockdescription,
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
                Text(
                  'Brand',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                CachedNetworkImage(
                  height: App(context).appHeight(4),
                  width: App(context).appWidth(8),
                  imageUrl: provider.productDetail.brand.brandimage ??
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
            Row(
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
                  convertWeight(provider.productDetail.berat),
                  style: TextStyle(fontSize: 14.0, color: Colors.black),
                ),
              ],
            ),
            smallVerticalSpacing(),
            const Divider(),
            smallVerticalSpacing(),
            provider.productRelated.isEmpty
                ? const SizedBox()
                : const Text(
                    'Related Produk',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
            RelatedProductList(),
            SizedBox(height: 100),
          ],
        ),
      );
    });
  }
}
