import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pas_mobile/core/utility/helper.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

import '../../static/colors.dart';
import '../../static/dimens.dart';
import 'dart:math' as math;

class CustomPriceField extends StatefulWidget {
  final String? title;
  final String placeholder;
  final bool isSecure;
  final bool isError;
  final TextEditingController controller;
  final FormFieldValidator? fieldValidator;
  final TextInputType inputType;
  final bool refresh;
  final Function? onTap;
  final String? suffixText;
  final Widget? suffixWidget;
  final bool border;
  final Function? onChanged;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final bool enablePadding;
  final bool isRounded;
  final EdgeInsets padding;
  final int maxLine;
  final Color backgroundColor;

  const CustomPriceField(
      {Key? key,
      this.placeholder = '',
      this.title,
      this.isSecure = false,
      this.isError = false,
      required this.controller,
      required this.fieldValidator,
      this.inputType = TextInputType.text,
      this.refresh = false,
      this.onTap,
      this.suffixText,
      this.border = false,
      this.onChanged,
      this.enabled = true,
      this.inputFormatters,
      this.enablePadding = false,
      this.isRounded = false,
      this.maxLine = 1,
      this.backgroundColor = SHADOW,
      this.padding = const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      this.suffixWidget})
      : super(key: key);

  @override
  State<CustomPriceField> createState() => _CustomPriceFieldState();
}

class _CustomPriceFieldState extends State<CustomPriceField> {
  late bool _passwordVisible;
  bool isFirst = true;
  late OutlineInputBorder normalBorder;

  late OutlineInputBorder errorBorder;

  late OutlineInputBorder roundErrorBorder;

  late OutlineInputBorder roundBorder;
  String _formatNumber(String s) =>
      NumberFormat('#,##0', 'ID').format(int.parse(s));

  @override
  void initState() {
    _passwordVisible = widget.isSecure;
    normalBorder = OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(5.0),
      ),
      borderSide: BorderSide(
        color: widget.border ? Colors.grey : Colors.white,
      ),
    );
    errorBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(5.0),
      ),
      borderSide: BorderSide(
        color: ERROR_RED_COLOR,
      ),
    );
    roundBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
      borderSide: BorderSide(style: BorderStyle.none),
    );
    roundErrorBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(30.0),
      ),
      borderSide: BorderSide(
        color: ERROR_RED_COLOR,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title section
        widget.title != null
            ? Text(
                widget.title ?? "",
                style: const TextStyle(
                    fontSize: FONT_MEDIUM,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )
            : const SizedBox.shrink(),
        const SizedBox(height: 4.0),

        // Input field section
        TextFormField(
          maxLines: widget.maxLine,
          keyboardType: TextInputType.number,
          inputFormatters: [
            LengthLimitingTextInputFormatter(15),
            ThousandsFormatter(allowFraction: false),
          ],
          enabled: widget.enabled,
          onTap: () {
            if (widget.refresh) {
              widget.onTap!();
            }
          },
          // onChanged: (str) {
          //   if (widget.onChanged != null) widget.onChanged!();
          // },
          controller: widget.controller,
          // keyboardType: TextInputType.numberWithOptions(decimal: true),
          style: const TextStyle(fontSize: 15, color: Colors.black),
          decoration: InputDecoration(
              focusColor: Colors.white,
              hintText: widget.placeholder,
              border: InputBorder.none,
              enabledBorder: widget.isRounded ? roundBorder : normalBorder,
              disabledBorder: widget.isRounded ? roundBorder : normalBorder,
              focusedBorder: widget.isRounded ? roundBorder : normalBorder,
              errorBorder: widget.isRounded ? roundErrorBorder : errorBorder,
              focusedErrorBorder:
                  widget.isRounded ? roundErrorBorder : errorBorder,
              filled: true,
              fillColor: widget.isError ? Colors.white : widget.backgroundColor,
              contentPadding: widget.padding,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Material(
                  color: Colors.grey[300],
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 14.0),
                        child: Text(
                          "Rp",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
          validator: widget.fieldValidator,
        ),
      ],
    );
  }
}

class CustomTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.extentOffset;
      List<String> chars = newValue.text.replaceAll(' ', '').split('');
      String newString = '';
      for (int i = 0; i < chars.length; i++) {
        if (i % 3 == 0 && i != 0) newString += ' ';
        newString += chars[i];
      }

      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndexFromTheRight,
        ),
      );
    } else {
      return newValue;
    }
  }
}
