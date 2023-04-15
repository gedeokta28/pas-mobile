import 'package:flutter/material.dart';
import 'package:pas_mobile/core/utility/enum.dart';
import 'package:pas_mobile/core/utility/extensions.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/order/presentation/providers/detail_order_state.dart';
import 'package:pas_mobile/features/order/presentation/widgets/address_card_order_detail.dart';
import 'package:pas_mobile/features/order/presentation/widgets/order_detail_item_widget.dart';
import 'package:pas_mobile/features/order/presentation/widgets/order_detail_top_widget.dart';
import 'package:pas_mobile/features/order/presentation/widgets/payment_method_detail.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/pages/main_page/main_page.dart';
import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/static/assets.dart';
import '../../../core/static/colors.dart';
import '../../../core/static/dimens.dart';
import '../../../core/utility/injection.dart';
import '../../../core/utility/session_helper.dart';
import '../../cart/presentation/providers/cart_provider.dart';
import 'providers/order_provider.dart';
import 'widgets/order_item_detail_widget.dart';
import 'widgets/order_item_widget.dart';

class OrderDetailPageArguments {
  final bool isFromCheckout;
  final String orderId;

  OrderDetailPageArguments(
      {required this.isFromCheckout, required this.orderId});
}

class OrderDetailPage extends StatelessWidget {
  final bool isFromCheckout;
  final String orderId;

  const OrderDetailPage(
      {Key? key, required this.isFromCheckout, required this.orderId})
      : super(key: key);
  static const routeName = '/order-detail';

