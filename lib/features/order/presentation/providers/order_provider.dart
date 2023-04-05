import 'package:pas_mobile/features/order/data/models/order_parameter.dart';
import 'package:pas_mobile/features/order/domain/usecase/create_order.dart';
import 'package:pas_mobile/features/order/domain/usecase/detail_order.dart';
import 'package:pas_mobile/features/order/domain/usecase/list_order.dart';
import 'package:pas_mobile/features/order/presentation/providers/create_order_state.dart';
import 'package:pas_mobile/features/order/presentation/providers/detail_order_state.dart';
import 'package:pas_mobile/features/order/presentation/providers/list_oder_state.dart';

import '../../../../core/presentation/form_provider.dart';
import '../../../../core/utility/enum.dart';
import '../../../../core/utility/helper.dart';
import '../../../account/data/models/get_address_model.dart';
import '../../../account/domain/usecases/get_address_list.dart';
import '../../../account/presentation/providers/get_address_list_state.dart';
import '../../../cart/domain/usecases/get_cart.dart';
import '../../../cart/presentation/providers/cart_item_state.dart';

class OrderProvider extends FormProvider {
  final GetAddressList getAddressList;
  final DoCreateOrder doCreateOrder;
  final GetDetailOrder getDetailOrder;
  final GetListOrder getListOrder;
  final GetCart getCart;

  // constructor
  OrderProvider({
    required this.getAddressList,
    required this.getCart,
    required this.doCreateOrder,
    required this.getDetailOrder,
    required this.getListOrder,
  });

  PaymentMethod? _paymentMethod;
  ShippingAddress? _shippingAddressSelected;
  OrderParameter? _orderParameter;
  List<String>? _cartIds;
  String _notes = '';

  PaymentMethod? get paymentMethod => _paymentMethod;
  ShippingAddress? get shippingAddressSelected => _shippingAddressSelected;
  OrderParameter? get orderParameter => _orderParameter;
  List<String>? get cartIds => _cartIds;
  String? get notes => _notes;

  set setPaymentMethod(val) {
    _paymentMethod = val;
    notifyListeners();
  }

  set setShippingAddress(val) {
    _shippingAddressSelected = val;
    notifyListeners();
  }

  set setCartIds(val) {
    _cartIds = val;
    logMe(_cartIds!.length);
    logMe('_cartIds!.length');
    notifyListeners();
  }

  set setNotes(val) {
    _notes = val;
    notifyListeners();
  }

  Stream<GetAddressListState> fetchAddressList() async* {
    yield GetAddressListLoading();

    final updateResult = await getAddressList();
    yield* updateResult.fold((failure) async* {
      logMe("failure.message ${failure.message}");
      yield GetAddressListFailure(failure: failure);
    }, (result) async* {
      yield GetAddressListSuccess(data: result);
    });
  }

  Stream<CartItemState> fetchCart() async* {
    yield CartItemLoading();

    final updateResult = await getCart.call();
    yield* updateResult.fold((failure) async* {
      logMe("failure.message ${failure.message}");
      yield CartItemFailure(failure: failure);
    }, (result) async* {
      yield CartItemSuccess(data: result);
    });
  }

  setOrderParameter(
      {required List<String> cartIdParam,
      required PaymentMethod paymentMethodParam,
      required String notesParam,
      required String addressIdParam}) {
    _orderParameter = OrderParameter(
        paymentMethod: paymentMethodParam,
        addressId: addressIdParam,
        notes: notesParam,
        cartIds: cartIdParam);
    notifyListeners();
    logMe(_orderParameter!.toMap());
  }

  Stream<CreateOrderState> checkoutOrder(
      {required List<String> cartIdParam,
      required PaymentMethod paymentMethodParam,
      required String notesParam,
      required String addressIdParam}) async* {
    yield CreateOrderLoading();
    OrderParameter _oderParam;
    _oderParam = OrderParameter(
        paymentMethod: paymentMethodParam,
        addressId: addressIdParam,
        notes: notesParam,
        cartIds: cartIdParam);
    final resultOder = await doCreateOrder.execute(_oderParam.toMap());
    yield* resultOder.fold((failure) async* {
      logMe("failure.message ${failure.message}");
      yield CreateOrderFailure(failure: failure);
    }, (result) async* {
      logMe('suksessssss $result');
      yield CreateOrderSuccess(orderId: result);
    });
  }

  Stream<DetailOrderState> fetchDetailOrder({required String orderId}) async* {
    yield DetailOrderLoading();

    final resultOder = await getDetailOrder.execute(orderId);
    yield* resultOder.fold((failure) async* {
      logMe("failure.message ${failure.message}");
      yield DetailOrderFailure(failure: failure);
    }, (result) async* {
      logMe('suksessssss $result');
      yield DetailOrderSuccess(detailOrder: result);
    });
  }

  Stream<ListOrderState> fetchListOrder() async* {
    yield ListOrderLoading();

    final resultOder = await getListOrder.execute();
    yield* resultOder.fold((failure) async* {
      logMe("failure.message ${failure.message}");
      yield ListOrderFailure(failure: failure);
    }, (result) async* {
      logMe('suksessssss $result');
      yield ListOrderSuccess(listOrder: result);
    });
  }
}
