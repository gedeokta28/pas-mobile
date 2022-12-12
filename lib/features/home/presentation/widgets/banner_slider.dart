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
                      child: const DynamicCachedNetworkImage(
                        imageUrl:
                            'https://auto.mahindra.com/-/media/Project/Mahindra/DotCom/Mahindra/LazyLoading/lazy-1_71.gif?extension=webp',
                        boxFit: BoxFit.fill,
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
