import 'package:equatable/equatable.dart';

import '../../../../core/utility/helper.dart';

class ForgotPasswordErrorResponseModel extends Equatable {
  final String errorMessage;

  const ForgotPasswordErrorResponseModel({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

  factory ForgotPasswordErrorResponseModel.fromJson(Map<String, dynamic> json) {
    late String _errorMessage;

    try {
      String emailHasTaken = 'Akun Anda Tidak Ditemukan';
      if (json['errors']['email'] != null) {
        _errorMessage = emailHasTaken;
      } else {
        _errorMessage = "Error";
      }
    } catch (e) {
      logMe(e);
      _errorMessage = '';
    }
    return ForgotPasswordErrorResponseModel(
      errorMessage: _errorMessage,
    );
  }
}
