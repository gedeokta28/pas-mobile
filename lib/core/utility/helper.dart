import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/core/utility/firebase_helper.dart';
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
  await FirebaseHelper.unsubscribeFromTopic();
  final session = locator<Session>();
  await session.clearSession();
}

Options options({Map<String, dynamic>? headers}) => Options(
      headers: headers,
      validateStatus: (status) => (status ?? 0) == 200 || (status ?? 0) == 201,
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

String convertPrice(String price) {
  double d = double.parse(price);
  final currencyFormatter = NumberFormat('#,##0.0', 'ID');
  return currencyFormatter.format(d).toString();
}

String convertPriceDisc(String price, String disc) {
  double d = double.parse(price);
  double discParse = double.parse(disc);
  double percent = (discParse / 100) * d;
  double result = d - percent;
  final currencyFormatter = NumberFormat('#,##0.0', 'ID');
  return currencyFormatter.format(result).toString();
}

String convertWeight(String weight) {
  String weightTxt = weight.replaceAll('.00', '');
  double weightTotal = double.parse(weightTxt);
  // int weightTotal = int.parse(weightTxt);
  if (weightTotal > 999) {
    double result = weightTotal / 1000;
    String showWeight = 'Berat : ${result.toStringAsFixed(1)} kg';
    return showWeight;
  } else {
    String showWeight = 'Berat : $weightTotal g';
    return showWeight;
  }
}

double removeToPrice(String price) {
  logMe('priceeee $price');
  String weightTxt = price.replaceAll('.', '');
  String weightTxtResult = weightTxt.replaceAll(',', '.');
  logMe('priceeee $weightTxtResult');

  double result = double.parse(weightTxtResult);
  return result;
}

String convertStrUnit(
    {required int hrg,
    required String satuan1,
    required String satuan2,
    required String satuan3,
    required String qty1,
    required String qty2,
    required String qty3}) {
  String result;
  double qty1Final = double.parse(qty1);
  double qty2Final = double.parse(qty2);
  double qty3Final = double.parse(qty3);
  double minQty1 = 0;
  double minQty2 = 0;
  int minQty1Int = 0, maxQty1Int = 0;
  int minQty2Int = 0, maxQty2Int = 0;

  //1
  minQty1 = ((qty1Final - qty1Final) + 1);
  minQty1Int = minQty1.toInt();
  maxQty1Int = qty1Final.toInt();
  //2
  minQty2 = ((qty2Final - qty1Final) + 1);
  minQty2Int = minQty2.toInt();
  maxQty2Int = qty2Final.toInt();
  //3
  qty3Final = maxQty2Int + 1;

  if (hrg == 1) {
    result = "$minQty1Int - $maxQty1Int $satuan1";
  } else if (hrg == 2) {
    result = "$minQty2Int - $maxQty2Int $satuan2";
  } else {
    result = "${qty3Final.toInt()}+ $satuan3";
  }

  return result;
}

String convertStrUnitVariant(
    {required int hrg,
    required String satuan1,
    required String satuan2,
    required String satuan3,
    required String qty1,
    required String qty2,
    required String qty3}) {
  String result;
  double qty1Final = double.parse(qty1);
  double qty2Final = double.parse(qty2);
  double qty3Final = double.parse(qty3);
  double minQty1 = 0;
  double minQty2 = 0;
  int minQty1Int = 0, maxQty1Int = 0;
  int minQty2Int = 0, maxQty2Int = 0;

  //1
  minQty1 = ((qty1Final - qty1Final) + 1);
  minQty1Int = minQty1.toInt();
  maxQty1Int = qty1Final.toInt();
  //2
  minQty2 = ((qty2Final - qty1Final) + 1);
  minQty2Int = minQty2.toInt();
  maxQty2Int = qty2Final.toInt();
  //3
  qty3Final = maxQty2Int + 1;

  if (hrg == 1) {
    result = "$minQty1Int - $maxQty1Int $satuan1";
  } else if (hrg == 2) {
    result = "$minQty2Int - $maxQty2Int $satuan2";
  } else {
    result = "${qty3Final.toInt()}+ $satuan3";
  }

  return result;
}

int convertMinUnitInt(
    {required int hrg,
    required String satuan1,
    required String satuan2,
    required String satuan3,
    required String qty1,
    required String qty2,
    required String qty3}) {
  int result;
  double qty1Final = double.parse(qty1);
  double qty2Final = double.parse(qty2);
  double qty3Final = double.parse(qty3);
  double minQty1 = 0;
  double minQty2 = 0;
  int minQty1Int = 0, maxQty1Int = 0;
  int minQty2Int = 0, maxQty2Int = 0;

  //1
  minQty1 = ((qty1Final - qty1Final) + 1);
  minQty1Int = minQty1.toInt();
  maxQty1Int = qty1Final.toInt();
  //2
  minQty2 = ((qty2Final - qty1Final) + 1);
  minQty2Int = minQty2.toInt();
  maxQty2Int = qty2Final.toInt();
  //3
  qty3Final = maxQty2Int + 1;

  if (hrg == 1) {
    result = minQty1Int;
  } else if (hrg == 2) {
    result = minQty2Int;
  } else {
    result = qty3Final.toInt();
  }

  return result;
}

int toIntQty(String qty) {
  int result = double.parse(qty).toInt();
  return result;
}

int convertMaxUnitInt(
    {required int hrg,
    required String satuan1,
    required String satuan2,
    required String satuan3,
    required String qty1,
    required String qty2,
    required String qty3}) {
  int result;
  double qty1Final = double.parse(qty1);
  double qty2Final = double.parse(qty2);
  double qty3Final = double.parse(qty3);
  double minQty1 = 0;
  double minQty2 = 0;
  int minQty1Int = 0, maxQty1Int = 0;
  int minQty2Int = 0, maxQty2Int = 0;

  //1
  minQty1 = ((qty1Final - qty1Final) + 1);
  minQty1Int = minQty1.toInt();
  maxQty1Int = qty1Final.toInt();
  //2
  minQty2 = ((qty2Final - qty1Final) + 1);
  minQty2Int = minQty2.toInt();
  maxQty2Int = qty2Final.toInt();
  //3
  qty3Final = maxQty2Int + 1;

  if (hrg == 1) {
    result = maxQty1Int;
  } else if (hrg == 2) {
    result = maxQty2Int;
  } else {
    result = 0;
  }

  return result;
}

String mergeOrderText(String orderId, DateTime date) {
  var convertDate = DateFormat('d MMMM yyyy').format(date);
  String resultText = '#$orderId   $convertDate';
  return resultText;
}

String convertDate(DateTime date) {
  var convertDate = DateFormat('d MMMM yyyy').format(date);
  return convertDate;
}

String removeHtmlTage(String value) {
  // String data = value.replaceAll('"\\\"', '');
  // String data1 = data.replaceAll('""\""', '');
  // String data2 = data1.replaceAll('"\\"', '');

  return json.decode(value);
}

String getQuantity(
    {required int hrg,
    required String satuan1,
    required String satuan2,
    required String satuan3,
    required String qty1,
    required String qty2,
    required String qty3}) {
  String result;
  double qty1Final = double.parse(qty1);
  double qty2Final = double.parse(qty2);
  double qty3Final = double.parse(qty3);

  int minQty1Int = 0, maxQty1Int = 0;
  int minQty2Int = 0, maxQty2Int = 0;

  //1
  minQty1Int = qty1Final.toInt();
  maxQty1Int = (qty2Final.toInt() - 1);
  //2
  minQty2Int = qty2Final.toInt();
  maxQty2Int = (qty3Final.toInt() - 1);
  //3

  if (hrg == 1) {
    if (maxQty1Int < 0) {
      if (minQty2Int == 0) {
        if (maxQty2Int < 0) {
          result = "$minQty1Int $satuan1";
        } else {
          result = "$minQty1Int - $maxQty2Int $satuan1";
        }
      } else {
        result = "$minQty1Int  $satuan1";
      }
    } else {
      if (maxQty1Int == minQty1Int) {
        result = "$minQty1Int $satuan1";
      } else {
        result = "$minQty1Int - $maxQty1Int $satuan1";
      }
    }
  } else if (hrg == 2) {
    if (maxQty2Int < 0) {
      result = "$minQty2Int+  $satuan2";
    } else {
      result = "$minQty2Int - $maxQty2Int $satuan2";
    }
  } else {
    result = "${qty3Final.toInt()}+ $satuan3";
  }

  return result;
}
