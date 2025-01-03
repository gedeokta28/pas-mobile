// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

import '../static/strings.dart';

abstract class Session {
  set setLoggedIn(bool login);
  set setIndexTab(int index);
  set setToken(String token);
  set setCountNotif(int countNotif);
  set setCountNotifOrder(int countNotifOrder);
  set setCustomerId(String id);
  set setCustomerName(String name);
  set setAllCustomer(bool value);
  set setSalesId(String value);
  set setMinPrice(String value);
  set setMaxPrice(String value);

  bool get isLoggedIn;
  int get indexTab;
  int get countNotif;
  int get countNotifOrder;
  String get sessionToken;
  String get sessionCustomerId;
  String get sessionCustomerName;
  String get salesId;
  bool get isAllCustomer;
  String get sessionMinPrice;
  String get sessionMaxPrice;

  Future<void> clearSession();
}

class SessionHelper implements Session {
  final SharedPreferences pref;

  SessionHelper({required this.pref});

  @override
  set setLoggedIn(bool login) {
    pref.setBool(IS_LOGGED_IN, login);
  }

  @override
  set setAllCustomer(bool value) {
    pref.setBool(IS_ALL, value);
  }

  @override
  set setToken(String token) {
    pref.setString(SESSION_TOKEN, token);
  }

  @override
  set setMinPrice(String minprice) {
    pref.setString(MIN_PRICE, minprice);
  }

  @override
  set setMaxPrice(String maxprice) {
    pref.setString(MAX_PRICE, maxprice);
  }

  @override
  set setSalesId(String value) {
    pref.setString(SALES_ID, value);
  }

  @override
  set setCustomerId(String id) {
    pref.setString(CUSTOMER_ID, id);
  }

  @override
  set setCustomerName(String name) {
    pref.setString(CUSTOMER_NAME, name);
  }

  @override
  set setIndexTab(int index) {
    pref.setInt(INDEX_TAB, index);
  }

  @override
  set setCountNotif(int countNotif) {
    pref.setInt(COUNT_NOTIF, countNotif);
  }

  @override
  set setCountNotifOrder(int countNotifOrder) {
    pref.setInt(COUNT_NOTIF_ORDER, countNotifOrder);
  }

  @override
  bool get isLoggedIn => pref.getBool(IS_LOGGED_IN) ?? false;

  @override
  bool get isAllCustomer => pref.getBool(IS_ALL) ?? false;

  @override
  String get sessionToken => pref.getString(SESSION_TOKEN) ?? '';

  @override
  String get sessionMinPrice => pref.getString(MIN_PRICE) ?? '';

  @override
  String get sessionMaxPrice => pref.getString(MAX_PRICE) ?? '';

  @override
  int get indexTab => pref.getInt(INDEX_TAB) ?? 0;

  @override
  int get countNotif => pref.getInt(COUNT_NOTIF) ?? 0;

  @override
  int get countNotifOrder => pref.getInt(COUNT_NOTIF_ORDER) ?? 0;

  @override
  String get sessionCustomerId => pref.getString(CUSTOMER_ID) ?? '';

  @override
  String get sessionCustomerName => pref.getString(CUSTOMER_NAME) ?? '';

  @override
  String get salesId => pref.getString(SALES_ID) ?? '';

  @override
  Future<void> clearSession() async {
    await pref.clear();
  }
}
