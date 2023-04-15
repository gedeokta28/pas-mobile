import 'package:flutter/material.dart';
import '../../../core/presentation/widgets/custom_app_bar.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({
    Key? key,
  }) : super(key: key);
  static const routeName = '/notification';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Notification",
        centerTitle: true,
        canBack: true,
        hideShadow: false,
      ),
      body: SafeArea(
          child: Center(
        child: Text(
          "SOON",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      )),
    );
  }
}
