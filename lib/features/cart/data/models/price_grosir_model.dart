class PriceGrosirCart {
  late final int? minUnit;
  late final int? maxUnit;
  late final String? price;

  PriceGrosirCart({
    required this.minUnit,
    required this.maxUnit,
    required this.price,
  });

  PriceGrosirCart.fromMap(Map<dynamic, dynamic> data)
      : minUnit = data['minUnit'],
        maxUnit = data['maxUnit'],
        price = data['price'];

  Map<String, dynamic> toMap() {
    return {
      'minUnit': minUnit,
      'maxUnit': maxUnit,
      'price': price,
    };
  }
}
