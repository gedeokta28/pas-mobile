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
import '../../../../core/utility/injection.dart';
import '../../../../core/utility/session_helper.dart';
import '../../data/cart_model.dart';
import '../../data/models/cart_updated_model.dart';
import '../../data/models/price_grosir_model.dart';

class CartProvider with ChangeNotifier {
  //initial
  final session = locator<Session>();
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
    if (session.isLoggedIn) {
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
  }

  Future<List<Cart>> getData() async {
    return cart;
  }

  void createItem() async {
    fetchCart().listen((event) {
      if (event is CartItemSuccess) {
        for (var i = 0; i < event.data.length; i++) {
          double qty1Final = double.parse(event.data[i].stock.qty1);
          double qty2Final = double.parse(event.data[i].stock.qty2);
          double qty3Final = double.parse(event.data[i].stock.qty3);
          int minQty1Int = 0, maxQty1Int = 0;
          int minQty2Int = 0, maxQty2Int = 0;
          //1
          minQty1Int = qty1Final.toInt();
          maxQty1Int = (qty2Final.toInt() - 1);
          //2
          minQty2Int = qty2Final.toInt();
          maxQty2Int = (qty3Final.toInt() - 1);
          List<PriceGrosirCart> _priceGrosirCart = [];
          if (maxQty1Int < 0) {
            if (minQty2Int == 0) {
              _priceGrosirCart.add(PriceGrosirCart(
                minUnit: minQty1Int,
                maxUnit: maxQty2Int,
                price: convertPriceDisc(
                    event.data[i].stock.hrg1, event.data[i].stock.disclist1),
              ));
            } else {
              _priceGrosirCart.add(PriceGrosirCart(
                minUnit: minQty1Int,
                maxUnit: minQty1Int,
                price: convertPriceDisc(
                    event.data[i].stock.hrg1, event.data[i].stock.disclist1),
              ));
            }
          } else {
            if (maxQty1Int == minQty1Int) {
              _priceGrosirCart.add(PriceGrosirCart(
                minUnit: minQty1Int,
                maxUnit: minQty1Int,
                price: convertPriceDisc(
                    event.data[i].stock.hrg1, event.data[i].stock.disclist1),
              ));
            } else {
              _priceGrosirCart.add(PriceGrosirCart(
                minUnit: minQty1Int,
                maxUnit: maxQty1Int,
                price: convertPriceDisc(
                    event.data[i].stock.hrg1, event.data[i].stock.disclist1),
              ));
            }
          }

          if (event.data[i].stock.qty2 != '0') {
            if (maxQty2Int < 0) {
              _priceGrosirCart.add(PriceGrosirCart(
                minUnit: minQty2Int,
                maxUnit: 100000,
                price: convertPriceDisc(
                    event.data[i].stock.hrg1, event.data[i].stock.disclist2),
              ));
            } else {
              _priceGrosirCart.add(PriceGrosirCart(
                minUnit: minQty2Int,
                maxUnit: maxQty2Int,
                price: convertPriceDisc(
                    event.data[i].stock.hrg1, event.data[i].stock.disclist2),
              ));
            }
          }

          if (event.data[i].stock.qty3 != '0') {
            _priceGrosirCart.add(PriceGrosirCart(
              minUnit: qty3Final.toInt(),
              maxUnit: 100000,
              price: convertPriceDisc(
                  event.data[i].stock.hrg1, event.data[i].stock.disclist3),
            ));
          }

          // _priceGrosirCart.add(PriceGrosirCart(
          //   minUnit: toIntQty(event.data[i].stock.qty1),
          //   maxUnit: toIntQty(event.data[i].stock.qty2) - 1,
          //   price: convertPriceDisc(
          //       event.data[i].stock.hrg1, event.data[i].stock.disclist1),
          // ));
          // _priceGrosirCart.add(PriceGrosirCart(
          //   minUnit: toIntQty(event.data[i].stock.qty2),
          //   maxUnit: toIntQty(event.data[i].stock.qty3) - 1,
          //   price: convertPriceDisc(
          //       event.data[i].stock.hrg1, event.data[i].stock.disclist2),
          // ));
          // _priceGrosirCart.add(PriceGrosirCart(
          //   minUnit: toIntQty(event.data[i].stock.qty3),
          //   maxUnit: 0,
          //   price: convertPriceDisc(
          //       event.data[i].stock.hrg1, event.data[i].stock.disclist3),
          // ));
          // _priceGrosirCart.add(PriceGrosirCart(
          //   minUnit: toIntQty(event.data[i].stock.qty3),
          //   maxUnit: 0,
          //   price: convertPriceDisc(event.data[i].stock.hrg1, '0'),
          // ));
          logMe("_priceGrosirCart_priceGrosirCart ${_priceGrosirCart.length}");

          String initPrice = convertPriceDisc(
              event.data[i].stock.hrg1, event.data[i].stock.disclist1);
          for (int iGros = 0; iGros < _priceGrosirCart.length; iGros++) {
            if (event.data[i].qty >= _priceGrosirCart[iGros].minUnit! &&
                event.data[i].qty <= _priceGrosirCart[iGros].maxUnit!) {
              initPrice = _priceGrosirCart[iGros].price!;
              break;
            }
          }
          // if (event.data[i].qty >= toIntQty(event.data[i].stock.qty1) &&
          //     event.data[i].qty <= (toIntQty(event.data[i].stock.qty2) - 1)) {
          //   initPrice = convertPriceDisc(
          //       event.data[i].stock.hrg1, event.data[i].stock.disclist1);
          // } else if (event.data[i].qty >= toIntQty(event.data[i].stock.qty2) &&
          //     event.data[i].qty <= (toIntQty(event.data[i].stock.qty3) - 1)) {
          //   // logMe('elseeee 2');
          //   // logMe(event.data[i].stock.hrg1);
          //   // logMe(event.data[i].stock.disclist2);
          //   initPrice = convertPriceDisc(
          //       event.data[i].stock.hrg1, event.data[i].stock.disclist1);
          // } else if (event.data[i].qty >= toIntQty(event.data[i].stock.qty3)) {
          //   logMe('elseeee 3');
          //   initPrice = convertPriceDisc(
          //       event.data[i].stock.hrg1, event.data[i].stock.disclist3);
          // } else {
          //   initPrice = convertPriceDisc(event.data[i].stock.hrg1, '0');
          //   logMe('elseeee');
          // }

          cart.add(
            Cart(
                id: event.data[i].id,
                productId: event.data[i].stock.stockid,
                productName: event.data[i].stock.stockname,
                initialPrice: removeToPrice(initPrice),
                productPrice: ValueNotifier(removeToPrice(initPrice)),
                quantity: ValueNotifier(event.data[i].qty),
                unitTag: "unitTag",
                image: event.data[i].stock.photourl.isNotEmpty
                    ? event.data[i].stock.photourl
                    : event.data[i].stock.images.isEmpty
                        ? ''
                        : event.data[i].stock.images[0]['url'],
                priceGrosirCart: _priceGrosirCart),
          );
          addTotalPrice(double.parse(event.data[i].stock.hrg1));
          addCounter();
        }
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
    setCartItemUpdated =
        CartListUpdated(id: id, quantity: cart[index].quantity!.value);
    // int maxUnit1 = cart[index].priceGrosirCart![0].maxUnit!;
    // int minUnit1 = cart[index].priceGrosirCart![0].minUnit!;
    // int maxUnit2 = cart[index].priceGrosirCart![1].maxUnit!;
    // int minUnit2 = cart[index].priceGrosirCart![1].minUnit!;
    // int minUnit3 = cart[index].priceGrosirCart![2].minUnit!;
    // logMe(cart[index].priceGrosirCart![0].price);
    // logMe(cart[index].priceGrosirCart![1].price);
    // logMe(cart[index].priceGrosirCart![2].price);
    // logMe(cart[index].priceGrosirCart![3].price);

    // if (cart[index].quantity!.value >= minUnit1 &&
    //     cart[index].quantity!.value <= maxUnit1) {
    //   cart[index].productPrice!.value =
    //       removeToPrice(cart[index].priceGrosirCart![0].price!);
    // } else {}
    // else if (cart[index].quantity!.value >= minUnit2 &&
    //     cart[index].quantity!.value <= maxUnit2) {
    //   logMe('elseeee 2');
    //   logMe('elseeee 2 $maxUnit2');
    //   cart[index].productPrice!.value =
    //       removeToPrice(cart[index].priceGrosirCart![1].price!);
    // } else if (cart[index].quantity!.value >= minUnit3) {
    //   logMe('elseeee 3');
    //   cart[index].productPrice!.value =
    //       removeToPrice(cart[index].priceGrosirCart![2].price!);
    // } else {
    //   logMe('elseeee 4');
    //   cart[index].productPrice!.value =
    //       removeToPrice(cart[index].priceGrosirCart![3].price!);
    // }

    for (int i = 0; i < cart[index].priceGrosirCart!.length; i++) {
      if (cart[index].quantity!.value >=
              cart[index].priceGrosirCart![i].minUnit! &&
          cart[index].quantity!.value <=
              cart[index].priceGrosirCart![i].maxUnit!) {
        cart[index].productPrice!.value =
            removeToPrice(cart[index].priceGrosirCart![i].price!);
        logMe('1111 ${cart[index].priceGrosirCart![i].price!}');
        break;
      }
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
    // int maxUnit1 = cart[index].priceGrosirCart![0].maxUnit!;
    // int minUnit1 = cart[index].priceGrosirCart![0].minUnit!;
    // int maxUnit2 = cart[index].priceGrosirCart![1].maxUnit!;
    // int minUnit2 = cart[index].priceGrosirCart![1].minUnit!;
    // int minUnit3 = cart[index].priceGrosirCart![2].minUnit!;

    // if (cart[index].quantity!.value >= minUnit1 &&
    //     cart[index].quantity!.value <= maxUnit1) {
    //   cart[index].productPrice!.value =
    //       removeToPrice(cart[index].priceGrosirCart![0].price!);
    // } else if (cart[index].quantity!.value >= minUnit2 &&
    //     cart[index].quantity!.value <= maxUnit2) {
    //   cart[index].productPrice!.value =
    //       removeToPrice(cart[index].priceGrosirCart![1].price!);
    // } else if (cart[index].quantity!.value >= minUnit3) {
    //   cart[index].productPrice!.value =
    //       removeToPrice(cart[index].priceGrosirCart![2].price!);
    // } else {
    //   cart[index].productPrice!.value =
    //       removeToPrice(cart[index].priceGrosirCart![3].price!);
    // }
    for (int i = 0; i < cart[index].priceGrosirCart!.length; i++) {
      logMe(cart[index].priceGrosirCart![i].minUnit);
      logMe(cart[index].priceGrosirCart![i].maxUnit);
      logMe(cart[index].priceGrosirCart![i].price);
    }
    for (int i = 0; i < cart[index].priceGrosirCart!.length; i++) {
      if (cart[index].quantity!.value >=
              cart[index].priceGrosirCart![i].minUnit! &&
          cart[index].quantity!.value <=
              cart[index].priceGrosirCart![i].maxUnit!) {
        cart[index].productPrice!.value =
            removeToPrice(cart[index].priceGrosirCart![i].price!);
        logMe('1111 ${cart[index].priceGrosirCart![i].price!}');
        break;
      }
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
