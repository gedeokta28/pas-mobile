import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pas_mobile/features/cart/data/models/cart_list_model.dart';
import 'package:pas_mobile/features/cart/domain/usecases/delete_cart.dart';
import 'package:pas_mobile/features/cart/domain/usecases/do_add_to_cart.dart';
import 'package:pas_mobile/features/cart/domain/usecases/get_cart.dart';
import 'package:pas_mobile/features/cart/domain/usecases/update_cart.dart';
import 'package:pas_mobile/features/cart/presentation/providers/add_cart_state.dart';
import 'package:pas_mobile/features/cart/presentation/providers/cart_item_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utility/helper.dart';
import '../../data/cart_model.dart';
import '../../data/models/cart_updated_model.dart';
import '../../data/models/price_grosir_model.dart';

class CartProvider with ChangeNotifier {
  //initial
  final DoAddToCart doAddToCart;
  final DoUpdateCart doUpdateCart;
  final DoDeleteCart doDeleteCart;
  final GetCart getCart;
  List<ItemCart> _cartList = [];
  final List<CartListUpdated> _cartItemUpdated = [];
  bool _isLoadCart = true;
  int _totalCartItem = 0;

  //get
  List<ItemCart> get cartList => _cartList;
  List<CartListUpdated> get cartItemUpdated => _cartItemUpdated;
  bool get isLoadCart => _isLoadCart;
  int get totalCartItem => _totalCartItem;

  //setter
  set setCartList(val) {
    _cartList = val;
    notifyListeners();
  }

