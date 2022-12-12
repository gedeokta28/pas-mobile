import 'package:flutter/material.dart';

import '../../static/dimens.dart';


class RoundedContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final double? height;
  final double radius;
  final bool shadow;
  final EdgeInsetsGeometry? padding;
  final Clip clipBehavior;
  const RoundedContainer({
    Key? key,
    required this.child,
    this.color = Colors.white,
    this.height,
    this.radius = SIZE_SMALL,
    this.shadow = false,
    this.padding = const EdgeInsets.all(SIZE_SMALL),
    this.clipBehavior = Clip.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding,
      clipBehavior: clipBehavior,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: [
          (shadow)
              ? BoxShadow(
                  color: Colors.grey.withOpacity(0.15),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                )
              : const BoxShadow()
        ],
      ),
      child: child,
    );
  }
}
