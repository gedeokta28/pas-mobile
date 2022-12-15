import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/features/category/presentation/widgets/category_item.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/pages/main_page/main_page.dart';
import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/static/dimens.dart';
import '../../../core/utility/helper.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({
    Key? key,
  }) : super(key: key);
  static const routeName = '/category';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Kategori",
        centerTitle: true,
        canBack: true,
        hideShadow: false,
      ),
      body: Padding(
          padding: const EdgeInsets.only(
              left: 8.0, top: 0.0, right: 5.0, bottom: 5.0),
          child: SingleChildScrollView(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(SIZE_MEDIUM),
              itemCount: 20,
              itemBuilder: ((context, index) {
                return const CategoryItem();
              }),
            ),
          ]))),
    );
  }
}
