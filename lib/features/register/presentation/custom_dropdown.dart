import 'package:flutter/material.dart';

import '../../../core/static/colors.dart';
import '../../../core/static/dimens.dart';

class CustomDropdownButtonWidget extends StatelessWidget {
  final List<DropdownMenuItem<String>> items;
  final void Function(dynamic) onChange;
  final String? value;
  final List<Widget> Function(BuildContext) selectedItemWidget;
  const CustomDropdownButtonWidget(
      {Key? key,
      required this.items,
      required this.onChange,
      required this.selectedItemWidget,
      this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Jenis Akun',
          style: TextStyle(
              fontSize: FONT_GENERAL,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4.0),
        Container(
          decoration: const BoxDecoration(
            color: SHADOW,
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.black,
              ),
              underline: const SizedBox(),
              hint: const Text(
                'Pilih Tipe Penjual',
                style: TextStyle(
                    fontSize: FONT_GENERAL,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              style: const TextStyle(
                fontSize: FONT_MEDIUM,
                color: Colors.black,
              ),
              items: items,
              onChanged: (value) {
                onChange(value);
              },
              selectedItemBuilder: (BuildContext context) {
                return selectedItemWidget(context);
              },
            ),
          ),
        ),
      ],
    );
  }
}
