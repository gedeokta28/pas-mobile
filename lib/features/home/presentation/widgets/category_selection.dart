import 'package:flutter/material.dart';

import 'card_category_selection.dart';
import 'card_widget.dart';
import 'category_selection_title.dart';

class CategorySelectionList extends StatelessWidget {
  const CategorySelectionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CategorySelectionTitle(
          onTap: () {},
          title: 'Kategori Pilihan',
          titleRight: false,
        ),
        SizedBox(
          height: 90.0,
          child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 15,
              itemBuilder: (BuildContext context, int index) {
                return const CardSelectionWidget();
              }),
        ),
      ],
    );
  }
}
