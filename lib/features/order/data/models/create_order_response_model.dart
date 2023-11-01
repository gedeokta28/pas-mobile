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

  final DetailOrder data;
  final String status;
  final String message;

  factory CreateOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      CreateOrderResponseModel(
        data: DetailOrder.fromJson(json["data"]),
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "status": status,
        "message": message,
      };
}

class DetailOrder {
  DetailOrder({
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
  final dynamic salesordergrandtotal;
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
  final List<ProductOrder> products;

  factory DetailOrder.fromJson(Map<String, dynamic> json) => DetailOrder(
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
        products: List<ProductOrder>.from(
            json["products"].map((x) => ProductOrder.fromJson(x))),
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

class ProductOrder {
  ProductOrder({
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
    required this.stock,
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
  final dynamic netprice;
  final dynamic nettotal;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic deletedAt;
  final StockOrderDetail stock;

  factory ProductOrder.fromJson(Map<String, dynamic> json) => ProductOrder(
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
        stock: StockOrderDetail.fromJson(json["stock"]),
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
        "stock": stock.toJson(),
        "deleted_at": deletedAt,
      };
}

class StockOrderDetail {
  final String stockid;
  final String stockname;
  final String barcode;
  final String hrg1;
  final String disclist1;
  final String hrg2;
  final String disclist2;
  final String hrg3;
  final String disclist3;
  final String qty1;
  final String qty2;
  final String qty3;
  final String berat;
  final dynamic discountinued;
  final String photourl;
  final dynamic stockdescription;
  final List<dynamic> images;

  StockOrderDetail({
    required this.stockid,
    required this.stockname,
    required this.barcode,
    required this.hrg1,
    required this.disclist1,
    required this.hrg2,
    required this.disclist2,
    required this.hrg3,
    required this.disclist3,
    required this.qty1,
    required this.qty2,
    required this.qty3,
    required this.berat,
    required this.discountinued,
    required this.photourl,
    required this.stockdescription,
    required this.images,
  });

  factory StockOrderDetail.fromJson(Map<String, dynamic> json) =>
      StockOrderDetail(
        stockid: json["stockid"],
        stockname: json["stockname"],
        barcode: json["barcode"],
        hrg1: json["hrg1"],
        disclist1: json["disclist1"],
        hrg2: json["hrg2"],
        disclist2: json["disclist2"],
        hrg3: json["hrg3"],
        disclist3: json["disclist3"],
        qty1: json["qty1"],
        qty2: json["qty2"],
        qty3: json["qty3"],
        berat: json["berat"],
        discountinued: json["discountinued"],
        photourl: json["photourl"] ?? '',
        stockdescription: json["stockdescription"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "stockid": stockid,
        "stockname": stockname,
        "barcode": barcode,
        "hrg1": hrg1,
        "disclist1": disclist1,
        "hrg2": hrg2,
        "disclist2": disclist2,
        "hrg3": hrg3,
        "disclist3": disclist3,
        "qty1": qty1,
        "qty2": qty2,
        "qty3": qty3,
        "berat": berat,
        "discountinued": discountinued,
        "photourl": photourl,
        "stockdescription": stockdescription,
        "images": List<dynamic>.from(images.map((x) => x)),
      };
}
