import 'package:flutter/material.dart';
import 'package:pas_mobile/features/home/data/models/brand_list_response_model.dart';

import '../../../../core/static/assets.dart';

class BrandItem extends StatelessWidget {
  final BrandList brand;

  const BrandItem({Key? key, required this.brand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // return Padding(
    //   padding: const EdgeInsets.only(top: 10),
    //   child: Card(
    //     elevation: 2,
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(5.0),
    //     ),
    //     child: Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Container(
    //         decoration: BoxDecoration(
    //             borderRadius: const BorderRadius.all(Radius.circular(5)),
    //             image: brand.photo.isEmpty
    //                 ? const DecorationImage(
    //                     image: AssetImage(ASSETS_PLACEHOLDER),
    //                     fit: BoxFit.cover)
    //                 : DecorationImage(
    //                     image: NetworkImage(
    //                       brand.photo,
    //                     ),
    //                     fit: BoxFit.fill)),
    //       ),
    //     ),
    //   ),
    // );

    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    image: brand.photo.isEmpty
                        ? const DecorationImage(
                            image: AssetImage(ASSETS_PLACEHOLDER),
                            fit: BoxFit.fill)
                        : DecorationImage(
                            image: NetworkImage(
                              brand.photo,
                            ),
                            fit: BoxFit.fill)),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                brand.brandname,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
