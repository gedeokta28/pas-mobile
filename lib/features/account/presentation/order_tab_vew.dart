import 'package:flutter/material.dart';

class OrderProfileTab extends StatefulWidget {
  const OrderProfileTab({Key? key, required this.parentController})
      : super(key: key);

  final ScrollController parentController;

  @override
  OrderProfileTabState createState() => OrderProfileTabState();
}

class OrderProfileTabState extends State<OrderProfileTab>
    with AutomaticKeepAliveClientMixin<OrderProfileTab> {
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
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Text("Profile")
      ],
    );
  }
}
