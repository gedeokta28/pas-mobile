import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/app_config.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/features/cart/presentation/providers/add_cart_state.dart';
import 'package:pas_mobile/features/order/presentation/providers/order_provider.dart';
import 'package:pas_mobile/features/order/presentation/widgets/address_card_checkout.dart';
import 'package:pas_mobile/features/order/presentation/widgets/checkout_address_widget.dart';
import 'package:pas_mobile/features/order/presentation/widgets/checkout_item.dart';
import 'package:pas_mobile/features/order/presentation/widgets/checkout_noted_widget.dart';
import 'package:pas_mobile/features/order/presentation/widgets/payment_method_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/pages/main_page/main_page.dart';
import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/static/dimens.dart';
import '../../../core/utility/helper.dart';
import '../../../core/utility/injection.dart';
import '../../account/presentation/providers/get_address_list_state.dart';
import '../../account/presentation/widgets/address_card.dart';
import '../../cart/presentation/providers/cart_provider.dart';

class AddressCheckoutPage extends StatelessWidget {
  const AddressCheckoutPage({
    Key? key,
  }) : super(key: key);
  static const routeName = '/address-checkout';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Consumer<CartProvider>(
                builder: (BuildContext context, provider, widget) {
              return const CustomAppBar(
                title: "Pilih Alamat",
                centerTitle: true,
                canBack: true,
                hideShadow: false,
              );
            })),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: StreamBuilder<GetAddressListState>(
                stream: context.read<OrderProvider>().fetchAddressList(),
                builder: (context, state) {
                  switch (state.data.runtimeType) {
                    case GetAddressListLoading:
                      return Center(
                        child: Image.asset(
                          ASSETS_LOADING,
                          height: 100.0,
                          width: 100.0,
                        ),
                      );
                    case GetAddressListFailure:
                      final failure =
                          (state.data as GetAddressListFailure).failure;
                      final msg = getErrorMessage(failure);
                      showShortToast(message: msg);
                      return const SizedBox.shrink();
                    case GetAddressListSuccess:
                      final _data = (state.data as GetAddressListSuccess).data;

                      return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          itemCount: _data.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Consumer<OrderProvider>(builder:
                                (BuildContext context, provider, widget) {
                              return GestureDetector(
                                  onTap: () {
                                    provider.setShippingAddress = _data[index];
                                    Navigator.pop(context);
                                  },
                                  child: AddressCardCheckout(
                                    shippingAddress: _data[index],
                                  ));
                            });
                            // return GestureDetector(
                            //     onTap: () {

                            //     },
                            //     child: AddressCardCheckout(
                            //       shippingAddress: _data[index],
                            //     ));
                          });
                  }
                  return const SizedBox.shrink();
                }),
          ),
        ),
        bottomNavigationBar: InkWell(
          onTap: () async {
            Navigator.pushNamedAndRemoveUntil(
              context,
              MainPage.routeName,
              (route) => false,
              arguments: 3, // navbar index
            );
          },
          child: Container(
            color: secondaryColor,
            alignment: Alignment.center,
            height: App(context).appHeight(8),
            child: const Text(
              'Edit Alamat',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ));
  }
}
