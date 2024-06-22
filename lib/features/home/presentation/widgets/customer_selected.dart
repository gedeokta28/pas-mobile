import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/home/presentation/customer_list_page.dart';
import 'package:pas_mobile/features/home/presentation/providers/customer_list_state.dart';
import '../../../../core/utility/injection.dart';
import '../../../../core/utility/session_helper.dart';
import '../providers/home_provider.dart';
import 'package:provider/provider.dart';

class CustomerSelected extends StatefulWidget {
  const CustomerSelected({Key? key}) : super(key: key);

  @override
  State<CustomerSelected> createState() => _CustomerSelectedState();
}

class _CustomerSelectedState extends State<CustomerSelected> {
  @override
  Widget build(BuildContext context) {
    if (locator<Session>().isLoggedIn) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          StreamBuilder<CustomerListState>(
              stream: context.read<HomeProvider>().fetchCustomerList(),
              builder: (_, snap) {
                if (snap.hasData) {
                  if (snap.data is CustomerListLoaded) {
                    final _customer = (snap.data as CustomerListLoaded).data;
                    logMe(
                        'locator<Session>().salesId ${locator<Session>().salesId}');
                    if (locator<Session>().isAllCustomer) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                              top: 10,
                              right: 20,
                            ),
                            child: Text(
                              'Customer :',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, CustomerListPage.routeName,
                                  arguments: _customer);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 5, right: 20, bottom: 5),
                              child: Row(
                                children: [
                                  Container(
                                    height: 35,
                                    width: 35,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(0),
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                        color: Colors.white),
                                    child: const Center(
                                      child: Icon(
                                        Icons.person,
                                        size: 22,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
                                      border: const Border(
                                        bottom: BorderSide(color: Colors.grey),
                                        top: BorderSide(color: Colors.grey),
                                        right: BorderSide(color: Colors.grey),
                                        left: BorderSide(
                                            width: 0, color: Colors.grey),
                                      ),
                                    ),
                                    height: 35,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        right: 15.0,
                                        left: 15.0,
                                      ),
                                      child: Center(
                                        child: Text(
                                          locator<Session>()
                                                      .sessionCustomerId ==
                                                  ''
                                              ? 'Pilih Customer'
                                              : "${locator<Session>().sessionCustomerId} (${locator<Session>().sessionCustomerName})",
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 10, right: 20, bottom: 5),
                        child: Row(
                          children: [
                            Container(
                              height: 35,
                              width: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(0),
                                  border: Border.all(
                                    color: Colors.grey,
                                  ),
                                  color: Colors.white),
                              child: const Center(
                                child: Icon(
                                  Icons.person,
                                  size: 22,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                                border: const Border(
                                  bottom: BorderSide(color: Colors.grey),
                                  top: BorderSide(color: Colors.grey),
                                  right: BorderSide(color: Colors.grey),
                                  left:
                                      BorderSide(width: 0, color: Colors.grey),
                                ),
                              ),
                              height: 35,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 15.0,
                                  left: 15.0,
                                ),
                                child: Center(
                                  child: Text(
                                    "${locator<Session>().sessionCustomerId} (${locator<Session>().sessionCustomerName})",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  } else {
                    return const SizedBox.shrink();
                  }
                }
                return const SizedBox.shrink();
              }),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