  set setCartItemUpdated(CartListUpdated model) {
    var contain = _cartItemUpdated.where((element) => element.id == model.id);
    if (contain.isEmpty) {
      _cartItemUpdated.add(model);
    } else {
      int index = _cartItemUpdated.indexWhere((item) => item.id == model.id);
      _cartItemUpdated.removeAt(index);
      _cartItemUpdated.add(model);
    }
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
  CartProvider(
      {required this.doAddToCart,
      required this.getCart,
      required this.doUpdateCart,
      required this.doDeleteCart});

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

  Stream<AddToCartState> deleteProductCart(String itemId) async* {
    yield AddToCartLoading();

    final updateResult = await doDeleteCart.execute(itemId);
    yield* updateResult.fold((failure) async* {
      logMe("failure.message ${failure.message}");
      yield AddToCartFailure(failure: failure);
    }, (result) async* {
      yield AddToCartSuccess(data: result);
    });
  }

  Stream<AddToCartState> updateProductCart(
      {required String itemId, required String qty}) async* {
    yield AddToCartLoading();
    Map<String, String> body = {
      'qty': qty,
    };
    final updateResult = await doUpdateCart.call(body, itemId);
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
        logMe('_totalCartItem carttt');
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
          List<PriceGrosirCart> _priceGrosirCart = [];
          _priceGrosirCart.add(PriceGrosirCart(
            minUnit: convertMinUnitInt(
                hrg: 1,
                satuan1: event.data[i].stock.unit1,
                satuan2: event.data[i].stock.unit2,
                satuan3: event.data[i].stock.unit3,
                qty1: event.data[i].stock.qty1,
                qty2: event.data[i].stock.qty2,
                qty3: event.data[i].stock.qty3),
            maxUnit: convertMaxUnitInt(
                hrg: 1,
                satuan1: event.data[i].stock.unit1,
                satuan2: event.data[i].stock.unit2,
                satuan3: event.data[i].stock.unit3,
                qty1: event.data[i].stock.qty1,
                qty2: event.data[i].stock.qty2,
                qty3: event.data[i].stock.qty3),
            price: convertPrice(event.data[i].stock.hrg1),
          ));
          _priceGrosirCart.add(PriceGrosirCart(
            minUnit: convertMinUnitInt(
                hrg: 2,
                satuan1: event.data[i].stock.unit1,
                satuan2: event.data[i].stock.unit2,
                satuan3: event.data[i].stock.unit3,
                qty1: event.data[i].stock.qty1,
                qty2: event.data[i].stock.qty2,
                qty3: event.data[i].stock.qty3),
            maxUnit: convertMaxUnitInt(
                hrg: 2,
                satuan1: event.data[i].stock.unit1,
                satuan2: event.data[i].stock.unit2,
                satuan3: event.data[i].stock.unit3,
                qty1: event.data[i].stock.qty1,
                qty2: event.data[i].stock.qty2,
                qty3: event.data[i].stock.qty3),
            price: convertPrice(event.data[i].stock.hrg2),
          ));
          _priceGrosirCart.add(PriceGrosirCart(
            minUnit: convertMinUnitInt(
                hrg: 3,
                satuan1: event.data[i].stock.unit1,
                satuan2: event.data[i].stock.unit2,
                satuan3: event.data[i].stock.unit3,
                qty1: event.data[i].stock.qty1,
                qty2: event.data[i].stock.qty2,
                qty3: event.data[i].stock.qty3),
            maxUnit: convertMaxUnitInt(
                hrg: 3,
                satuan1: event.data[i].stock.unit1,
                satuan2: event.data[i].stock.unit2,
                satuan3: event.data[i].stock.unit3,
                qty1: event.data[i].stock.qty1,
                qty2: event.data[i].stock.qty2,
                qty3: event.data[i].stock.qty3),
            price: convertPrice(event.data[i].stock.hrg3),
          ));
          cart.add(
            Cart(
                id: event.data[i].id,
                productId: event.data[i].stock.stockid,
                productName: event.data[i].stock.stockname,
                initialPrice: int.tryParse(arr[0]),
                productPrice: ValueNotifier(int.parse(arr[0])),
                quantity: ValueNotifier(event.data[i].qty),
                unitTag: "unitTag",
                image: event.data[i].stock.images.isEmpty
                    ? ''
                    : event.data[i].stock.images[0]['url'],
                priceGrosirCart: _priceGrosirCart),
          );
          addTotalPrice(double.parse(event.data[i].stock.hrg1));
          addCounter();

          // logMe(_priceGrosirCart[0].toMap());
          // logMe(_priceGrosirCart[1].toMap());
          // logMe(_priceGrosirCart[2].toMap());
        }
        // logMe("asdasasda");

        // logMe(cart[0].priceGrosirCart![0].toMap());
        // logMe(cart[0].priceGrosirCart![1].toMap());
        // logMe(cart[0].priceGrosirCart![2].toMap());

        // logMe(cart[1].priceGrosirCart![0].toMap());
        // logMe(cart[1].priceGrosirCart![1].toMap());
        // logMe(cart[1].priceGrosirCart![2].toMap());
        _isLoadCart = false;
        notifyListeners();
      }
    });
  }

  // void _setPrefsItems() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt('cart_items', _counter);
  //   prefs.setInt('item_quantity', _quantity);
  //   prefs.setDouble('total_price', _totalPrice);
  //   notifyListeners();
  // }

  void _getPrefsItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _counter = prefs.getInt('cart_items') ?? 0;
    _quantity = prefs.getInt('item_quantity') ?? 1;
    _totalPrice = prefs.getDouble('total_price') ?? 0;
  }

  void addCounter() {
    _counter++;
    // _setPrefsItems();
    notifyListeners();
  }

  void removeCounter() {
    _counter--;
    // _setPrefsItems();
    notifyListeners();
  }

  int getCounter() {
    _getPrefsItems();
    return _counter;
  }

  void addQuantity(String id) {
    final index = cart.indexWhere((element) => element.id == id);
    cart[index].quantity!.value = cart[index].quantity!.value + 1;
    int maxUnit1 = cart[index].priceGrosirCart![0].maxUnit!;
    int minUnit1 = cart[index].priceGrosirCart![0].minUnit!;
    int maxUnit2 = cart[index].priceGrosirCart![1].maxUnit!;
    int minUnit2 = cart[index].priceGrosirCart![1].minUnit!;
    setCartItemUpdated =
        CartListUpdated(id: id, quantity: cart[index].quantity!.value);
    // _setPrefsItems();

    if (cart[index].quantity!.value >= minUnit1 &&
        cart[index].quantity!.value <= maxUnit1) {
      cart[index].productPrice!.value =
          int.parse(cart[index].priceGrosirCart![0].price!);
    } else if (cart[index].quantity!.value >= minUnit2 &&
        cart[index].quantity!.value <= maxUnit2) {
      cart[index].productPrice!.value =
          int.parse(cart[index].priceGrosirCart![1].price!);
    } else {
      cart[index].productPrice!.value =
          int.parse(cart[index].priceGrosirCart![2].price!);
    }

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
    setCartItemUpdated =
        CartListUpdated(id: id, quantity: cart[index].quantity!.value);
    // _setPrefsItems();
    int maxUnit1 = cart[index].priceGrosirCart![0].maxUnit!;
    int minUnit1 = cart[index].priceGrosirCart![0].minUnit!;
    int maxUnit2 = cart[index].priceGrosirCart![1].maxUnit!;
    int minUnit2 = cart[index].priceGrosirCart![1].minUnit!;

    if (cart[index].quantity!.value >= minUnit1 &&
        cart[index].quantity!.value <= maxUnit1) {
      cart[index].productPrice!.value =
          int.parse(cart[index].priceGrosirCart![0].price!);
    } else if (cart[index].quantity!.value >= minUnit2 &&
        cart[index].quantity!.value <= maxUnit2) {
      cart[index].productPrice!.value =
          int.parse(cart[index].priceGrosirCart![1].price!);
    } else {
      cart[index].productPrice!.value =
          int.parse(cart[index].priceGrosirCart![2].price!);
    }
    notifyListeners();
  }

  void removeItem(String id) {
    final index = cart.indexWhere((element) => element.id == id);
    var contain =
        _cartItemUpdated.where((element) => element.id == cart[index].id);
    if (contain.isNotEmpty) {
      int indexRemoved =
          _cartItemUpdated.indexWhere((item) => item.id == cart[index].id);
      _cartItemUpdated.removeAt(indexRemoved);
    }

    cart.removeAt(index);
    // _setPrefsItems();
    notifyListeners();
  }

  int getQuantity(int quantity) {
    _getPrefsItems();
    return _quantity;
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    // _setPrefsItems();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    // _setPrefsItems();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefsItems();
    return _totalPrice;
  }
}
