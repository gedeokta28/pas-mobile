import 'package:flutter/material.dart';
import 'package:pas_mobile/core/data/models/provinces_model.dart';
import 'package:pas_mobile/core/data/models/regencies_model.dart';
import 'package:pas_mobile/core/static/app_config.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/features/account/presentation/providers/management_account_provider.dart';
import 'package:pas_mobile/features/category/presentation/providers/category_provider.dart';
import 'package:pas_mobile/features/category/presentation/providers/category_state.dart';
import 'package:pas_mobile/features/category/presentation/widgets/category_item.dart';
import 'package:pas_mobile/features/login/presentation/providers/login_provider.dart';
import 'package:provider/provider.dart';

import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/custom_text_field.dart';
import '../../../core/presentation/widgets/custom_text_field_clear.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/static/colors.dart';
import '../../../core/static/dimens.dart';
import '../../../core/utility/enum.dart';
import '../../../core/utility/helper.dart';
import '../../../core/utility/injection.dart';
import '../../../core/utility/validation_helper.dart';
import '../../forgot_password/presentation/providers/forgot_password_provider.dart';
import '../../home/presentation/product_page.dart';
import '../../home/presentation/providers/home_provider.dart';

class ChangePersonalInfoPage extends StatelessWidget {
  const ChangePersonalInfoPage({
    Key? key,
  }) : super(key: key);
  static const routeName = '/change-personal-info';

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
          title: "Ubah Info Pribadi",
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
                      title: "*Nama Depan",
                      controller: provider.firstNameController,
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
                      title: "*Nama Belakang",
                      controller: provider.lastNameController,
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
                      title: "*Email",
                      controller: provider.emailController,
                      inputType: TextInputType.emailAddress,
                      fieldValidator: ValidationHelper(
                        loc: appLoc,
                        isError: (bool value) => provider.setEmailError = value,
                        typeField: TypeField.email,
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
                    CustomTextField(
                      title: "Nama Perusahaan",
                      controller: provider.companyNameController,
                      inputType: TextInputType.text,
                      fieldValidator: ValidationHelper(
                        loc: appLoc,
                        isError: (bool value) =>
                            provider.setUsernameError = value,
                        typeField: TypeField.username,
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
                                child: DropdownButton<ProvincesModel>(
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
                                    onChanged: (ProvincesModel? item) {
                                      provider.setSelectedProvince = item;
                                      provider
                                          .fetchRegenciesList()
                                          .listen((event) {});
                                      logMe(provider.selectedProvince);
                                    },
                                    items: provider.provinceList
                                        .map((ProvincesModel provincesModel) {
                                      return DropdownMenuItem<ProvincesModel>(
                                          value: provincesModel,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                provincesModel.name,
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
                      title: "*Kode Post",
                      controller: provider.postCodeController,
                      inputType: TextInputType.number,
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
