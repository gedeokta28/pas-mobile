import 'package:flutter/material.dart';
import 'package:pas_mobile/features/notification/presentation/notification_provider.dart';
import 'package:pas_mobile/features/notification/presentation/widgets/transaksi_notif_widget.dart';
import 'package:provider/provider.dart';
import '../../../../core/utility/injection.dart' as di;

import '../../../core/static/app_config.dart';

class TransaksiNotifTab extends StatefulWidget {
  const TransaksiNotifTab({Key? key, required this.parentController})
      : super(key: key);

  final ScrollController parentController;

  @override
  TransaksiNotifTabState createState() => TransaksiNotifTabState();
}

class TransaksiNotifTabState extends State<TransaksiNotifTab>
    with AutomaticKeepAliveClientMixin<TransaksiNotifTab> {
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
                      child: TransaksiNotifWidget());
                }),
          );
        });
  }
}