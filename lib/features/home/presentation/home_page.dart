import 'package:flutter/material.dart';
import 'package:pas_mobile/features/home/presentation/widgets/banner_slider.dart';
import 'package:pas_mobile/features/home/presentation/widgets/category_selection.dart';
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
            children: const [
              SizedBox(
                height: 5.0,
              ),
              BannerSlider(),
              CategorySelectionList(),
              NewsProductList(),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ));
  }
}
