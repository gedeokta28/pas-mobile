import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pas_mobile/features/home/data/models/brand_list_response_model.dart';
import 'package:pas_mobile/features/home/data/models/category_list_response_model.dart';

import '../../../../core/static/app_config.dart';
import '../../../../core/static/assets.dart';

class BrandItem extends StatelessWidget {
  final BrandList brand;

  const BrandItem({Key? key, required this.brand}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        elevation: 5,
        child: Container(
          height: (size.height) / 5,
          decoration: BoxDecoration(
              image: brand.photo.isEmpty
                  ? DecorationImage(
                      image: AssetImage(ASSETS_PLACEHOLDER), fit: BoxFit.cover)
                  : DecorationImage(
                      image: NetworkImage(
                        brand.photo,
                      ),
                      fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
