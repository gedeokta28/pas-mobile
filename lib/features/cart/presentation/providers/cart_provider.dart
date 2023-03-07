import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pas_mobile/features/cart/data/models/cart_list_model.dart';
import 'package:pas_mobile/features/cart/domain/usecases/do_add_to_cart.dart';
import 'package:pas_mobile/features/cart/domain/usecases/get_cart.dart';
import 'package:pas_mobile/features/cart/presentation/providers/add_cart_state.dart';
import 'package:pas_mobile/features/cart/presentation/providers/cart_item_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utility/helper.dart';
import '../../../../core/utility/injection.dart';
import '../../../../core/utility/session_helper.dart';
import '../../data/cart_model.dart';

class CartProvider with ChangeNotifier {
  //initial
  final DoAddToCart doAddToCart;
  final GetCart getCart;
  List<ItemCart> _cartList = [];
  bool _isLoadCart = true;
  int _totalCartItem = 0;

  //get
  List<ItemCart> get cartList => _cartList;
  bool get isLoadCart => _isLoadCart;
  int get totalCartItem => _totalCartItem;

  //setter
  set setCartList(val) {
    _cartList = val;
    notifyListeners();
  }

  //test
  int _counter = 0;
  int _quantity = 1;
  int get counter => _counter;
  int get quantity => _quantity;
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;
  List<Cart> cart = [];

  // constructor
  CartProvider({
    required this.doAddToCart,
    required this.getCart,
  });

  Stream<AddToCartState> addProductToCart(FormData formData) async* {
    yield AddToCartLoading();

    final updateResult = await doAddToCart.execute(formData);
    yield* updateResult.fold((failure) async* {
      logMe("failure.message ${failure.message}");
      yield AddToCartFailure(failure: failure);
    }, (result) async* {
      yield AddToCartSuccess(data: result);
    });
  }

  Stream<CartItemState> fetchCart() async* {
    yield CartItemLoading();

    final updateResult = await getCart.call();
    yield* updateResult.fold((failure) async* {
      logMe("failure.message ${failure.message}");
      yield CartItemFailure(failure: failure);
    }, (result) async* {
      // _cartList = result;
      // for (var element in _cartList) {
      //   double d = double.parse(element.stock.hrg1);
      //   _totalPrice = _totalPrice + d;
      //   SharedPreferences prefs = await SharedPreferences.getInstance();
      //   prefs.setInt('cart_items', _counter);
      //   prefs.setInt('item_quantity', _quantity);
      //   prefs.setDouble('total_price', _totalPrice);
      //   _counter++;
      // }

      // logMe('manta');
      // logMe(_totalPrice);
      yield CartItemSuccess(data: result);
    });
  }

  Stream<CartItemState> countCartItem() async* {
    logMe("Counttttt");
    yield CartItemLoading();

    final updateResult = await getCart.call();
    yield* updateResult.fold((failure) async* {
      logMe("failure.message ${failure.message}");
      yield CartItemFailure(failure: failure);
    }, (result) async* {
      yield CartItemSuccess(data: result);
    });
  }

  void countTotalCartItem() async {
    countCartItem().listen((event) {
      if (event is CartItemSuccess) {
        _isLoadCart = false;
        _totalCartItem = event.data.length;
        logMe(_totalCartItem);
        logMe('_totalCartItem');
        notifyListeners();
      }
    });
  }

  Future<List<Cart>> getData() async {
    return cart;
  }

  void createItem() async {
    fetchCart().listen((event) {
      if (event is CartItemSuccess) {
        for (var i = 0; i < event.data.length; i++) {
          var arr = event.data[i].stock.hrg1.split('.');
          cart.add(
            Cart(
                id: event.data[i].id,
                productId: event.data[i].stock.stockid,
                productName: event.data[i].stock.stockname,
                initialPrice: int.tryParse(arr[0]),
                productPrice: int.tryParse(arr[0]),
                quantity: ValueNotifier(event.data[i].qty),
                unitTag: "unitTag",
                image: event.data[i].stock.photourl ?? ''),
          );
          addTotalPrice(double.parse(event.data[i].stock.hrg1));
          addCounter();
        }
        _isLoadCart = false;
        notifyListeners();
      }
    });
    // cart.add(
    //   Cart(
    //       id: 1,
    //       productId: "121",
    //       productName: "Water Tank Leak Detector Wp3310 Wipro",
    //       initialPrice: 4000,
    //       productPrice: 4000,
    //       quantity: ValueNotifier(1),
    //       unitTag: "unitTag",
    //       image:
    //           "https://mediabalitech.com/mediabalitech.com/admin-pas/public/app/product/images/I3rTDrCLNkpCBRzpQjfPIJ3XTzP7AhXHhZsXuY3i.jpg"),
    // );
    // addTotalPrice(4000);
    // addCounter();
    // cart.add(
    //   Cart(
    //       id: 2,
    //       productId: "123",
    //       productName:
    //           "Water Tank Leak Detector Wp3310 WiproDetector Wp3310 WiproDetector Wp3310 Wipro",
    //       initialPrice: 2000,
    //       productPrice: 2000,
    //       quantity: ValueNotifier(1),
    //       unitTag: "unitTag",
    //       image:
    //           "https://mediabalitech.com/mediabalitech.com/admin-pas/public/app/product/images/I3rTDrCLNkpCBRzpQjfPIJ3XTzP7AhXHhZsXuY3i.jpg"),
    // );
    // addTotalPrice(2000);
    // addCounter();
  }

  void _setPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('cart_items', _counter);
    prefs.setInt('item_quantity', _quantity);
    prefs.setDouble('total_price', _totalPrice);
    notifyListeners();
  }

  void _getPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_items') ?? 0;
    _quantity = prefs.getInt('item_quantity') ?? 1;
    _totalPrice = prefs.getDouble('total_price') ?? 0;
  }

  void addCounter() {
    _counter++;
    _setPrefsItems();
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    _setPrefsItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefsItems();
    return _counter;
  }

  void addQuantity(String id) {
    final index = cart.indexWhere((element) => element.id == id);
    cart[index].quantity!.value = cart[index].quantity!.value + 1;
    _setPrefsItems();
    notifyListeners();
  }

  void deleteQuantity(String id) {
    final index = cart.indexWhere((element) => element.id == id);
    final currentQuantity = cart[index].quantity!.value;
    if (currentQuantity <= 1) {
      currentQuantity == 1;
    } else {
      cart[index].quantity!.value = currentQuantity - 1;
    }
    _setPrefsItems();
    notifyListeners();
  }

  void removeItem(String id) {
    final index = cart.indexWhere((element) => element.id == id);
    cart.removeAt(index);
    _setPrefsItems();
    notifyListeners();
  }

  int getQuantity(int quantity) {
    _getPrefsItems();
    return _quantity;
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPrefsItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    _setPrefsItems();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefsItems();
    return _totalPrice;
  }
}
