import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'enum.dart';
import 'helper.dart';

class ValidationHelper {
  final AppLocalizations loc;
  final Function(bool value) isError;
  final TypeField typeField;
  final String?
      pwd; // this value for matching between 'confirmation password' with 'password'

  ValidationHelper({
    required this.loc,
    this.pwd = '',
    required this.isError,
    required this.typeField,
  });

  FormFieldValidator validate() {
    String? message;
    return (value) {
      final strValue = value as String;
      if (strValue.isEmpty) {
        switch (typeField) {
          case TypeField.phone:
            message = "No. Telepon tidak boleh kosong";
            break;
          case TypeField.password:
            message = "Password tidak boleh kosong";
            break;
          case TypeField.email:
            message = "Email tidak boleh kosong";
            break;
          default:
            message = "Data ini tidak boleh kosong";
            break;
        }

        isError(true);
      } else {
        switch (typeField) {
          case TypeField.email:
            Pattern pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp emailRegex = RegExp(pattern.toString());
            if (!emailRegex.hasMatch(strValue)) {
              message = "Format email tidak valid";
              isError(true);
            } else {
              isError(false);
            }
            break;
          // case TypeField.password:
          //   if (strValue.length < 8) {
          //     message = appLoc.validationPasswordShort;
          //     isError(true);
          //   } else {
          //     isError(false);
          //   }
          //   break;

          default:
            isError(false);
        }
      }
      return message;
    };
  }
}
