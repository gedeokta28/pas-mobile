import 'package:flutter/material.dart';
import 'package:pas_mobile/core/presentation/pages/main_page/main_provider.dart';
import 'package:provider/provider.dart';

import '../../../static/colors.dart';
import 'main_static.dart';

class MainPage extends StatefulWidget {
  final int? index;
  const MainPage({Key? key, this.index}) : super(key: key);
  static const routeName = '/main';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _initialSelectedIndex;

  @override
  void initState() {
    super.initState();
    _initialSelectedIndex = widget.index ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainProvider()..setTappedIndex = _initialSelectedIndex,
      builder: (context, child) => Consumer<MainProvider>(
        builder: (context, provider, _) => Scaffold(
          body: content[provider.tappedIndex].content,
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 12,
            showUnselectedLabels: true,
            unselectedItemColor: BOTTOM_NAVBAR_UNSELECTED,
            selectedItemColor: BOTTOM_NAVBAR_SELECTED,
            onTap: (value) {
              // check is logged in
              provider.setTappedIndex = value;
            },
            currentIndex: provider.tappedIndex,
            backgroundColor: BOTTOM_NAVBAR_BACKGROUND,
            selectedLabelStyle: const TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.normal,
                color: secondaryColor),
            unselectedLabelStyle: const TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.normal,
                color: Colors.blue),
            items: content
                .map(
                  (e) => BottomNavigationBarItem(
                    label: e.title,
                    icon: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset(
                        e.icon,
                        color: Colors.black,
                        width: 20,
                        height: 20,
                      ),
                    ),
                    activeIcon: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Image.asset(
                        e.icon,
                        color: secondaryColor,
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
