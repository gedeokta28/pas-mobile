import 'package:flutter/material.dart';
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
        create: (context) => di.locator<NotificationProvider>(),
        builder: (context, _) {
          return Padding(
            padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 3,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Container(
                            width: double.infinity,
                            height: App(context).appHeight(15),
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  'https://img.freepik.com/free-vector/modern-sale-banner-with-text-space-area_1017-27331.jpg?w=2000',
                                ),
                                fit: BoxFit.fill,
                              ),
                            )),
                      ));
                }),
          );
        });
  }
}
