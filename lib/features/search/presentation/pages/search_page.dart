import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/presentation/widgets/search_app_bar.dart';
import '../../../../core/utility/injection.dart';
import '../providers/search_provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);
  static const routeName = '/search';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => locator<SearchProvider>()..focus(),
      builder: (context, child) => Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size(double.infinity, kToolbarHeight),
          child: SearchAppBar(),
        ),
        body: SafeArea(
            child: Consumer<SearchProvider>(builder: (context, provider, _) {
          if (provider.isSearch) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey[400],
                ),
                itemCount: provider.listProductResult.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(provider.listProductResult[index]),
                ),
              ),
            );
          }
          return const SizedBox();
        })),
      ),
    );
  }
}
