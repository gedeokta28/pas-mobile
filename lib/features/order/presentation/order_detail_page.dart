import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/app_config.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/order/presentation/widgets/order_detail_item_widget.dart';
import 'package:pas_mobile/features/order/presentation/widgets/order_detail_top_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/pages/main_page/main_page.dart';
import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/static/assets.dart';
import '../../../core/static/dimens.dart';
import '../../cart/presentation/providers/cart_item_state.dart';
import '../../cart/presentation/providers/cart_provider.dart';
import 'providers/order_provider.dart';
import 'widgets/checkout_item.dart';
import 'widgets/order_item_widget.dart';

class OrderDetailPage extends StatelessWidget {
  final bool isFromCheckout;
  const OrderDetailPage({Key? key, this.isFromCheckout = false})
      : super(key: key);
  static const routeName = '/order-detail';

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              children: [
                const Center(
                  child: Text(
                    'Terima Kasih. Pesanan Anda telah diterima',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontSize: FONT_GENERAL, color: Colors.black87),
                  ),
                ),
                mediumVerticalSpacing(),
                const OrderDetailTopWidget(),
                Divider(
                  color: Colors.grey[400],
                ),
                mediumVerticalSpacing(),
                const Text(
                  'Bayar dengan uang tunai pada saat pengiriman',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: FONT_GENERAL,
                      color: Colors.black),
                ),
                const SizedBox(height: 25.0),
                StreamBuilder<CartItemState>(
                    stream: context.read<OrderProvider>().fetchCart(),
                    builder: (context, state) {
                      switch (state.data.runtimeType) {
                        case CartItemLoading:
                          return Center(
                            child: Image.asset(
                              ASSETS_LOADING,
                              height: 100.0,
                              width: 100.0,
                            ),
                          );
                        case CartItemFailure:
                          final failure =
                              (state.data as CartItemFailure).failure;
                          final msg = getErrorMessage(failure);
                          showShortToast(message: msg);
                          return const SizedBox.shrink();
                        case CartItemSuccess:
                          final _data = (state.data as CartItemSuccess).data;
                          logMe(_data.length);
                          logMe('_data.length');
                          return ListView.builder(
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              itemCount: _data.length,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return OrderItemWidget(itemCart: _data[index]);
                              });
                      }
                      return const SizedBox.shrink();
                    }),
                Divider(
                  color: Colors.grey[400],
                ),
                OrderDetailItemWidget(title: 'Total', detail: 'Rp. 1231231')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
