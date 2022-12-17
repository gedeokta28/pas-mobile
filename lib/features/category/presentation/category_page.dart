import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/features/category/presentation/providers/category_provider.dart';
import 'package:pas_mobile/features/category/presentation/providers/category_state.dart';
import 'package:pas_mobile/features/category/presentation/widgets/category_item.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/pages/main_page/main_page.dart';
import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/static/dimens.dart';
import '../../../core/utility/helper.dart';
import '../../../core/utility/injection.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({
    Key? key,
  }) : super(key: key);
  static const routeName = '/category';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => locator<CategoryProvider>(),
      builder: (context, child) => Scaffold(
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
              StreamBuilder<CategoryState>(
                  stream: context.read<CategoryProvider>().fetchCategoryList(),
                  builder: (_, snap) {
                    if (snap.hasData) {
                      if (snap.data is CategoryLoaded) {
                        final _category = (snap.data as CategoryLoaded).data;
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: const EdgeInsets.all(SIZE_MEDIUM),
                          itemCount: _category.length,
                          itemBuilder: ((context, index) {
                            return CategoryItem(category: _category[index]);
                          }),
                        );
                      } else if (snap.data is CategoryLoading) {
                        return Center(
                          child: Image.asset(
                            ASSETS_LOADING,
                            height: 100.0,
                            width: 100.0,
                          ),
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  }),
            ]))),
      ),
    );
  }
}
