import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/app_config.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/widgets/network_image.dart';
import '../providers/home_provider.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({Key? key}) : super(key: key);

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  @override
  Widget build(BuildContext context) {
    final CarouselController _controller = CarouselController();
    final List<Widget> imageSliders = listBanner
        .map((item) => Container(
              margin: const EdgeInsets.all(2.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Image.network(item, fit: BoxFit.cover, width: 1000.0)),
            ))
        .toList();

    return Consumer<HomeProvider>(builder: (context, provider, _) {
      return Column(children: [
        const SizedBox(
          height: 10.0,
        ),
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              aspectRatio: 2.5,
              onPageChanged: (index, reason) {
                provider.setCurrent = index;
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: listBanner.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 8.0,
                height: 8.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black)
                        .withOpacity(
                            provider.current == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ]);
    });

    // return Column(
    //   children: [
    //     Padding(
    //       padding: const EdgeInsets.symmetric(vertical: 8.0),
    //       child: SizedBox(
    //         height: App(context).appHeight(22),
    //         child: Swiper(
    //             loop: true,
    //             autoplay: true,
    //             autoplayDelay: 5000,
    //             duration: 1000,
    //             itemBuilder: (BuildContext context, int index) {
    //               return GestureDetector(
    //                 onTap: () {},
    //                 child: ClipRRect(
    //                   borderRadius: BorderRadius.circular(10),
    //                   child: DynamicCachedNetworkImage(
    //                     imageUrl: index == 0
    //                         ? 'https://mediabalitech.com/mediabalitech.com/admin-pas/public/assets/images/banner_1.jpg'
    //                         : index == 1
    //                             ? 'https://mediabalitech.com/mediabalitech.com/admin-pas/public/assets/images/banner_2.jpg'
    //                             : 'https://mediabalitech.com/mediabalitech.com/admin-pas/public/assets/images/banner_3.jpg',
    //                     boxFit: BoxFit.cover,
    //                   ),
    //                 ),
    //               );
    //             },
    //             itemCount: 3,
    //             viewportFraction: 0.9,
    //             scale: 0.7,
    //             pagination: const SwiperPagination(
    //               alignment: Alignment.bottomCenter,
    //               builder: DotSwiperPaginationBuilder(
    //                 color: Colors.grey,
    //                 activeColor: Colors.white,
    //               ),
    //             )),
    //       ),
    //     ),
    //   ],
    // );
  }
}
