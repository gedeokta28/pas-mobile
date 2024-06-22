import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/features/product/presentation/providers/product_provider.dart';
import 'package:pas_mobile/features/product/presentation/widgets/read_more_data.dart';
import 'package:pas_mobile/features/product/presentation/widgets/related_product.dart';
import 'package:provider/provider.dart';

import '../../../../core/static/app_config.dart';
import '../../../../core/static/assets.dart';
import '../../../../core/static/dimens.dart';
import '../../../../core/utility/helper.dart';
import '../../../../core/utility/injection.dart';
import '../../../login/presentation/login_page.dart';
import 'dialog_price.dart';

class ProductDescription extends StatefulWidget {
  const ProductDescription({Key? key}) : super(key: key);

  @override
  State<ProductDescription> createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  bool showMore = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(builder: (context, provider, _) {
      String htmlData = provider.productDescription;
      final numLines = '\n'.allMatches(provider.productDescription).length + 1;
      logMe('numLines $numLines');
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
                    provider.productName,
                    style: const TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.normal),
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
                        convertPrice(provider.productPrice),
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 22.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  (provider.productDetail.qty1 == '0' ||
                              provider.productDetail.disclist1 == '0.00') &&
                          (provider.productDetail.qty2 == '0' ||
                              provider.productDetail.disclist2 == '0.00') &&
                          (provider.productDetail.qty3 == '0' ||
                              provider.productDetail.disclist3 == '0.00')
                      ? const SizedBox()
                      : GestureDetector(
                          onTap: () async {
                            if (sessionHelper.isLoggedIn == false) {
                              Navigator.pushNamed(context, LoginPage.routeName);
                            } else {
                              if (provider.isProductVariantSelected) {
                                await DialogPriceVariant
                                    .displayDialogOKCallBack(
                                        context,
                                        "Harga Grosir",
                                        provider.prodouctVariant);
                              } else {
                                await DialogPrice.displayDialogOKCallBack(
                                    context,
                                    "Harga Grosir",
                                    provider.productDetail);
                              }
                            }
                          },
                          child: Container(
                            height: 25,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    width: 1.0, color: secondaryColor)),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
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
            // smallVerticalSpacing(),
            // if (!provider.isLoadingVariant)
            //   const Text(
            //     'Size',
            //     style: TextStyle(
            //         fontSize: 14.0,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.black),
            //   ),
            // smallVerticalSpacing(),
            // if (!provider.isLoadingVariant)
            //   Row(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     children: [
            //       !provider.expandVariant
            //           ? Expanded(
            //               child: GridView.builder(
            //                 padding: EdgeInsets.zero,
            //                 physics:
            //                     const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
            //                 shrinkWrap: true,
            //                 gridDelegate:
            //                     SliverGridDelegateWithFixedCrossAxisCount(
            //                   crossAxisCount: 2,
            //                   childAspectRatio:
            //                       MediaQuery.of(context).size.width /
            //                           (MediaQuery.of(context).size.height / 6),
            //                 ),
            //                 itemCount: provider.productVariantList.size!.length,
            //                 itemBuilder: (context, index) {
            //                   return InkWell(
            //                     onTap: () {
            //                       if (index == provider.variantSelected) {
            //                         provider.setVariantSelected = null;
            //                         provider.setProductSelected(
            //                             productDetail: provider.productDetail);
            //                       } else {
            //                         provider.setVariantSelected = index;
            //                         provider.setProductSelected(
            //                             productVariantSelected: provider
            //                                 .productVariantList.size![index]);
            //                       }
            //                     },
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           right: 5, bottom: 8.0),
            //                       child: RoundedContainer(
            //                         child: Row(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.spaceBetween,
            //                           children: [
            //                             Flexible(
            //                               child: Text(
            //                                 provider.productVariantList
            //                                     .size![index].stockname,
            //                                 style: TextStyle(
            //                                     fontSize: 11,
            //                                     color:
            //                                         provider.variantSelected ==
            //                                                 index
            //                                             ? Colors.white
            //                                             : Colors.black87,
            //                                     fontWeight: FontWeight.bold),
            //                                 maxLines: 1,
            //                                 overflow: TextOverflow.ellipsis,
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                         color: provider.variantSelected == index
            //                             ? secondaryColor
            //                             : SHADOW,
            //                       ),
            //                     ),
            //                   );
            //                 },
            //               ),
            //             )
            //           : Expanded(
            //               child: GridView.builder(
            //                 padding: EdgeInsets.zero,
            //                 physics:
            //                     const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
            //                 shrinkWrap: true,
            //                 gridDelegate:
            //                     SliverGridDelegateWithFixedCrossAxisCount(
            //                   crossAxisCount: 2,
            //                   childAspectRatio:
            //                       MediaQuery.of(context).size.width /
            //                           (MediaQuery.of(context).size.height / 6),
            //                 ),
            //                 itemCount: provider.productVariantList.size!.length,
            //                 itemBuilder: (context, index) {
            //                   return InkWell(
            //                     onTap: () {
            //                       provider.setVariantSelected = index;
            //                     },
            //                     child: Padding(
            //                       padding: const EdgeInsets.only(
            //                           right: 5, bottom: 8.0),
            //                       child: RoundedContainer(
            //                         child: Row(
            //                           mainAxisAlignment:
            //                               MainAxisAlignment.spaceBetween,
            //                           children: [
            //                             Flexible(
            //                               child: Text(
            //                                 "Ukuran 1 Ukuran 1 Ukuran 1",
            //                                 style: TextStyle(
            //                                     fontSize: 11,
            //                                     color:
            //                                         provider.variantSelected ==
            //                                                 index
            //                                             ? Colors.white
            //                                             : Colors.black87,
            //                                     fontWeight: FontWeight.bold),
            //                                 maxLines: 1,
            //                                 overflow: TextOverflow.ellipsis,
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                         color: provider.variantSelected == index
            //                             ? secondaryColor
            //                             : SHADOW,
            //                       ),
            //                     ),
            //                   );
            //                 },
            //               ),
            //             ),
            //       provider.productVariantList.size!.length > 2
            //           ? IconButton(
            //               onPressed: () {
            //                 if (provider.expandVariant) {
            //                   provider.setExpandVariant = false;
            //                 } else {
            //                   provider.setExpandVariant = true;
            //                 }
            //               },
            //               icon: Icon(
            //                 provider.expandVariant
            //                     ? Icons.keyboard_arrow_up_rounded
            //                     : Icons.keyboard_arrow_down_rounded,
            //                 color: Colors.black87,
            //                 size: 27,
            //               ),
            //             )
            //           : Container()
            //     ],
            //   ),
            // smallVerticalSpacing(),
            // const Divider(),
            smallVerticalSpacing(),
            const Text(
              'Detail Produk',
              style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            smallVerticalSpacing(),
            ReadMoreHtml(
                htmlData: htmlData,
                maxLength: 1,
                readMoreText: 'read more',
                readLessText: 'show less'),
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
                const Text(
                  'Informasi Tambahan',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Text(
                  convertWeight(provider.productWeight),
                  style: const TextStyle(fontSize: 14.0, color: Colors.black),
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
            const RelatedProductList(),
            const SizedBox(height: 100),
          ],
        ),
      );
    });
  }
}
