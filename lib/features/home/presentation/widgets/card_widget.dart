import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/network_image.dart';
import '../../../../core/static/app_config.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<Widget> _homeWidget() {
      return [
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: DynamicCachedNetworkImage(
            imageUrl:
                'https://auto.mahindra.com/-/media/Project/Mahindra/DotCom/Mahindra/LazyLoading/lazy-1_71.gif?extension=webp',
            height: App(context).appHeight(18),
            width: double.infinity,
            boxFit: BoxFit.cover,
          ),
        ),
      ];
    }

    return GestureDetector(
      onTap: () {},
      child: Container(
        width: App(context).appWidth(50),
        margin: const EdgeInsets.only(
            left: 12,
            right: 12,
            top: 15,
            bottom: 10), // bottom:20 == error police line
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              fit: StackFit.loose,
              alignment: AlignmentDirectional.bottomStart,
              children: _homeWidget(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 7),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Text(
                          "Nama Kategori",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 3.0,
                        ),
                        SizedBox(
                          height: App(context).appHeight(4),
                          child: const Text(
                            "GERINDA BOSCH GWS-060 4 ",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ),
                        const SizedBox(
                          height: 5.0,
                        ),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Rp. 8090222 ",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
