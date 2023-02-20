import 'package:flutter/material.dart';
import 'package:pas_mobile/core/data/models/provinces_model.dart';
import 'package:pas_mobile/core/data/models/regencies_model.dart';
import 'package:pas_mobile/core/static/app_config.dart';
import 'package:pas_mobile/features/account/presentation/providers/management_account_provider.dart';

import 'package:provider/provider.dart';

import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/custom_text_field.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/static/colors.dart';
import '../../../core/static/dimens.dart';
import '../../../core/utility/enum.dart';
import '../../../core/utility/helper.dart';
import '../../../core/utility/injection.dart';
import '../../../core/utility/validation_helper.dart';

class UpdateAddressPage extends StatelessWidget {
  const UpdateAddressPage({
    Key? key,
  }) : super(key: key);
  static const routeName = '/update-address';

  void submit() {
    logMe("Simpannn");
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => locator<ManagementAccountProvider>()
        ..fetchProvinceList().listen((event) {}),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: "Edit Alamat",
          centerTitle: true,
          canBack: true,
          hideShadow: false,
        ),
        body: Consumer<ManagementAccountProvider>(
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
                        Text(
                          "*Provinsi",
                          style: const TextStyle(
                              fontSize: FONT_GENERAL,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4.0),
                        Container(
                            decoration: BoxDecoration(
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
                                    hint: Text(
                                      "Pilih Provinsi",
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                    value: provider.selectedProvince,
                                    onChanged: (Province? item) {
                                      provider.setSelectedProvince = item;
                                      provider
                                          .fetchRegenciesList()
                                          .listen((event) {});
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "*Kota / Kabupaten",
                          style: const TextStyle(
                              fontSize: FONT_GENERAL,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4.0),
                        Container(
                            decoration: BoxDecoration(
                              color: SHADOW,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                            ),
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<RegenciesModel>(
                                    icon: const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: primaryColor,
                                      size: 25,
                                    ),
                                    hint: Text(
                                      "Pilih Kota / Kabupaten",
                                      style:
                                          const TextStyle(color: Colors.grey),
                                    ),
                                    value: provider.selectedRegencies,
                                    onChanged: (RegenciesModel? item) {
                                      provider.setSelectedRegencies = item;
                                      logMe(provider.selectedRegencies);
                                    },
                                    items: provider.regenciesList
                                        .map((RegenciesModel regenciesModel) {
                                      return DropdownMenuItem<RegenciesModel>(
                                          value: regenciesModel,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                regenciesModel.name,
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
                      title: "Simpan",
                      color: secondaryColor,
                      event: () {
                        provider.fetchProvinceList().listen((event) {});
                        // if (provider.formKey.currentState!.validate()) submit();
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
