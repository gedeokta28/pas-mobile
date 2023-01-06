import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/features/home/data/models/category_list_response_model.dart';

import '../../../../core/presentation/widgets/network_image.dart';
import '../../../../core/static/app_config.dart';
import 'dart:math' as math;

class CardSelectionWidget extends StatelessWidget {
  final Category category;
  final Color colorBox;
  const CardSelectionWidget(
      {Key? key, required this.category, required this.colorBox})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: App(context).appWidth(40),
        margin: const EdgeInsets.only(left: 8, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: colorBox,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  category.categoryname,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
              child: SizedBox(
                height: App(context).appHeight(4),
                width: App(context).appHeight(4),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                    child: category.photo != null
                        ? DynamicCachedNetworkImage(
                            imageUrl: category.photo,
                            boxFit: BoxFit.cover,
                          )
                        : Image.asset(ASSETS_PLACEHOLDER)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