  @override
  Widget build(BuildContext context) {
    final TextEditingController noteController = TextEditingController();
    if (isFromCheckout) {
      return WillPopScope(
        onWillPop: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            MainPage.routeName,
            (route) => false,
            arguments: 3, // navbar index
          );

          return Future.value(false);
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Consumer<CartProvider>(
                  builder: (BuildContext context, provider, widget) {
                return const CustomAppBar(
                  title: "Order Detail",
                  centerTitle: true,
                  canBack: false,
                  hideShadow: false,
                );
              })),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: StreamBuilder<DetailOrderState>(
                  stream: context
                      .read<OrderProvider>()
                      .fetchDetailOrder(orderId: orderId),
                  builder: (context, state) {
                    if (state.data.runtimeType == DetailOrderLoading) {
                      return Center(
                        child: Image.asset(
                          ASSETS_LOADING,
                          height: 100.0,
                          width: 100.0,
                        ),
                      );
                    } else if (state.data.runtimeType == DetailOrderSuccess) {
                      final _data =
                          (state.data as DetailOrderSuccess).detailOrder;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Terima Kasih. Pesanan Anda telah diterima',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: FONT_GENERAL,
                                  color: Colors.black87),
                            ),
                          ),
                          mediumVerticalSpacing(),
                          OrderDetailTopWidget(detailOrder: _data),
                          Divider(
                            color: Colors.grey[400],
                          ),
                          mediumVerticalSpacing(),
                          PaymentMethodDetailWidget(
                              paymentMethod: _data.paymentype),
                          const SizedBox(height: 25.0),
                          ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: _data.products.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return OrderItemWidget(
                                    productOrder: _data.products[index]);
                              }),
                          Divider(
                            color: Colors.grey[400],
                          ),
                          OrderDetailItemWidget(
                              title: 'Total',
                              isPrice: true,
                              detail: _data.salesordergrandtotal.toString()),
                          smallVerticalSpacing(),
                          const Text(
                            'Alamat pengiriman :',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: FONT_GENERAL,
                                color: Colors.black),
                          ),
                          smallVerticalSpacing(),
                          AddressCardOrderDetail(
                              fullName: _data.deliveryto,
                              phone: _data.deliveryphone,
                              streetAddress: _data.deliveryaddress),
                          mediumVerticalSpacing(),
                          RoundedButton(
                            title: "Belanja Lagi",
                            color: secondaryColor,
                            event: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                MainPage.routeName,
                                (route) => false,
                                arguments: 0, // navbar index
                              );
                            },
                          ),
                          smallVerticalSpacing(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              elevation: 0.0,
                              side: const BorderSide(
                                width: 1.0,
                                color: secondaryColor,
                              ),
                              textStyle: const TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              minimumSize: const Size.fromHeight(50.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onPressed: () {
                              final session = locator<Session>();
                              session.setIndexTab = 1;
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                MainPage.routeName,
                                (route) => false,
                                arguments: 3, // navbar index
                              );
                            },
                            child: const Text(
                              'Cek Status Order',
                              style: TextStyle(
                                  color: secondaryColor, fontSize: 15.0),
                            ),
                          ),
                          largeVerticalSpacing()
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text('Ada Kesalaha asdasdan'),
                      );
                    }
                  }),
            ),
          ),
        ),
      );
    }
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Consumer<CartProvider>(
                builder: (BuildContext context, provider, widget) {
              return const CustomAppBar(
                title: "Order Detail",
                centerTitle: true,
                canBack: true,
                hideShadow: false,
              );
            })),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder<DetailOrderState>(
                stream: context
                    .read<OrderProvider>()
                    .fetchDetailOrder(orderId: orderId),
                builder: (context, state) {
                  if (state.data.runtimeType == DetailOrderLoading) {
                    return Center(
                      child: Image.asset(
                        ASSETS_LOADING,
                        height: 100.0,
                        width: 100.0,
                      ),
                    );
                  } else if (state.data.runtimeType == DetailOrderSuccess) {
                    final _data =
                        (state.data as DetailOrderSuccess).detailOrder;
                    noteController.text = _data.notes ?? '';
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        OrderDetailTopWidget(
                          detailOrder: _data,
                          isFromCheckout: false,
                          orderStatus: _data.status,
                        ),
                        Divider(
                          color: Colors.grey[400],
                        ),
                        mediumVerticalSpacing(),
                        if (_data.status ==
                            StatusOrder.paymentPending.getString())
                          PaymentMethodDetailWidget(
                              paymentMethod: _data.paymentype)
                        else if (_data.paymentype ==
                                PaymentMethod.cash.getString() &&
                            _data.status !=
                                StatusOrder.paymentPending.getString())
                          PaymentMethodDetailWidget(
                              paymentMethod: _data.paymentype)
                        else
                          const SizedBox.shrink(),
                        if (_data.status ==
                            StatusOrder.paymentPending.getString())
                          const SizedBox(height: 25.0)
                        else if (_data.paymentype ==
                                PaymentMethod.cash.getString() &&
                            _data.status !=
                                StatusOrder.paymentPending.getString())
                          const SizedBox(height: 25.0)
                        else
                          const SizedBox.shrink(),
                        ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: _data.products.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return OrderItemDetailWidget(
                                  productOrder: _data.products[index]);
                            }),
                        Divider(
                          color: Colors.grey[400],
                        ),
                        smallVerticalSpacing(),
                        OrderDetailItemWidget(
                            title: 'Metode Pembayaran',
                            detail: _data.paymentype),
                        OrderDetailItemWidget(
                            title: 'Total',
                            isPrice: true,
                            detail: _data.salesordergrandtotal.toString()),
                        smallVerticalSpacing(),
                        const Text(
                          'Alamat pengiriman :',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: FONT_GENERAL,
                              color: Colors.black),
                        ),
                        smallVerticalSpacing(),
                        AddressCardOrderDetail(
                            fullName: _data.deliveryto,
                            phone: _data.deliveryphone,
                            streetAddress: _data.deliveryaddress),
                        mediumVerticalSpacing(),
                        noteController.text.isEmpty
                            ? const SizedBox.shrink()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  const Text(
                                    'Note :',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: FONT_GENERAL,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(height: 5.0),
                                  Form(
                                    child: TextFormField(
                                        maxLines: 1,
                                        readOnly: true,
                                        controller: noteController,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        style: const TextStyle(
                                            fontSize: FONT_GENERAL,
                                            color: Colors.black),
                                        decoration: const InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 0,
                                                    horizontal: 10),
                                            focusColor: Colors.white,
                                            prefixIcon: Icon(
                                              Icons.note_alt,
                                              color: secondaryColor,
                                            ),
                                            isCollapsed: true,
                                            border: InputBorder.none,
                                            filled: true,
                                            fillColor: Colors.white,
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5.0),
                                              ),
                                              borderSide: BorderSide(
                                                  color: Colors.black45,
                                                  width: 0.5),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(5.0),
                                              ),
                                              borderSide: BorderSide(
                                                  color: Colors.black45,
                                                  width: 0.5),
                                            ))),
                                  ),
                                ],
                              ),
                        largeVerticalSpacing()
                      ],
                    );
                  } else {
                    return const Center(
                      child: Text('Ada Kesalaha asdasdan'),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}
