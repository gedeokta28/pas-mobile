import 'package:flutter/material.dart';

class DialogButton {
  late Widget _button;

  // constructs
  DialogButton();
  DialogButton.setNegativeButton({
    String? text,
    Color? color,
    required Function action,
  }) {
    _button = NegativeButton(
      action: action,
      text: text,
      color: color,
    );
  }
  DialogButton.setPositiveButton({
    String? text,
    Color? color,
    required Function action,
  }) {
    _button = PositiveButton(
      action: action,
      text: text,
      color: color,
    );
  }
  DialogButton.setOkayButton({required Function action}) {
    _button = OkayButton(action: action);
  }

  // getter
  Widget get button => _button;
  Widget get closeButton => const CloseButton();
}

extension DialogButtonStyles on ButtonStyle {
  ButtonStyle roundedButtonStyle(Color color) => ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), backgroundColor: color,
        textStyle: const TextStyle(
            fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      );
  ButtonStyle textButtonStyle(Color color) => TextButton.styleFrom(
        foregroundColor: color, textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      );
}

class NegativeButton extends StatelessWidget {
  final Function action;
  final String? text;
  final Color? color;
  const NegativeButton({Key? key, required this.action, this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => action(),
      child: Text(text ?? "No"),
      style: const ButtonStyle().textButtonStyle(color ?? Colors.blue),
    );
    // return rounded filled button
  }
}

class PositiveButton extends StatelessWidget {
  final Function action;
  final String? text;
  final Color? color;
  const PositiveButton({Key? key, required this.action, this.text, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => action(),
      child: Text(text ?? "Yes"),
      style: const ButtonStyle().textButtonStyle(color ?? Colors.red),
    );
  }
}

class OkayButton extends StatelessWidget {
  final Function action;
  const OkayButton({Key? key, required this.action}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => action(),
      child: const Text(
        'OK',
      ),
      style: const ButtonStyle().textButtonStyle(Colors.black),
    );
  }
}
