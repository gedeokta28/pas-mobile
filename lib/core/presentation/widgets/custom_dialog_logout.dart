import 'package:flutter/material.dart';

import '../../utility/helper.dart';
import 'components/dialog_button.dart';
import 'components/dialog_container.dart';

class CustomLogoutDialog extends StatelessWidget {
  final Function positiveAction;
  const CustomLogoutDialog({Key? key, required this.positiveAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DialogContainer(
      withPadding: true,
      withMargin: true,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
            child: Text(
              "Anda ingin keluar dari akun ini ? ",
              style: const TextStyle(fontSize: 15.0),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          mediumVerticalSpacing(),
          ConfirmationButtons(
            positiveAction: positiveAction,
          ),
          smallVerticalSpacing()
        ],
      ),
    );
  }
}

class ConfirmationButtons extends StatelessWidget {
  final Function positiveAction;
  const ConfirmationButtons({
    Key? key,
    required this.positiveAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DialogButton.setPositiveButton(
                  action: () => positiveAction(), color: Colors.red)
              .button,
        ),
        Expanded(
          child: DialogButton.setNegativeButton(
                  action: () => Navigator.pop(context),
                  color: Colors.black,
                  text: "No")
              .button,
        ),
      ],
    );
  }
}
