import 'package:dartz/dartz.dart';
import 'package:pas_mobile/core/presentation/form_provider.dart';
import 'package:pas_mobile/core/utility/injection.dart';
import 'package:pas_mobile/core/utility/session_helper.dart';
import 'package:pas_mobile/features/notification/data/models/activity_notif_response_model.dart';
import 'package:pas_mobile/features/notification/data/models/order_notif_response_model.dart';
import 'package:pas_mobile/features/notification/domain/usecases/get_activity_notif.dart';
import 'package:pas_mobile/features/notification/domain/usecases/get_order_notif.dart';
import 'package:pas_mobile/features/notification/presentation/activity_notif_state.dart';
import 'package:pas_mobile/features/notification/presentation/order_notif_state.dart';

import '../../../core/error/failures.dart';

class NotificationProvider extends FormProvider {
  NotificationProvider({
    required this.getActivityNotification,
    required this.getOrderNotification,
  });
  // initial
  final GetActivityNotification getActivityNotification;
  final GetOrderNotification getOrderNotification;
  late List<ActivityNotif> _activityNotifList = [];
  late List<OrderNotif> _orderNotifList = [];
  ActivityNotifState _stateActivity = ActivityNotifInitial();
  OrderNotifState _stateOrder = OrderNotifInitial();
  int _countNotif = 0;
  int _countNotifOrder = 0;

  //get
  List<ActivityNotif> get activityNotifList => _activityNotifList;
  List<OrderNotif> get orderNotifList => _orderNotifList;
  ActivityNotifState get state => _stateActivity;
  OrderNotifState get stateOrder => _stateOrder;
  int get countNotif => _countNotif;
  int get countNotifOrder => _countNotifOrder;

  set setCountNotif(int val) {
    _countNotif = _countNotif + val;
    notifyListeners();
  }

  set setCountNotifOrder(int val) {
    _countNotifOrder = _countNotifOrder + val;
    notifyListeners();
  }

  set setActivityNotif(val) {
    _activityNotifList = val;
    notifyListeners();
  }

  set setOrderNotif(val) {
    _orderNotifList = val;
    notifyListeners();
  }

  set setStateActivity(val) {
    _stateActivity = val;
    notifyListeners();
  }

  set setStateOrder(val) {
    _stateOrder = val;
    notifyListeners();
  }

  Future<void> fetchActivityNotif() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setStateActivity = ActivityNotifLoading();

    late Either<Failure, List<ActivityNotif>> result;

    result = await getActivityNotification();
    result.fold(
      (failure) => setStateActivity = ActivityNotifFailure(failure: failure),
      (data) {
        setActivityNotif = data;
        if (data.isEmpty) {
          setStateActivity = ActivityNotifEmpty();
        } else {
          setCountNotif = data.length;
          setStateActivity = const ActivityNotifSuccess();
        }
      },
    );
  }

  Future<void> fetchOrderNotif() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setStateOrder = OrderNotifLoading();

    late Either<Failure, List<OrderNotif>> result;

    result = await getOrderNotification();
    result.fold(
      (failure) => setStateOrder = OrderNotifFailure(failure: failure),
      (data) {
        setOrderNotif = data;
        if (data.isEmpty) {
          setStateOrder = OrderNotifEmpty();
        } else {
          setCountNotifOrder = data.length;
          setStateOrder = const OrderNotifSuccess();
        }
      },
    );
  }

  void countTotalCartItem() async {
    final session = locator<Session>();
    if (session.isLoggedIn) {
      await fetchActivityNotif();
      await fetchOrderNotif();
    }
  }

  void calculateNotif() async {
    _countNotifOrder = 0;
    _countNotif = 0;
    notifyListeners();
  }
}
