// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

abstract class Session {}

class SessionHelper implements Session {
  final SharedPreferences pref;

  SessionHelper({required this.pref});
}
