import 'package:flutter/material.dart';
import 'package:pas_mobile/core/data/models/provinces_model.dart';
import 'package:pas_mobile/core/static/app_config.dart';
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

class CreateAddressPage extends StatelessWidget {
  final bool isFromListPage;
  const CreateAddressPage({Key? key, this.isFromListPage = false})
      : super(key: key);
  static const routeName = '/create-address';

  void submit() {
    logMe("Simpannn");
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => locator<ShippingAddressProvider>()
        ..fetchProvinceList().listen((event) {}),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: "Tambah Alamat",
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
                                      provider.setProvinceValidate = true;
                                    },
                                    items: provider.provinceList
                                        .map((Province province) {
                                      return DropdownMenuItem<Province>(
                                          value: province,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                province.name,
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
                    provider.isProvinceValidate
                        ? const SizedBox()
                        : const SizedBox(
                            height: 20,
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.only(left: 15, top: 5.0),
                              child: Text(
                                'Pilih Provinsi',
                                style: TextStyle(
                                    color: ERROR_RED_COLOR_TEXT, fontSize: 13),
                              ),
                            ),
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
                      title: "Tambah",
                      color: secondaryColor,
                      event: () {
                        if (provider.selectedProvince == null) {
                          provider.setProvinceValidate = false;
                          if (provider.formKey.currentState!.validate()) {}
                        } else {
                          if (provider.formKey.currentState!.validate()) {
                            provider.createAddress().listen((event) {
                              if (event is CreateAdressSuccess) {
                                showShortToast(
                                    message: 'Alamat Berhasil Ditambahkan');
                                if (isFromListPage) {
                                  Navigator.pop(context, true);
                                } else {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    MainPage.routeName,
                                    (route) => false,
                                    arguments: 3, // navbar index
                                  );
                                }
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
                          provider.setProvinceValidate = true;
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
