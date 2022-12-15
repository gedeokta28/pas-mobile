import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/static/app_config.dart';
import '../../../../core/static/assets.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0.0),
      child: ListTile(
        dense: true,
        contentPadding: const EdgeInsets.all(0.0),
        leading: CachedNetworkImage(
          height: App(context).appHeight(6),
          width: App(context).appWidth(6),
          imageUrl:
              'https://www.klopmart.com/uploads/article/5-cara-memilih-gerinda-yang-baik_MjAyMTAzMjYwODU4NDAx.jpg',
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
          child: const Text(
            "Nama kategory",
            style: TextStyle(
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
