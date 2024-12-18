import 'package:flutter/material.dart';

class FormProvider with ChangeNotifier {
  // initial
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _priceMinController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _priceMaxController = TextEditingController();
  final TextEditingController _regenciesController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordNewController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _ktpController = TextEditingController();
  final TextEditingController _contactPersonController =
      TextEditingController();
  final TextEditingController _npwpController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _streetNameController = TextEditingController();
  final TextEditingController _detailAddressController =
      TextEditingController();
  final TextEditingController _postCodeController = TextEditingController();
  final TextEditingController _searchAddressController =
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
  TextEditingController get nameController => _nameController;
  TextEditingController get priceMinController => _priceMinController;
  TextEditingController get noteController => _noteController;
  TextEditingController get regenciesController => _regenciesController;
  TextEditingController get priceMaxController => _priceMaxController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get usernameController => _usernameController;
  TextEditingController get passwordNewController => _passwordNewController;
  TextEditingController get passwordConfirmationController =>
      _passwordConfirmationController;
  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get phoneNumberController => _phoneNumberController;
  TextEditingController get contactPersonController => _contactPersonController;
  TextEditingController get ktpController => _ktpController;
  TextEditingController get npwpController => _npwpController;
  TextEditingController get companyNameController => _companyNameController;
  TextEditingController get streetNameController => _streetNameController;
  TextEditingController get detailAddressController => _detailAddressController;
  TextEditingController get postCodeController => _postCodeController;
  TextEditingController get searchAddressController => _searchAddressController;

  GlobalKey<FormState> get formKey => _formKey;

  bool get emailError => _emailError;
  bool get passwordError => _passwordError;
  bool get usernameError => _usernameError;

  // method
  refresh() => notifyListeners();
}
