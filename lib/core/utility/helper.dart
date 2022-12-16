import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/core/utility/session_helper.dart';

import '../error/failures.dart';
import '../static/dimens.dart';
import 'injection.dart';

logMe(Object? obj) {
  /* 
    use this for print something, its run only on debug mode.
  */
  if (kDebugMode) {
    print(obj);
  }
}

//Locale Language
late AppLocalizations appLoc;

//Route
final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

// spacing
Widget smallVerticalSpacing() => const SizedBox(height: SIZE_SMALL);
Widget smallHorizontalSpacing() => const SizedBox(width: SIZE_SMALL);
Widget mediumVerticalSpacing() => const SizedBox(height: SIZE_MEDIUM);
Widget mediumHorizontalSpacing() => const SizedBox(width: SIZE_MEDIUM);
Widget largeVerticalSpacing() => const SizedBox(height: SIZE_LARGE);
Widget largeHorizontalSpacing() => const SizedBox(width: SIZE_LARGE);
Widget superLargeVerticalSpacing() => const SizedBox(height: 40);

Future<void> sessionLogOut() async {
  final session = locator<Session>();
  await session.clearSession();
}

Options options({Map<String, dynamic>? headers}) => Options(
      headers: headers,
      validateStatus: (status) => (status ?? 0) == 200,
    );

showLoading() {
  SmartDialog.showLoading(
    backDismiss: false,
    builder: (context) => const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(secondaryColor)),
  );
}

dismissLoading() {
  SmartDialog.dismiss();
}

String getErrorMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ConnectionFailure:
      return "Tidak Ada Koneksi";
    case ServerFailure:
      if (failure.message.isNotEmpty) {
        return failure.message;
      }
      return "Server Error";
    default:
      return "Unexpected error";
  }
}

void showShortToast({required String message, Color? color}) {
  Fluttertoast.showToast(
      backgroundColor: color ?? primaryColor,
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      timeInSecForIosWeb: 1);
}
