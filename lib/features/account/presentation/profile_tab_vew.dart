import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/account/presentation/change_email_page.dart';
import 'package:pas_mobile/features/account/presentation/change_password_page.dart';
import 'package:pas_mobile/features/account/presentation/change_personal_info_page.dart';
import 'package:pas_mobile/features/account/presentation/widgets/address_card.dart';

import '../../../core/static/app_config.dart';
import '../../../core/static/assets.dart';
import 'change_username_page.dart';

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
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          const Divider(),
          smallVerticalSpacing(),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Akun Detail",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    "ID #12312312312",
                    style: TextStyle(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: App(context).appWidth(15),
                      child: const Text(
                        "Username",
                        style: TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, ChangeUsernamePage.routeName);
                      },
                      child: SizedBox(
                        width: App(context).appWidth(50),
                        child: Text(
                          "gede oktagede oktagede okta",
                          maxLines: 1,
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                      ),
                    ),
                    IconButton(
                        iconSize: 15,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, ChangeUsernamePage.routeName);
                        },
                        icon: Icon(Icons.arrow_forward_ios_rounded))
                  ],
                ),
              ),
              SizedBox(
                height: App(context).appHeight(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: App(context).appWidth(15),
                      child: const Text(
                        "Email",
                        style: TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ChangeEmailPage.routeName);
                      },
                      child: SizedBox(
                        width: App(context).appWidth(50),
                        child: Text(
                          "gedeokta28@gmail.com",
                          maxLines: 1,
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                      ),
                    ),
                    IconButton(
                        iconSize: 15,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, ChangeEmailPage.routeName);
                        },
                        icon: Icon(Icons.arrow_forward_ios_rounded))
                  ],
                ),
              ),
              SizedBox(
                height: App(context).appHeight(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: App(context).appWidth(15),
                      child: const Text(
                        "Password",
                        style: TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, ChangePasswordPage.routeName);
                      },
                      child: SizedBox(
                        width: App(context).appWidth(50),
                        child: Text(
                          "********",
                          style: TextStyle(fontSize: 13, color: Colors.black),
                        ),
                      ),
                    ),
                    IconButton(
                        iconSize: 15,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, ChangePasswordPage.routeName);
                        },
                        icon: Icon(Icons.arrow_forward_ios_rounded))
                  ],
                ),
              ),
              smallVerticalSpacing(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Info Pribadi",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  IconButton(
                      iconSize: 15,
                      onPressed: () {
                        Navigator.pushNamed(
                            context, ChangePersonalInfoPage.routeName);
                      },
                      icon: Image.asset(EDIT_ICON))
                ],
              ),
              SizedBox(
                height: App(context).appHeight(6),
                width: App(context).appWidth(45),
                child: const Center(
                  child: Text(
                    "Tambah Alamat (+)",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: secondaryColor),
                  ),
                ),
              ),
              smallVerticalSpacing(),
              ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: 5,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return AddressCard();
                  }),
              largeVerticalSpacing()
            ],
          )
        ],
      ),
    );
  }
}
