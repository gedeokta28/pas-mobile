import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';

class CategorySelectionTitle extends StatelessWidget {
  final String title;
  final bool titleRight;
  final void Function() onTap;
  const CategorySelectionTitle({
    Key? key,
    required this.title,
    required this.onTap,
    this.titleRight = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 15.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          titleRight
              ? Expanded(
                  flex: 3,
                  child: InkWell(
                    onTap: onTap,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Lihat semua",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 5),
                          padding: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor,
                          ),
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SizedBox()
        ],
      ),
    );
  }
}
