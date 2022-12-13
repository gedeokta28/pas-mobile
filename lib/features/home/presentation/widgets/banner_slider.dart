import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/app_config.dart';

import '../../../../core/presentation/widgets/network_image.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: SizedBox(
            height: App(context).appHeight(20),
            child: Swiper(
                loop: true,
                autoplay: true,
                autoplayDelay: 5000,
                duration: 1000,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: DynamicCachedNetworkImage(
                        imageUrl: index == 0
                            ? 'https://img.freepik.com/free-vector/modern-sale-banner-with-text-space-area_1017-27331.jpg?w=2000'
                            : index == 1
                                ? 'https://cdn5.vectorstock.com/i/1000x1000/52/04/online-shopping-e-commerce-banner-concept-vector-25035204.jpg'
                                : 'https://static.vecteezy.com/system/resources/previews/004/299/835/original/online-shopping-on-phone-buy-sell-business-digital-web-banner-application-money-advertising-payment-ecommerce-illustration-search-free-vector.jpg',
                        boxFit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                itemCount: 3,
                viewportFraction: 0.9,
                scale: 0.7,
                pagination: const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.grey,
                    activeColor: Colors.white,
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
