import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/features/home/presentation/home_page.dart';

enum M_BTB {
  home,
  brand,
  order,
  account,
  info,
}

List<M_BTB> content = [
  M_BTB.home,
  M_BTB.brand,
  M_BTB.order,
  M_BTB.account,
  M_BTB.info,
];

extension M_BTBExtension on M_BTB {
  String get title {
    switch (this) {
      case M_BTB.home:
        return "Home";
      case M_BTB.brand:
        return "Brand";
      case M_BTB.order:
        return "Order";
      case M_BTB.account:
        return "Account";
      case M_BTB.info:
        return "Info";
    }
  }

  String get icon {
    switch (this) {
      case M_BTB.home:
        return HOME_ICON;
      case M_BTB.brand:
        return BRAND_ICON;
      case M_BTB.order:
        return ORDER_ICON;
      case M_BTB.account:
        return ACCOUNT_ICON;
      case M_BTB.info:
        return INFO_ICON;
    }
  }

  Widget get content {
    switch (this) {
      case M_BTB.home:
        // return Center(
        //   child: const Text(
        //     "HOME",
        //     style: TextStyle(color: Colors.black),
        //   ),
        // );
        return HomePage();
      case M_BTB.brand:
        return Center(
          child: const Text(
            "BRAND",
            style: TextStyle(color: Colors.black),
          ),
        );
      case M_BTB.order:
        return Center(
          child: const Text(
            "ORDER",
            style: TextStyle(color: Colors.black),
          ),
        );
      case M_BTB.account:
        return Center(
          child: const Text(
            "ACC",
            style: TextStyle(color: Colors.black),
          ),
        );
      case M_BTB.info:
        return Center(
          child: const Text(
            "INFO",
            style: TextStyle(color: Colors.black),
          ),
        );
    }
  }
}
