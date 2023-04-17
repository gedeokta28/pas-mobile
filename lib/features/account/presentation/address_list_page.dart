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
import 'create_address_page.dart';
import 'providers/shipping_address_provider.dart';
import 'update_address_page.dart';
import 'widgets/address_card.dart';

class AddressListPage extends StatefulWidget {
  const AddressListPage({Key? key}) : super(key: key);
  static const routeName = '/address-list';

  @override
  State<AddressListPage> createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {
  final _provider = locator<ShippingAddressProvider>();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => _provider,
        builder: (context, child) {
          _provider.fetchAddressListFromApi();
          return Consumer<ShippingAddressProvider>(
              builder: (context, value, child) {
            final state = value.state;
            return WillPopScope(
              onWillPop: () {
                FocusScope.of(context).unfocus();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  MainPage.routeName,
                  (route) => false,
                  arguments: 3, // navbar index
                );
                return Future.value(true);
              },
              child: Scaffold(
                  backgroundColor: Colors.white,
                  appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(kToolbarHeight),
                      child: CustomAppBar(
                        title: "Alamat Pengiriman",
                        centerTitle: true,
                        canBack: true,
                        onTapBack: () {
                          FocusScope.of(context).unfocus();

                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            MainPage.routeName,
                            (route) => false,
                            arguments: 3, // navbar index
                          );
                        },
                        hideShadow: false,
                      )),
                  body: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Consumer<ShippingAddressProvider>(
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
                                  onEditingComplete: () {
                                    FocusScope.of(context).unfocus();
                                  },
                                  style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
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
                                        ? const Text('Alamat tidak ditemukan')
                                        : ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount:
                                                _provider.searchResult.length,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(context)
                                                        .unfocus();

                                                    Navigator.pushNamed(
                                                        context,
                                                        UpdateAddressPage
                                                            .routeName,
                                                        arguments:
                                                            UpdateAddressPageArguments(
                                                                shippingAddress:
                                                                    _provider
                                                                            .searchResult[
                                                                        index],
                                                                isFromList:
                                                                    true));
                                                  },
                                                  child: AddressCard(
                                                    shippingAddress: _provider
                                                        .searchResult[index],
                                                  ));
                                            }),
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        shrinkWrap: true,
                                        itemCount: _shipingAddressList.length,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) {
                                          return GestureDetector(
                                              onTap: () {
                                                FocusScope.of(context)
                                                    .unfocus();

                                                Navigator.pushNamed(
                                                        context,
                                                        UpdateAddressPage
                                                            .routeName,
                                                        arguments:
                                                            UpdateAddressPageArguments(
                                                                shippingAddress:
                                                                    _shipingAddressList[
                                                                        index],
                                                                isFromList:
                                                                    true))
                                                    .then((value) {
                                                  if (value == true) {
                                                    _provider
                                                        .fetchAddressListFromApi();
                                                  }
                                                });
                                              },
                                              child: AddressCard(
                                                shippingAddress:
                                                    _shipingAddressList[index],
                                                onTapBack: () {
                                                  FocusScope.of(context)
                                                      .unfocus();

                                                  Navigator.pushNamed(
                                                          context,
                                                          UpdateAddressPage
                                                              .routeName,
                                                          arguments: UpdateAddressPageArguments(
                                                              shippingAddress:
                                                                  _shipingAddressList[
                                                                      index],
                                                              isFromList: true))
                                                      .then((value) {
                                                    if (value == true) {
                                                      _provider
                                                          .fetchAddressListFromApi();
                                                    }
                                                  });
                                                },
                                                isFromList: true,
                                              ));
                                        }),
                                  ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                  ),
                  bottomNavigationBar: InkWell(
                    onTap: () async {
                      FocusScope.of(context).unfocus();

                      Navigator.pushNamed(context, CreateAddressPage.routeName,
                              arguments: true)
                          .then((value) {
                        if (value == true) {
                          _provider.fetchAddressListFromApi();
                        }
                      });
                    },
                    child: Container(
                      color: secondaryColor,
                      alignment: Alignment.center,
                      height: App(context).appHeight(8),
                      child: const Text(
                        'Tambah Alamat',
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
