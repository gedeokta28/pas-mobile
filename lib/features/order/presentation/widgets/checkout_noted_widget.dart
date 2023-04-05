import 'package:flutter/material.dart';
import 'package:pas_mobile/core/static/colors.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pas_mobile/features/order/presentation/providers/order_provider.dart';

import 'package:provider/provider.dart';

import '../../../../core/static/dimens.dart';

class CheckoutNotedWidget extends StatelessWidget {
  const CheckoutNotedWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OrderProvider>(
        builder: (BuildContext context, provider, widget) {
      provider.noteController.clear();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Note :',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: FONT_GENERAL,
                color: Colors.black),
          ),
          const SizedBox(height: 5.0),
          Form(
            key: provider.formKey,
            child: TextFormField(
                controller: provider.noteController,
                maxLines: 1,
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(
                    fontSize: FONT_GENERAL, color: Colors.black),
                decoration: const InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    focusColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.note_alt,
                      color: secondaryColor,
                    ),
                    isCollapsed: true,
                    hintText: 'Catatan tentang pesanan Anda, diisi bila perlu',
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      borderSide: BorderSide(color: Colors.black45, width: 0.5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      borderSide: BorderSide(color: Colors.black45, width: 0.5),
                    ))),
          ),
        ],
      );
    });
  }
}
