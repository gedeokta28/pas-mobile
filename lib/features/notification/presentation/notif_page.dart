import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/assets.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/pages/main_page/main_page.dart';
import '../../../core/presentation/widgets/custom_app_bar.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/static/dimens.dart';
import '../../../core/utility/helper.dart';
import '../../../core/utility/injection.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({
    Key? key,
  }) : super(key: key);
  static const routeName = '/notification';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Notification",
        centerTitle: true,
        canBack: true,
        hideShadow: false,
      ),
      body: SafeArea(
          child: Center(
        child: const Text(
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
