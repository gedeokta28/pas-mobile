import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final Color? iconTint;
  const CustomBackButton({
    Key? key,
    this.iconTint = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: iconTint,
      ),
    );
  }
}