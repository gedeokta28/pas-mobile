import 'package:flutter/material.dart';
import 'package:pas_mobile/core/presentation/pages/splash_page.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/features/account/presentation/profile_tab_vew.dart';

import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/custom_dialog_logout.dart';
import '../../../core/static/app_config.dart';
import '../../../core/static/colors.dart';
import '../../../core/utility/helper.dart';
import '../../../core/utility/injection.dart';
import '../../../core/utility/session_helper.dart';
import 'order_tab_vew.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with SingleTickerProviderStateMixin {
  var scrollController = ScrollController();
  late Widget _tabBarView;
  final session = locator<Session>();

  @override
  void initState() {
    super.initState();

    _tabBarView = TabBarView(children: [
      ProfileAccountTab(parentController: scrollController),
      OrderProfileTab(parentController: scrollController),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Kelola Akun",
        centerTitle: true,
        canBack: false,
        hideShadow: false,
      ),
      body: Stack(
        children: [
          NestedScrollView(
              controller: scrollController,
              physics: const ScrollPhysics(parent: PageScrollPhysics()),
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(
                        height: App(context).appHeight(0),
                      ),
                    ]),
                  ),
                ];
              },
              body: Padding(
                padding: const EdgeInsets.all(15),
                child: DefaultTabController(
                  initialIndex: session.indexTab,
                  length: 2,
                  child: Builder(builder: (BuildContext context) {
                    final TabController controller =
                        DefaultTabController.of(context);
                    controller.addListener(() {
                      if (!controller.indexIsChanging) {
                        session.setIndexTab = controller.index;
                      }
                    });
                    return Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, left: 20, right: 20, bottom: 10),
                          child: Container(
                            height: 50,
                            decoration: const BoxDecoration(
                              color: greyColorTrans,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22.0)),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: TabBar(
                                  indicator: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                  ),
                                  labelColor: secondaryColor,
                                  unselectedLabelColor: Colors.black,
                                  tabs: [
                                    Tab(
                                      child: Text(
                                        'Profile',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        'Order',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(child: _tabBarView),
                        ),
                      ],
                    );
                  }),
                ),
              )),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (_) => CustomLogoutDialog(
                    positiveAction: () async {
                      await sessionLogOut().then((_) => Navigator.of(context)
                          .pushNamedAndRemoveUntil(
                              SplashPage.routeName, (route) => false));
                    },
                  ),
                );
              },
              child: Container(
                height: App(context).appHeight(6),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 5.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        iconSize: 15,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => CustomLogoutDialog(
                              positiveAction: () async {
                                await sessionLogOut().then((_) =>
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            SplashPage.routeName,
                                            (route) => false));
                              },
                            ),
                          );
                        },
                        icon: Image.asset(LOGOUT_ICON)),
                    const Text(
                      "Logout",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: secondaryColor),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
