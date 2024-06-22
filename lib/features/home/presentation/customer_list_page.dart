import 'package:flutter/material.dart';
import 'package:pas_mobile/core/presentation/pages/main_page/main_page.dart';
import 'package:pas_mobile/core/presentation/widgets/custom_app_bar.dart';
import 'package:pas_mobile/core/presentation/widgets/custom_search_bar.dart';
import 'package:pas_mobile/core/utility/injection.dart';
import 'package:pas_mobile/core/utility/session_helper.dart';
import 'package:pas_mobile/features/home/data/models/customer_list_response_mode.dart';

class CustomerListPage extends StatefulWidget {
  final List<CustomerData> customerData;

  static const routeName = '/search_location';
  const CustomerListPage({Key? key, required this.customerData})
      : super(key: key);

  @override
  State<CustomerListPage> createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  List<CustomerData> _customerList = [];
  List<CustomerData> _foundCustomer = [];
  @override
  initState() {
    _customerList = widget.customerData;
    _foundCustomer = _customerList;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<CustomerData> results = [];
    if (enteredKeyword.isEmpty) {
      results = _customerList;
    } else {
      results = _customerList
          .where((data) => data.customername
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundCustomer = results;
    });
  }

  // final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Pilih Customer',
        canBack: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            CustomSearchBar(
              hint: 'Cari customer..',
              enabled: true,
              onChanged: (value) => _runFilter(value),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundCustomer.isNotEmpty
                  ? ListView.separated(
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                      itemCount: _foundCustomer.length,
                      itemBuilder: (context, index) => InkWell(
                        key: ValueKey(_foundCustomer[index].customerid),
                        onTap: () {
                          locator<Session>().setCustomerId =
                              _foundCustomer[index].customerid;
                          locator<Session>().setCustomerName =
                              _foundCustomer[index].customername;
                          Navigator.pushReplacementNamed(
                              locator<GlobalKey<NavigatorState>>()
                                  .currentContext!,
                              MainPage.routeName);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.person,
                                color: Colors.grey,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                _foundCustomer[index].customername,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const Text(
                      'Customer Tidak Ditemukan',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
