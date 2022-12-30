import 'package:flutter/material.dart';
import 'package:pas_mobile/core/presentation/widgets/rounded_container.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/category/presentation/providers/category_state.dart';
import 'package:pas_mobile/features/filter/presentation/filter_category_page.dart';
import 'package:pas_mobile/features/filter/presentation/providers/filter_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/custom_field_number.dart';
import '../../../core/presentation/widgets/custom_text_field.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/static/colors.dart';
import '../../../core/static/dimens.dart';
import '../../../core/utility/injection.dart';

class FilterPage extends StatelessWidget {
  const FilterPage({
    Key? key,
  }) : super(key: key);
  static const routeName = '/filter';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => locator<FilterProvider>(),
      builder: (context, child) => Scaffold(
        appBar: const CustomAppBar(
          title: "Filter",
          centerTitle: true,
          canBack: true,
          hideShadow: false,
        ),
        body: SafeArea(
          child: Consumer<FilterProvider>(builder: (context, provider, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Harga",
                        style: TextStyle(
                            fontSize: FONT_GENERAL,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          provider.clearFilter();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.refresh_sharp,
                              color: greyColor,
                              size: 20.0,
                            ),
                            SizedBox(width: 2.0),
                            Text(
                              "Reset",
                              style: TextStyle(
                                  fontSize: FONT_GENERAL,
                                  color: greyColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  smallVerticalSpacing(),
                  CustomPriceField(
                      placeholder: 'Minimum',
                      controller: provider.priceMinController,
                      fieldValidator: null),
                  CustomPriceField(
                      placeholder: 'Maximum',
                      controller: provider.priceMaxController,
                      fieldValidator: null),
                  mediumVerticalSpacing(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Kategori",
                        style: TextStyle(
                            fontSize: FONT_GENERAL,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          var result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    FilterCategoryPage(
                                        listSelected: provider.selectedFilter),
                              ));
                          provider.setListSelected = result;
                        },
                        child: Text(
                          "Lihat Semua",
                          style: TextStyle(
                              fontSize: FONT_GENERAL,
                              color: secondaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  mediumVerticalSpacing(),
                  provider.selectedFilter.isEmpty
                      ? const SizedBox.shrink()
                      : GridView.builder(
                          physics:
                              NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 4),
                          ),
                          itemCount: provider.selectedFilter.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(right: 5, bottom: 8.0),
                              child: RoundedContainer(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        provider.selectedFilter[index].name,
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        provider.removeSelected(
                                            provider.selectedFilter[index]);
                                      },
                                      child: Icon(
                                        Icons.close,
                                        size: 18.0,
                                        color: secondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                color: SHADOW,
                              ),
                            );
                          },
                        ),
                  mediumVerticalSpacing(),
                  RoundedButton(
                    title: "Terapkan",
                    color: secondaryColor,
                    event: () {
                      provider.checkPrice(provider.priceMaxController.text,
                          provider.priceMinController.text);
                    },
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
