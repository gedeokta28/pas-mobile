// To parse this JSON data, do
//
//     final createOrderResponseModel = createOrderResponseModelFromJson(jsonString);

import 'dart:convert';

CreateOrderResponseModel createOrderResponseModelFromJson(String str) =>
    CreateOrderResponseModel.fromJson(json.decode(str));

String createOrderResponseModelToJson(CreateOrderResponseModel data) =>
    json.encode(data.toJson());

class CreateOrderResponseModel {
  CreateOrderResponseModel({
    required this.data,
    required this.status,
    required this.message,
  });

  final Data data;
  final String status;
  final String message;

  factory CreateOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateOrderResponseModel(
        data: Data.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
      };
}

class Data {
  Data({
    required this.salesorderno,
    required this.notes,
    required this.salesorderdate,
    required this.customerid,
    required this.paymentype,
    required this.salespersonid,
    required this.salesordergrandtotal,
    required this.dpp,
    required this.ppn,
    required this.ppnpercent,
    required this.deliveryto,
    required this.deliveryaddress,
    required this.deliveryphone,
    required this.salesordertime,
    required this.status,
    required this.processdate,
    required this.processtime,
    required this.processorderno,
    required this.shippingFee,
    required this.products,
  });

  final String salesorderno;
  final dynamic notes;
  final DateTime salesorderdate;
  final String customerid;
  final dynamic paymentype;
  final dynamic salespersonid;
  final int salesordergrandtotal;
  final dynamic dpp;
  final dynamic ppn;
  final dynamic ppnpercent;
  final String deliveryto;
  final String deliveryaddress;
  final String deliveryphone;
  final DateTime salesordertime;
  final String status;
  final dynamic processdate;
  final dynamic processtime;
  final dynamic processorderno;
  final dynamic shippingFee;
  final List<Product> products;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        salesorderno: json["salesorderno"],
        notes: json["notes"],
        salesorderdate: DateTime.parse(json["salesorderdate"]),
        customerid: json["customerid"],
        paymentype: json["paymentype"],
        salespersonid: json["salespersonid"],
        salesordergrandtotal: json["salesordergrandtotal"],
        dpp: json["dpp"],
        ppn: json["ppn"],
        ppnpercent: json["ppnpercent"],
        deliveryto: json["deliveryto"],
        deliveryaddress: json["deliveryaddress"],
        deliveryphone: json["deliveryphone"],
        salesordertime: DateTime.parse(json["salesordertime"]),
        status: json["status"],
        processdate: json["processdate"],
        processtime: json["processtime"],
        processorderno: json["processorderno"],
        shippingFee: json["shipping_fee"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "salesorderno": salesorderno,
        "notes": notes,
        "salesorderdate": salesorderdate.toIso8601String(),
        "customerid": customerid,
        "paymentype": paymentype,
        "salespersonid": salespersonid,
        "salesordergrandtotal": salesordergrandtotal,
        "dpp": dpp,
        "ppn": ppn,
        "ppnpercent": ppnpercent,
        "deliveryto": deliveryto,
        "deliveryaddress": deliveryaddress,
        "deliveryphone": deliveryphone,
        "salesordertime": salesordertime.toIso8601String(),
        "status": status,
        "processdate": processdate,
        "processtime": processtime,
        "processorderno": processorderno,
        "shipping_fee": shippingFee,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    required this.id,
    required this.salesorderno,
    required this.stockid,
    required this.stockname,
    required this.stockthumb,
    required this.qtyorder,
    required this.price,
    required this.discountpercent,
    required this.discountamount,
    required this.netprice,
    required this.nettotal,
    required this.createdAt,
    required this.updatedAt,
    required this.deletedAt,
  });

  final String id;
  final String salesorderno;
  final String stockid;
  final String stockname;
  final dynamic stockthumb;
  final int qtyorder;
  final int price;
  final dynamic discountpercent;
  final dynamic discountamount;
  final int netprice;
  final int nettotal;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        salesorderno: json["salesorderno"],
        stockid: json["stockid"],
        stockname: json["stockname"],
        stockthumb: json["stockthumb"],
        qtyorder: json["qtyorder"],
        price: json["price"],
        discountpercent: json["discountpercent"],
        discountamount: json["discountamount"],
        netprice: json["netprice"],
        nettotal: json["nettotal"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "salesorderno": salesorderno,
        "stockid": stockid,
        "stockname": stockname,
        "stockthumb": stockthumb,
        "qtyorder": qtyorder,
        "price": price,
        "discountpercent": discountpercent,
        "discountamount": discountamount,
        "netprice": netprice,
        "nettotal": nettotal,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
