import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/account/presentation/address_list_page.dart';
import 'package:pas_mobile/features/account/presentation/change_email_page.dart';
import 'package:pas_mobile/features/account/presentation/change_password_page.dart';
import 'package:pas_mobile/features/account/presentation/change_personal_info_page.dart';
import 'package:pas_mobile/features/account/presentation/create_address_page.dart';
import 'package:pas_mobile/features/account/presentation/providers/profile_state.dart';
import 'package:pas_mobile/features/account/presentation/providers/shipping_address_provider.dart';
import 'package:pas_mobile/features/account/presentation/update_address_page.dart';
import 'package:pas_mobile/features/account/presentation/widgets/address_card.dart';
import 'package:provider/provider.dart';
import '../../../../core/utility/injection.dart' as di;

import '../../../core/static/app_config.dart';
import '../../../core/static/assets.dart';
import 'change_username_page.dart';
import 'providers/get_address_list_state.dart';
import 'providers/management_account_provider.dart';

class ProfileAccountTab extends StatefulWidget {
  const ProfileAccountTab({Key? key, required this.parentController})
      : super(key: key);

  final ScrollController parentController;

  @override
  ProfileAccountTabState createState() => ProfileAccountTabState();
}

class ProfileAccountTabState extends State<ProfileAccountTab>
    with AutomaticKeepAliveClientMixin<ProfileAccountTab> {
  @override
  bool get wantKeepAlive => true;

  late ScrollController _scrollController;

  late ScrollPhysics ph;
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    _scrollController.addListener(() {
      var innerPos = _scrollController.position.pixels;
      var maxOuterPos = widget.parentController.position.maxScrollExtent;
      var currentOutPos = widget.parentController.position.pixels;

      if (innerPos >= 0 && currentOutPos < maxOuterPos) {
        //print("parent pos " + currentOutPos.toString() + "max parent pos " + maxOuterPos.toString());
        widget.parentController.position.jumpTo(innerPos + currentOutPos);
      } else {
        var currenParentPos = innerPos + currentOutPos;
        widget.parentController.position.jumpTo(currenParentPos);
      }
    });

    widget.parentController.addListener(() {
      var currentOutPos = widget.parentController.position.pixels;
      if (currentOutPos <= 0) {
        _scrollController.position.jumpTo(0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(
        create: (context) => di.locator<ManagementAccountProvider>(),
        builder: (context, _) {
          return StreamBuilder<ProfileState>(
              stream: context.read<ManagementAccountProvider>().fetchProfile(),
              builder: (context, state) {
                switch (state.data.runtimeType) {
                  case ProfileLoading:
                    return Center(
                      child: Image.asset(
                        ASSETS_LOADING,
                        height: 100.0,
                        width: 100.0,
                      ),
                    );
                  case ProfileFailure:
                    final failure = (state.data as ProfileFailure).failure;
                    final msg = getErrorMessage(failure);
                    showShortToast(message: msg);
                    return const SizedBox.shrink();
                  case ProfileLoaded:
                    final _data = (state.data as ProfileLoaded).data;
                    return SingleChildScrollView(
                      controller: _scrollController,
                      child: Column(
                        children: [
                          const Divider(),
                          smallVerticalSpacing(),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Akun Detail",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  Text(
                                    "ID #${_data.customerid}",
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54),
                                  )
                                ],
                              ),
                              smallVerticalSpacing(),
                              SizedBox(
                                height: App(context).appHeight(5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: App(context).appWidth(15),
                                      child: const Text(
                                        "Nama",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black87),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            ChangeUsernamePage.routeName,
                                            arguments: _data);
                                      },
                                      child: SizedBox(
                                        width: App(context).appWidth(50),
                                        child: Text(
                                          _data.customername,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        iconSize: 15,
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              ChangeUsernamePage.routeName,
                                              arguments: _data);
                                        },
                                        icon: const Icon(
                                            Icons.arrow_forward_ios_rounded))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: App(context).appHeight(5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: App(context).appWidth(15),
                                      child: const Text(
                                        "Email",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black87),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, ChangeEmailPage.routeName,
                                            arguments: _data);
                                      },
                                      child: SizedBox(
                                        width: App(context).appWidth(50),
                                        child: Text(
                                          _data.email,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontSize: 13,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        iconSize: 15,
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              ChangeEmailPage.routeName,
                                              arguments: _data);
                                        },
                                        icon: const Icon(
                                            Icons.arrow_forward_ios_rounded))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: App(context).appHeight(5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: App(context).appWidth(15),
                                      child: const Text(
                                        "Password",
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Colors.black87),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(context,
                                            ChangePasswordPage.routeName);
                                      },
                                      child: SizedBox(
                                        width: App(context).appWidth(50),
                                        child: const Text(
                                          "********",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                        iconSize: 15,
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              ChangePasswordPage.routeName);
                                        },
                                        icon: const Icon(
                                            Icons.arrow_forward_ios_rounded))
                                  ],
                                ),
                              ),
                              smallVerticalSpacing(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Info Pribadi",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                  IconButton(
                                      iconSize: 15,
                                      onPressed: () {
                                        Navigator.pushNamed(context,
                                            ChangePersonalInfoPage.routeName,
                                            arguments:
                                                ChangePersonalInfoPageArguments(
                                                    profile: _data));
                                      },
                                      icon: Image.asset(EDIT_ICON))
                                ],
                              ),
                              // smallVerticalSpacing(),
                              ChangeNotifierProvider(
                                  create: (context) =>
                                      di.locator<ShippingAddressProvider>(),
                                  builder: (context, _) {
                                    return StreamBuilder<GetAddressListState>(
                                        stream: context
                                            .read<ShippingAddressProvider>()
                                            .fetchAddressList(),
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
                                                  (state.data as ProfileFailure)
                                                      .failure;
                                              final msg =
                                                  getErrorMessage(failure);
                                              showShortToast(message: msg);
                                              return const SizedBox.shrink();
                                            case GetAddressListSuccess:
                                              final _data = (state.data
                                                      as GetAddressListSuccess)
                                                  .data;
                                              if (_data.isEmpty) {
                                                return InkWell(
                                                  onTap: () {
                                                    Navigator.pushNamed(
                                                        context,
                                                        CreateAddressPage
                                                            .routeName,
                                                        arguments: false);
                                                  },
                                                  child: SizedBox(
                                                    height: App(context)
                                                        .appHeight(6),
                                                    // width: App(context).appWidth(45),
                                                    child: const Center(
                                                      child: Text(
                                                        "Tambah Alamat (+)",
                                                        style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                secondaryColor),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }

                                              return Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.pushNamed(
                                                              context,
                                                              CreateAddressPage
                                                                  .routeName,
                                                              arguments: false);
                                                        },
                                                        child: SizedBox(
                                                          height: App(context)
                                                              .appHeight(6),
                                                          // width: App(context).appWidth(45),
                                                          child: const Center(
                                                            child: Text(
                                                              "Tambah Alamat (+)",
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      secondaryColor),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.pushNamed(
                                                              context,
                                                              AddressListPage
                                                                  .routeName);
                                                        },
                                                        child: SizedBox(
                                                          height: App(context)
                                                              .appHeight(6),
                                                          child: const Center(
                                                            child: Text(
                                                              "Lihat semua",
                                                              style: TextStyle(
                                                                  color:
                                                                      primaryColor,
                                                                  fontSize:
                                                                      13.0,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                  decorationThickness:
                                                                      1.5,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          // ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  ListView.builder(
                                                      padding: EdgeInsets.zero,
                                                      shrinkWrap: true,
                                                      itemCount: _data.length,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) {
                                                        return GestureDetector(
                                                            onTap: () {
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  UpdateAddressPage
                                                                      .routeName,
                                                                  arguments: UpdateAddressPageArguments(
                                                                      shippingAddress:
                                                                          _data[
                                                                              index],
                                                                      isFromList:
                                                                          false));
                                                            },
                                                            child: AddressCard(
                                                              shippingAddress:
                                                                  _data[index],
                                                            ));
                                                      }),
                                                ],
                                              );
                                          }
                                          return const SizedBox.shrink();
                                        });
                                  }),
                              largeVerticalSpacing()
                            ],
                          )
                        ],
                      ),
                    );
                }
                return const SizedBox.shrink();
              });
        });
  }
}
