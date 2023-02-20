import 'package:equatable/equatable.dart';

import '../../../../core/utility/helper.dart';

class UpdateProfileErrorResponseModel extends Equatable {
  final String errorMessage;

  const UpdateProfileErrorResponseModel({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];

  factory UpdateProfileErrorResponseModel.fromJson(Map<String, dynamic> json) {
    late String _errorMessage;

    try {
      final String? passwordMissMatch =
          json['errors']['phone'] == null ? json['errors']['phone'][0] : null;

      _errorMessage = passwordMissMatch ?? json['message'];
    } catch (e) {
      logMe(e);
      _errorMessage = '';
    }
    return UpdateProfileErrorResponseModel(
      errorMessage: _errorMessage,
    );
  }
}
