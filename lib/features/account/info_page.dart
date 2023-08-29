import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pas_mobile/core/presentation/widgets/custom_app_bar.dart';
import 'package:pas_mobile/core/static/dimens.dart';
import 'package:pas_mobile/core/utility/app_settings.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/account/presentation/providers/info_provider.dart';
import 'package:pas_mobile/features/account/presentation/providers/info_state.dart';
import 'package:provider/provider.dart';

class InfoPage extends StatefulWidget {
  static const String routeName = "InfoPage";
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<InfoProvider>(builder: (context, aboutus, child) {
      return Scaffold(
          appBar: const CustomAppBar(
            centerTitle: true,
            canBack: false,
            title: APP_NAME,
            hideShadow: false,
          ),
          body: StreamBuilder<InfoState>(
              stream: context.read<InfoProvider>().getAbout(),
              builder: (context, state) {
                switch (state.data.runtimeType) {
                  case InfoLoading:
                    return const Center(child: CircularProgressIndicator());
                  case InfoFailure:
                    return const SizedBox.shrink();
                  case InfoLoaded:
                    final data = (state.data as InfoLoaded).data;
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(SIZE_MEDIUM),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Html(data: removeHtmlTage(data.value)),
                            mediumVerticalSpacing(),
                          ],
                        ),
                      ),
                    );
                }
                return const SizedBox.shrink();
              }));
    });
  }
}
