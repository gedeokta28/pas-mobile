import 'package:flutter/material.dart';
import 'package:pas_mobile/core/presentation/pages/splash_page.dart';
import 'package:pas_mobile/features/home/presentation/widgets/banner_slider.dart';
import 'package:pas_mobile/features/home/presentation/widgets/best_product.dart';
import 'package:pas_mobile/features/home/presentation/widgets/category_selection.dart';
import 'package:pas_mobile/features/home/presentation/widgets/news_product.dart';

import '../../../core/presentation/widgets/custom_dialog_logout.dart';
import '../../../core/presentation/widgets/rounded_button.dart';
import '../../../core/static/colors.dart';
import '../../../core/utility/helper.dart';
import '../../../core/utility/injection.dart';
import '../../../core/utility/session_helper.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //     body: SingleChildScrollView(
    //   child: Center(
    // child: RoundedButton(
    //   title: "Logout",
    //   color: secondaryColor,
    //   event: () async {
    //     showDialog(
    //       context: context,
    //       builder: (_) => CustomLogoutDialog(
    //         positiveAction: () async {
    //           await sessionLogOut().then((_) => Navigator.of(context)
    //               .pushNamedAndRemoveUntil(
    //                   SplashPage.routeName, (route) => false));
    //         },
    //       ),
    //     );
    //   },
    // ),
    //   ),
    // ));
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                  // Provide Your Widget here
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: RoundedButton(
              title: "Logout",
              color: secondaryColor,
              event: () async {
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
            ),
          ),
          // Positioned(
          //   bottom: 40,
          //   child: Align(
          //     alignment: Alignment.center,
          //     child: RoundedButton(
          //       title: "Logout",
          //       color: secondaryColor,
          //       event: () async {
          //         showDialog(
          //           context: context,
          //           builder: (_) => CustomLogoutDialog(
          //             positiveAction: () async {
          //               await sessionLogOut().then((_) => Navigator.of(context)
          //                   .pushNamedAndRemoveUntil(
          //                       SplashPage.routeName, (route) => false));
          //             },
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
