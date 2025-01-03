import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:pas_mobile/features/notification/presentation/activity_notif_state.dart';
import 'package:pas_mobile/features/notification/presentation/notification_provider.dart';
import 'package:provider/provider.dart';
import '../../../../core/utility/injection.dart' as di;

import '../../../core/static/app_config.dart';

class AktivitasNotifTab extends StatefulWidget {
  const AktivitasNotifTab({Key? key, required this.parentController})
      : super(key: key);

  final ScrollController parentController;

  @override
  AktivitasNotifTabState createState() => AktivitasNotifTabState();
}

class AktivitasNotifTabState extends State<AktivitasNotifTab>
    with AutomaticKeepAliveClientMixin<AktivitasNotifTab> {
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
        create: (context) =>
            di.locator<NotificationProvider>()..fetchActivityNotif(),
        builder: (context, _) {
          return Consumer<NotificationProvider>(
              builder: (context, value, child) {
            final state = value.state;
            if (state is ActivityNotifEmpty) {
              return const Center(
                  child: Text(
                'Belum Ada Pemberitahuan',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.grey),
              ));
            } else if (state is ActivityNotifSuccess) {
              var data = value.activityNotifList;
              return SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Container(
                                //     width: double.infinity,
                                //     height: App(context).appHeight(15),
                                //     decoration: BoxDecoration(
                                //       image: DecorationImage(
                                //         image: NetworkImage(
                                //           data[index].image,
                                //         ),
                                //         fit: BoxFit.fill,
                                //       ),
                                //     )),
                                AspectRatio(
                                  aspectRatio: 1080 /
                                      288, // Menjaga rasio 1080:288 (3.75)
                                  child: Container(
                                    width: double.infinity, // Lebar penuh
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          data[index].image,
                                        ),
                                        fit: BoxFit
                                            .cover, // Sesuaikan gambar agar memenuhi kontainer
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Opsional: sudut melengkung
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Text(data[index].description),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Divider(
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(
                                  height: 13.0,
                                ),
                              ],
                            ));
                      }),
                ),
              );
            }
            return Center(
              child: Image.asset(
                ASSETS_LOADING,
                height: 100.0,
                width: 100.0,
              ),
            );
          });
        });
  }
}
