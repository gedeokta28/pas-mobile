import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/features/home/presentation/providers/category_selection_state.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/static/app_config.dart';
import 'card_category_selection.dart';
import 'category_selection_title.dart';
import '../providers/home_provider.dart';
import 'package:provider/provider.dart';

class CategorySelectionList extends StatelessWidget {
  const CategorySelectionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTitleWidget(
          onTap: () {},
          title: 'Kategori Pilihan',
          titleRight: false,
        ),
        StreamBuilder<CategorySelectionState>(
            stream: context.read<HomeProvider>().fetchCategoryList(),
            builder: (_, snap) {
              if (snap.hasData) {
                if (snap.data is CategorySelectionLoaded) {
                  final _category = (snap.data as CategorySelectionLoaded).data;
                  return SizedBox(
                    height: App(context).appHeight(12),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 7.0),
                      child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount:
                              _category.length > 11 ? 10 : _category.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CardSelectionWidget(
                              category: _category[index],
                              colorBox: colorContainer[index],
                            );
                          }),
                    ),
                  );
                } else if (snap.data is CategorySelectionLoading) {
                  return SizedBox(
                      height: App(context).appHeight(12),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 10.0),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              direction: ShimmerDirection.ltr,
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  width: App(context).appWidth(35),
                                  color: Colors.grey.shade300,
                                  margin: const EdgeInsets.only(bottom: 10),
                                ),
                              ),
                            );
                          },
                        ),
                      ));
                }
              }
              return SizedBox(
                  height: App(context).appHeight(12),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0, top: 10.0),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          direction: ShimmerDirection.ltr,
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              width: App(context).appWidth(35),
                              color: Colors.grey.shade300,
                              margin: const EdgeInsets.only(bottom: 10),
                            ),
                          ),
                        );
                      },
                    ),
                  ));
            }),
      ],
    );
  }
}
