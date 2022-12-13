import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final Function event;
  final Color color;
  final double radius;
  const RoundedButton({
    Key? key,
    required this.title,
    required this.event,
    this.color = primaryColor,
    this.radius = 5.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        primary: color,
        textStyle: TextStyle(
            fontSize: 17.0, color: Colors.white, fontWeight: FontWeight.bold),
        minimumSize: const Size.fromHeight(58.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      onPressed: () => event(),
      child: Text(
        title,
      ),
    );
  }
}
