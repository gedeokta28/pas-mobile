import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/network_image.dart';
import '../../../../core/static/app_config.dart';

class CardSelectionWidget extends StatelessWidget {
  const CardSelectionWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: App(context).appWidth(40),
        margin: const EdgeInsets.only(
            left: 12,
            right: 12,
            top: 15,
            bottom: 10), // bottom:20 == error police line
        decoration: BoxDecoration(
          color: Colors.white,
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
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Nama KategoriNama Kategori",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 50,
                child: DynamicCachedNetworkImage(
                  imageUrl:
                      'https://cdn.pixabay.com/photo/2013/07/12/19/30/power-drill-154903__480.png',
                  boxFit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
