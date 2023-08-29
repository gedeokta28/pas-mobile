// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

import '../static/strings.dart';

abstract class Session {
  set setLoggedIn(bool login);
  set setIndexTab(int index);
  set setToken(String token);
  set setCountNotif(int countNotif);
  set setCountNotifOrder(int countNotifOrder);

  bool get isLoggedIn;
  int get indexTab;
  int get countNotif;
  int get countNotifOrder;
  String get sessionToken;

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
  set setToken(String token) {
    pref.setString(SESSION_TOKEN, token);
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
  String get sessionToken => pref.getString(SESSION_TOKEN) ?? '';

  @override
  int get indexTab => pref.getInt(INDEX_TAB) ?? 0;

  @override
  int get countNotif => pref.getInt(COUNT_NOTIF) ?? 0;

  @override
  int get countNotifOrder => pref.getInt(COUNT_NOTIF_ORDER) ?? 0;

  @override
  Future<void> clearSession() async {
    await pref.clear();
  }
}
