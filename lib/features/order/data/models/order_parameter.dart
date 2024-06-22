import 'package:pas_mobile/core/utility/enum.dart';
import 'package:pas_mobile/core/utility/extensions.dart';
import 'package:pas_mobile/core/utility/injection.dart';
import 'package:pas_mobile/core/utility/session_helper.dart';

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
    map["salespersonid"] = locator<Session>().salesId;
    map["customerid"] = locator<Session>().sessionCustomerId;
    map["address_id"] = addressId;

    return map;
  }
}
