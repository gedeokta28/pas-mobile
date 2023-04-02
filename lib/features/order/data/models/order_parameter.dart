import 'package:pas_mobile/core/utility/enum.dart';
import 'package:pas_mobile/core/utility/extensions.dart';

class OrderParameter {
  PaymentMethod paymentMethod;
  String addressId;
  String notes;
  List<String> cartIds;

  OrderParameter({
    required this.paymentMethod,
    required this.addressId,
    required this.notes,
    required this.cartIds,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map["cart_ids"] = cartIds;
    map["payment_method"] = paymentMethod.getString();
    map["notes"] = notes;
    map["address_id"] = addressId;

    return map;
  }
}
