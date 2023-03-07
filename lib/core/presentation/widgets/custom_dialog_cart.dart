import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';

class CustomDialogCart extends StatelessWidget {
  final String text;
  const CustomDialogCart({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      title: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Icon(
          Icons.check_circle,
          size: 30,
          color: primaryColor,
        ),
      ],
    );
  }
}
