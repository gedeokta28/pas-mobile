import 'package:flutter/material.dart';

class FormProvider with ChangeNotifier {
  // initial
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _emailError = false;
  bool _passwordError = false;

  // setter
  set setPasswordError(val) {
    _passwordError = val;
    notifyListeners();
  }

  set setEmailError(val) {
    _emailError = val;
    notifyListeners();
  }

  // getter
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  GlobalKey<FormState> get formKey => _formKey;

  bool get emailError => _emailError;
  bool get passwordError => _passwordError;

  // method
  refresh() => notifyListeners();
}
