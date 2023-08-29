import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';

class RoundedButton extends StatelessWidget {
  final String title;
  final Function event;
  final Color color;
  final Color textColor;
  final double radius;
  final double sizeButton;
  final double textSize;
  const RoundedButton({
    Key? key,
    required this.title,
    required this.event,
    this.color = primaryColor,
    this.sizeButton = 50.0,
    this.textColor = Colors.white,
    this.textSize = 15.0,
    this.radius = 5.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0.0, backgroundColor: color,
        textStyle: const TextStyle(
            fontSize: 17.0, color: Colors.white, fontWeight: FontWeight.bold),
        minimumSize: Size.fromHeight(sizeButton),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
      onPressed: () => event(),
      child: Text(
        title,
        style: TextStyle(color: textColor, fontSize: textSize),
      ),
    );
  }
}
