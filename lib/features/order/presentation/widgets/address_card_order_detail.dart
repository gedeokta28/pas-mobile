import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/app_config.dart';
import 'package:pas_mobile/core/static/colors.dart';

class AddressCardOrderDetail extends StatelessWidget {
  final String fullName;
  final String phone;
  final String streetAddress;
  const AddressCardOrderDetail(
      {Key? key,
      required this.fullName,
      required this.phone,
      required this.streetAddress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Stack(
        children: [
          // Kontainer Utama
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: secondaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, top: 10.0, bottom: 10.0, right: 10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              fullName,
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              phone,
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.black),
                            ),
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              streetAddress,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Colors.black,
                              ),
                              softWrap: true,
                              overflow: TextOverflow.visible,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Posisi Kiri
          Positioned(
            left: 0,
            top: 0,
            bottom: 0, // Ini memastikan tinggi dinamis mengikuti parent
            child: Container(
              decoration: const BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
              ),
              width: 6, // Lebar tetap
            ),
          ),
        ],
      ),
    );
  }
}
