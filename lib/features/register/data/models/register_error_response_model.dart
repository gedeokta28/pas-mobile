import 'package:equatable/equatable.dart';

import '../../../../core/utility/helper.dart';

class RegisterErrorResponseModel extends Equatable {
  final String errorMessage;

  const RegisterErrorResponseModel({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

  factory RegisterErrorResponseModel.fromJson(Map<String, dynamic> json) {
    late String _errorMessage;

    try {
      String emailHasTaken = 'Email Telah Digunakan';
      String usernameHasTaken = 'Username Telah Digunakan';
      String emalAndUsernameHasTaken = 'Email dan Username Telah Digunakan';
      if (json['errors']['email'] != null &&
          json['errors']['username'] != null) {
        _errorMessage = emalAndUsernameHasTaken;
      } else if (json['errors']['email'] != null &&
          json['errors']['username'] == null) {
        _errorMessage = emailHasTaken;
      } else if (json['errors']['username'] != null &&
          json['errors']['email'] == null) {
        _errorMessage = usernameHasTaken;
      }
    } catch (e) {
      logMe(e);
      _errorMessage = '';
    }
    return RegisterErrorResponseModel(
      errorMessage: _errorMessage,
    );
  }
}
