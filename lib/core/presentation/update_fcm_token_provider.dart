import 'package:flutter/foundation.dart';
import 'package:pas_mobile/core/presentation/device_token_state.dart';
import 'package:pas_mobile/core/utility/firebase_helper.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/core/utility/session_helper.dart';
import 'package:pas_mobile/features/login/domain/usecases/update_fcm_token.dart';

class DeviceTokenProvider with ChangeNotifier {
  final UpdateFcmToken updateFcmToken;
  final Session session;
  DeviceTokenState _state = DeviceTokenInitial();

  DeviceTokenProvider({required this.updateFcmToken, required this.session});

  // setter
  set setState(val) {
    _state = val;
    notifyListeners();
  }

  // getter
  DeviceTokenState get state => _state;

  // method
  Future<void> doUpdate(String token) async {
    setState = DeviceTokenLoading();

    final result = await updateFcmToken(token);
    result.fold(
      (failure) => setState = DeviceTokenFailure(failure: failure),
      (_) => setState = DeviceTokenSuccess(),
    );
  }

  Future<void> checkDeviceToken() async {
    final firebaseHelper = FirebaseHelper();
    final token = await firebaseHelper.getToken();
    logMe(token);
    if (session.isLoggedIn && token != null) {
      logMe('call do update');
      await doUpdate(token);
    }
  }
}
