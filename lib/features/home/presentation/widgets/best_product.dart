import 'package:flutter/material.dart';

import 'card_widget.dart';
import 'category_selection_title.dart';

class BestProductList extends StatelessWidget {
  const BestProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategorySelectionTitle(
          onTap: () {},
          title: 'Product Terbaik',
        ),
        SizedBox(
          height: 210.0,
          child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) {
                return const CardWidget();
              }),
        ),
      ],
    );
  }
}
