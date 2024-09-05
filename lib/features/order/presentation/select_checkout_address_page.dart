import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/app_config.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/features/order/presentation/providers/shipping_address_state.dart';
import 'package:pas_mobile/features/order/presentation/widgets/address_card_checkout.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/pages/main_page/main_page.dart';
import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/rounded_container.dart';
import '../../../core/utility/helper.dart';
import '../../../core/utility/injection.dart';
import '../../account/data/models/get_address_model.dart';
import 'providers/address_checkout_provider.dart';

class AddressCheckoutPage extends StatefulWidget {
  final ShippingAddress? shippingAddress;
  const AddressCheckoutPage({Key? key, this.shippingAddress}) : super(key: key);
  static const routeName = '/address-checkout';

  @override
  State<AddressCheckoutPage> createState() => _AddressCheckoutPageState();
}

class _AddressCheckoutPageState extends State<AddressCheckoutPage> {
  final _provider = locator<AddressCheckoutProvider>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _provider,
        builder: (context, child) {
          _provider.fetchAddressList();
          return Consumer<AddressCheckoutProvider>(
              builder: (context, value, child) {
            final state = value.state;
            return WillPopScope(
              onWillPop: () {
                Navigator.pop(context, widget.shippingAddress);
                return Future.value(true);
              },
              child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(kToolbarHeight),
                      child: CustomAppBar(
                          title: "Pilih Alamat",
                          centerTitle: true,
                          canBack: true,
                          hideShadow: false,
                          onTapBack: () {
                            Navigator.pop(context, widget.shippingAddress);
                          })),
                  body: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Consumer<AddressCheckoutProvider>(
                        builder: (BuildContext context, provider, widget) {
                      if (state is ShippingAddressListFailure) {
                        return const SizedBox.shrink();
                      } else if (state is ShippingAddressListLoading) {
                        return Center(
                          child: Image.asset(
                            ASSETS_LOADING,
                            height: 100.0,
                            width: 100.0,
                          ),
                        );
                      } else if (state is ShippingAddressListEmpty) {
                        return const Center(
                            child: Text(
                          'Tambahkan Alamat Pengiriman',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.grey),
                        ));
                      } else if (state is ShippingAddressListSuccess) {
                        final List<ShippingAddress> _shipingAddressList =
                            _provider.shipingAddressList;
                        return Column(
                          children: [
                            RoundedContainer(
                              height: 40,
                              color: Colors.grey[200]!,
                              child: Focus(
                                child: TextField(
                                  controller: _provider.searchAddressController,
                                  textInputAction: TextInputAction.search,
                                  onEditingComplete: () {},
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlignVertical: TextAlignVertical.center,
                                  onChanged: (value) {
                                    _provider.setResultEmpty = false;
                                    _provider.onSearchTextChanged(
                                        value.toLowerCase());
                                  },
                                  decoration: const InputDecoration(
                                    contentPadding: EdgeInsets.all(0.0),
                                    border: InputBorder.none,
                                    isDense: true,
                                    prefixIcon: Icon(
                                      Icons.search_rounded,
                                      size: 40 / 1.5,
                                    ),
                                    prefixIconColor: Colors.grey,
                                    hintText: 'Cari Alamat',
                                    hintStyle: TextStyle(fontSize: 14.0),
                                  ),
                                ),
                              ),
                            ),
                            mediumVerticalSpacing(),
                            _provider.searchResult.isNotEmpty ||
                                    _provider
                                        .searchAddressController.text.isNotEmpty
                                ? Expanded(
                                    child: _provider.resultIsEmpty
                                        ? const Center(
                                            child:
                                                Text('Alamat tidak ditemukan'))
                                        : ListView.builder(
                                            padding: EdgeInsets.zero,
                                            itemCount:
                                                _provider.searchResult.length,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(
                                                      context,
                                                      _provider
                                                          .searchResult[index]);
                                                },
                                                child: AddressCardCheckout(
                                                  shippingAddress: _provider
                                                      .searchResult[index],
                                                ),
                                              );
                                            },
                                          ),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      itemCount: _shipingAddressList.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.pop(context,
                                                _shipingAddressList[index]);
                                          },
                                          child: AddressCardCheckout(
                                            shippingAddress:
                                                _shipingAddressList[index],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    }),

                    // StreamBuilder<GetAddressListState>(
                    //     stream: context
                    //         .read<AddressCheckoutProvider>()
                    //         .fetchAddressList(),
                    //     builder: (context, state) {
                    //       switch (state.data.runtimeType) {
                    //         case GetAddressListLoading:
                    //           return Center(
                    //             child: Image.asset(
                    //               ASSETS_LOADING,
                    //               height: 100.0,
                    //               width: 100.0,
                    //             ),
                    //           );
                    //         case GetAddressListFailure:
                    //           final failure =
                    //               (state.data as GetAddressListFailure).failure;
                    //           final msg = getErrorMessage(failure);
                    //           showShortToast(message: msg);
                    //           return const SizedBox.shrink();
                    //         case GetAddressListSuccess:
                    //           final _data =
                    //               (state.data as GetAddressListSuccess).data;
                    //           if (_data.isEmpty) {
                    //             return Padding(
                    //               padding: EdgeInsets.only(
                    //                   top: App(context).appHeight(20)),
                    //               child: const Center(
                    //                   child: Text(
                    //                 'Tambahkan Alamat Pengiriman',
                    //                 style: TextStyle(
                    //                     fontWeight: FontWeight.bold,
                    //                     fontSize: 18.0,
                    //                     color: Colors.grey),
                    //               )),
                    //             );
                    //           }
                    //           return Consumer<AddressCheckoutProvider>(
                    //               builder: (BuildContext context, provider, widget) {
                    //             return Column(
                    //               children: [
                    //                 CustomTextField(
                    //                     title: 'Cari Alamat',
                    //                     controller: provider.searchAddressController,
                    //                     fieldValidator: null),
                    //                 mediumVerticalSpacing(),
                    // Expanded(
                    //   child: ListView.builder(
                    //       padding: EdgeInsets.zero,
                    //       shrinkWrap: true,
                    //       itemCount: _data.length,
                    //       physics:
                    //           const NeverScrollableScrollPhysics(),
                    //       itemBuilder: (context, index) {
                    //         return GestureDetector(
                    //             onTap: () {
                    //               // _orderProvider.setShippingAddress =
                    //               //     _data[index];
                    //               // Navigator.pop(context);
                    //               Navigator.pop(
                    //                   context, _data[index]);
                    //             },
                    //             child: AddressCardCheckout(
                    //               shippingAddress: _data[index],
                    //             ));
                    //       }),
                    // ),
                    //               ],
                    //             );
                    //           });
                    //       }
                    //       return const SizedBox.shrink();
                    //     }),
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
                  )),
            );
          });
        });
  }
}
