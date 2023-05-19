class QuickCartParam {
  final String stockId;
  final int quantity;

  QuickCartParam({required this.stockId, required this.quantity});

  Map<String, dynamic> toJson() {
    return {
      'stockid': stockId,
      'qty': quantity,
    };
  }
}

class CartListParam {
  final List<QuickCartParam> carts;

  CartListParam({required this.carts});

  List<Map<String, dynamic>> toJson() {
    return carts.map((cart) => cart.toJson()).toList();
  }
}
