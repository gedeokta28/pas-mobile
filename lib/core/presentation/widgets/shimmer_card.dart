import 'package:flutter/material.dart';

import '../../static/app_config.dart' as config;

class ShimmerCardWidget extends StatelessWidget {
  final bool isFullWidth;
  final bool isSquare;
  const ShimmerCardWidget({
    Key? key,
    this.isFullWidth = false,
    this.isSquare = false,
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
          child: SizedBox(
            height: config.App(context).appHeight(25),
            width: double.infinity,
          ),
        ),
      ];
    }

    return Container(
      width: isFullWidth ? double.infinity : config.App(context).appWidth(60),
      height: isSquare ? config.App(context).appHeight(35) : null,
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
            blurRadius: 15,
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
        ],
      ),
    );
  }
}
