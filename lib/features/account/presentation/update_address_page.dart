import 'package:flutter/material.dart';
import 'package:pas_mobile/core/data/models/provinces_model.dart';
import 'package:pas_mobile/core/presentation/widgets/custom_dialog_confirm.dart';
import 'package:pas_mobile/core/static/app_config.dart';
import 'package:pas_mobile/features/account/data/models/get_address_model.dart';
import 'package:pas_mobile/features/account/presentation/providers/shipping_address_provider.dart';

import 'package:provider/provider.dart';

import '../../../core/presentation/pages/main_page/main_page.dart';
import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/custom_simple_dialog.dart';
import '../../../core/presentation/widgets/custom_text_field.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/static/colors.dart';
import '../../../core/static/dimens.dart';
import '../../../core/utility/enum.dart';
import '../../../core/utility/helper.dart';
import '../../../core/utility/injection.dart';
import '../../../core/utility/validation_helper.dart';
import 'providers/create_address_state.dart';

class UpdateAddressPage extends StatelessWidget {
  final ShippingAddress shippingAddress;
  const UpdateAddressPage({
    Key? key,
    required this.shippingAddress,
  }) : super(key: key);
  static const routeName = '/update-address';

  void submit() {
    logMe("Simpannn");
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => locator<ShippingAddressProvider>()
        ..setAddressData(shippingAddress)
        ..fetchProvinceListUpdate(shippingAddress.province).listen((event) {}),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: "Edit Alamat",
          centerTitle: true,
          canBack: true,
          hideShadow: false,
        ),
        body: Consumer<ShippingAddressProvider>(
          builder: (context, provider, _) => Form(
            key: provider.formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: SIZE_MEDIUM),
                child: Column(
                  children: [
                    mediumVerticalSpacing(),
                    CustomTextField(
                      title: "*Nama Lengkap",
                      controller: provider.nameController,
                      inputType: TextInputType.text,
                      fieldValidator: ValidationHelper(
                        loc: appLoc,
                        isError: (bool value) =>
                            provider.setUsernameError = value,
                        typeField: TypeField.username,
                      ).validate(),
                    ),
                    mediumVerticalSpacing(),
                    CustomTextField(
                      title: "*No. Telpon",
                      controller: provider.phoneNumberController,
                      inputType: TextInputType.phone,
                      fieldValidator: ValidationHelper(
                        loc: appLoc,
                        isError: (bool value) =>
                            provider.setUsernameError = value,
                        typeField: TypeField.phone,
                      ).validate(),
                    ),
                    mediumVerticalSpacing(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          "*Provinsi",
                          style: TextStyle(
                              fontSize: FONT_GENERAL,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4.0),
                        Container(
                            decoration: const BoxDecoration(
                              color: SHADOW,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                            ),
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<Province>(
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: primaryColor,
                                      size: 25,
                                    ),
                                    hint: const Text(
                                      "Pilih Provinsi",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    value: provider.selectedProvince,
                                    onChanged: (Province? item) {
                                      provider.setSelectedProvince = item;

                                      logMe(provider.selectedProvince);
                                    },
                                    items: provider.provinceList
                                        .map((Province provinces) {
                                      return DropdownMenuItem<Province>(
                                          value: provinces,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                provinces.name,
                                                style: const TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ],
                                          ));
                                    }).toList()),
                              ),
                            )),
                      ],
                    ),
                    mediumVerticalSpacing(),
                    CustomTextField(
                      title: "*Kota/Kabupaten",
                      controller: provider.regenciesController,
                      inputType: TextInputType.text,
                      fieldValidator: ValidationHelper(
                        loc: appLoc,
                        isError: (bool value) =>
                            provider.setUsernameError = value,
                        typeField: TypeField.username,
                      ).validate(),
                    ),
                    mediumVerticalSpacing(),
                    CustomTextField(
                      title: "*Alamat",
                      controller: provider.streetNameController,
                      inputType: TextInputType.text,
                      fieldValidator: ValidationHelper(
                        loc: appLoc,
                        isError: (bool value) =>
                            provider.setUsernameError = value,
                        typeField: TypeField.none,
                      ).validate(),
                    ),
                    mediumVerticalSpacing(),
                    CustomTextField(
                      title: "*Detail Alamat",
                      controller: provider.detailAddressController,
                      inputType: TextInputType.text,
                      fieldValidator: ValidationHelper(
                        loc: appLoc,
                        isError: (bool value) =>
                            provider.setUsernameError = value,
                        typeField: TypeField.none,
                      ).validate(),
                    ),
                    mediumVerticalSpacing(),
                    RoundedButton(
                      title: "Hapus",
                      color: SHADOW,
                      sizeButton: 40,
                      textColor: secondaryColor,
                      event: () {
                        showDialog(
                          context: context,
                          builder: (_) => CustomConfirmDialog(
                            positiveAction: () async {
                              provider
                                  .deleteAddress(shippingAddress.id)
                                  .listen((event) {
                                if (event is CreateAdressSuccess) {
                                  showShortToast(
                                      message: 'Alamat Telah Dihapus');

                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    MainPage.routeName,
                                    (route) => false,
                                    arguments: 3, // navbar index
                                  );
                                } else if (event is CreateAdressFailure) {
                                  final msg = getErrorMessage(event.failure);
                                  showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (context) {
                                        return CustomSimpleDialog(
                                            text: msg,
                                            onTap: () {
                                              Navigator.pop(context);
                                            });
                                      });
                                }
                              });
                            },
                            title: "Yakin Hapus Alamat Ini ?",
                          ),
                        );
                      },
                    ),
                    smallVerticalSpacing(),
                    RoundedButton(
                      title: "Simpan",
                      color: secondaryColor,
                      event: () {
                        if (provider.formKey.currentState!.validate()) {
                          provider
                              .updateAddress(shippingAddress.id)
                              .listen((event) {
                            if (event is CreateAdressSuccess) {
                              showShortToast(message: 'Alamat Berhasil Diubah');

                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                MainPage.routeName,
                                (route) => false,
                                arguments: 3, // navbar index
                              );
                            } else if (event is CreateAdressFailure) {
                              final msg = getErrorMessage(event.failure);
                              showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return CustomSimpleDialog(
                                        text: msg,
                                        onTap: () {
                                          Navigator.pop(context);
                                        });
                                  });
                            }
                          });
                        }
                      },
                    ),
                    SizedBox(height: App(context).appHeight(45))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
