import 'package:flutter/material.dart';
import 'package:pas_mobile/features/notification/presentation/aktivitas_notif_tab_view.dart';
import 'package:pas_mobile/features/notification/presentation/transaksi_notif_tab_view.dart';

import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/static/app_config.dart';
import '../../../core/static/colors.dart';
import '../../../core/utility/injection.dart';
import '../../../core/utility/session_helper.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);
  static const routeName = '/notification';

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with SingleTickerProviderStateMixin {
  var scrollController = ScrollController();
  late Widget _tabBarView;
  final session = locator<Session>();

  @override
  void initState() {
    super.initState();

    _tabBarView = TabBarView(children: [
      AktivitasNotifTab(parentController: scrollController),
      TransaksiNotifTab(parentController: scrollController),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: "Notification",
        centerTitle: true,
        canBack: true,
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
                                        'Aktivitas',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Tab(
                                      child: Text(
                                        'Transaksi',
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
        ],
      ),
    );
  }
}
