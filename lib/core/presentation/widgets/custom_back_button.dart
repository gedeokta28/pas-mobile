import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/injection.dart';
import 'package:pas_mobile/core/utility/session_helper.dart';

class CustomBackButton extends StatelessWidget {
  final Function? onTapBack;
  final Color? iconTint;
  const CustomBackButton({
    Key? key,
    this.onTapBack,
    this.iconTint = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (onTapBack != null) {
          onTapBack!();
        } else {
          final session = locator<Session>();
          session.setMinPrice = "";
          session.setMaxPrice = "";
          Navigator.pop(context);
        }
      },
      icon: Icon(
        Icons.arrow_back_ios_new,
        color: iconTint,
      ),
    );
  }
}
