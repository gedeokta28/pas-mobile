import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/core/utility/helper.dart';

import '../../../../core/static/assets.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: secondaryColor),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 12.0, top: 0, bottom: 0, right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Alamat 1",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "I Gede Okta Budi Mardaasda",
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "0283293293892",
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Text(
                            "Jl. sadas asdasdA asdas 9090 sadas",
                            style: TextStyle(fontSize: 13, color: Colors.black),
                          )
                        ],
                      ),
                      IconButton(
                          iconSize: 15,
                          onPressed: () {},
                          icon: Image.asset(EDIT_ICON))
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(0.0),
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(0.0)),
                ),
                width: 6,
                height: 100,
              )),
        ],
      ),
    );
  }
}
