import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/category/presentation/providers/category_state.dart';
import 'package:pas_mobile/features/filter/presentation/providers/filter_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/utility/injection.dart';
import '../../home/data/models/category_list_response_model.dart';

class FilterCategoryPage extends StatelessWidget {
  final List<Category> listSelected;
  const FilterCategoryPage({
    Key? key,
    required this.listSelected,
  }) : super(key: key);
  static const routeName = '/filter-category';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => locator<FilterProvider>()..setSelectedFilter(listSelected),
      builder: (context, child) => Scaffold(
          appBar: const CustomAppBar(
            title: "Filter",
            centerTitle: true,
            canBack: false,
            hideShadow: false,
          ),
          body: Padding(
              padding: const EdgeInsets.only(
                  left: 8.0, top: 0.0, right: 5.0, bottom: 100.0),
              child: SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                StreamBuilder<CategoryState>(
                    stream: context.read<FilterProvider>().fetchCategoryList(),
                    builder: (_, snap) {
                      if (snap.hasData) {
                        if (snap.data is CategoryLoaded) {
                          final _category = (snap.data as CategoryLoaded).data;

                          return Consumer<FilterProvider>(
                              builder: (context, filter, _) {
                            return ListView.separated(
                              padding: EdgeInsets.zero,
                              separatorBuilder: (context, index) => Divider(
                                color: Colors.grey[400],
                              ),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: _category.length,
                              itemBuilder: (_, int index) {
                                return Theme(
                                  data: ThemeData(
                                      unselectedWidgetColor: secondaryColor),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10.0),
                                    child: CheckboxListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title:
                                          Text(_category[index].categoryname),
                                      value: filter.isDataExist(
                                          _category[index].categoryid),
                                      onChanged: (_) {
                                        if (filter.isDataExist(
                                            _category[index].categoryid)) {
                                          filter
                                              .removeSelected(_category[index]);
                                        } else {
                                          filter.addSelected(_category[index]);
                                        }
                                      },
                                      checkColor: Colors.white,
                                      activeColor: secondaryColor,
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                    ),
                                  ),
                                );
                              },
                            );
                          });
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Material(
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0),
              child: Consumer<FilterProvider>(builder: (context, filter, _) {
                return RoundedButton(
                  title: "Terapkan",
                  color: secondaryColor,
                  event: () {
                    logMe(filter.selectedFilter);
                    filter.setListSelected = filter.selectedFilter;
                    Navigator.pop(context, filter.selectedFilter);
                  },
                );
              }),
            ),
          )),
    );
  }
}
