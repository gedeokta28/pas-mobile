import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pas_mobile/features/home/data/models/category_list_response_model.dart';

import '../../../../core/static/app_config.dart';
import '../../../../core/static/assets.dart';

class FilterItem extends StatelessWidget {
  final Category category;

  const FilterItem({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.all(0.0),
        leading: category.photo == null
            ? Image.asset(ASSETS_PLACEHOLDER)
            : CachedNetworkImage(
                height: App(context).appHeight(4),
                width: App(context).appWidth(8),
                imageUrl: category.photo,
                placeholder: (context, url) => Image.asset(
                  LOADING_GIF,
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  ASSETS_PLACEHOLDER,
                  fit: BoxFit.cover,
                ),
                imageBuilder: (context, imageProvider) => Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
        title: Transform.translate(
          offset: const Offset(-16, 0),
          child: Text(
            category.categoryname,
            style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: Colors.black),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ), // change with model, later
      ),
    );
  }
}
