import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../static/dimens.dart';

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
