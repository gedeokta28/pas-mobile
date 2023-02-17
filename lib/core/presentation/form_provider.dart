import 'package:flutter/material.dart';

class FormProvider with ChangeNotifier {
  // initial
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _priceMinController = TextEditingController();
  final TextEditingController _priceMaxController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordNewController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _emailError = false;
  bool _passwordError = false;
  bool _usernameError = false;

  // setter
  set setPasswordError(val) {
    _passwordError = val;
    notifyListeners();
  }

  set setEmailError(val) {
    _emailError = val;
    notifyListeners();
  }

  set setUsernameError(val) {
    _usernameError = val;
    notifyListeners();
  }

  // getter
  TextEditingController get emailController => _emailController;
  TextEditingController get priceMinController => _priceMinController;
  TextEditingController get priceMaxController => _priceMaxController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordNewController => _passwordNewController;
  TextEditingController get passwordConfirmationController =>
      _passwordConfirmationController;
  GlobalKey<FormState> get formKey => _formKey;

  bool get emailError => _emailError;
  bool get passwordError => _passwordError;
  bool get usernameError => _usernameError;

  // method
  refresh() => notifyListeners();
}
