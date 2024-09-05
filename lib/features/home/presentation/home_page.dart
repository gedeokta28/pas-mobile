import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/cart/presentation/providers/cart_provider.dart';
import 'package:pas_mobile/features/home/presentation/widgets/banner_slider.dart';
import 'package:pas_mobile/features/home/presentation/widgets/best_product.dart';
import 'package:pas_mobile/features/home/presentation/widgets/category_selection.dart';
import 'package:pas_mobile/features/home/presentation/widgets/customer_selected.dart';
import 'package:pas_mobile/features/home/presentation/widgets/news_product.dart';
import 'package:provider/provider.dart';

import 'widgets/home_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: HomeAppBar(),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomerSelected(),
              const BannerSlider(),
              const CategorySelectionList(),
              const BestProductList(),
              smallVerticalSpacing(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SizedBox(
                  height: 140.0,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: listIklan.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Card(
                            child: Container(
                              height: 140,
                              width: 190,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(listIklan[index]),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(0),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              smallVerticalSpacing(),
              const NewsProductList(),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ));
  }
}
