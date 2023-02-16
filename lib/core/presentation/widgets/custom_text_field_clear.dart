import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../static/colors.dart';
import '../../static/dimens.dart';

class CustomClearTextField extends StatefulWidget {
  final String? title;
  final String placeholder;
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

  const CustomClearTextField(
      {Key? key,
      this.placeholder = '',
      this.title,
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
  State<CustomClearTextField> createState() => _CustomClearTextFieldState();
}

class _CustomClearTextFieldState extends State<CustomClearTextField> {
  late OutlineInputBorder normalBorder;

  late OutlineInputBorder errorBorder;

  late OutlineInputBorder roundErrorBorder;

  late OutlineInputBorder roundBorder;

  @override
  void initState() {
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
                    fontSize: FONT_GENERAL,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              )
            : const SizedBox.shrink(),
        const SizedBox(height: 4.0),

        // Input field section
        TextFormField(
          maxLines: widget.maxLine,
          inputFormatters: widget.inputFormatters,
          enabled: widget.enabled,
          onTap: () {
            if (widget.refresh) {
              widget.onTap!();
            }
          },
          onChanged: (str) {
            if (widget.onChanged != null) widget.onChanged!();
          },
          controller: widget.controller,
          keyboardType: widget.inputType,
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
              suffixIcon: Material(
                color: Colors.transparent,
                child: IconButton(
                    splashRadius: 20.0,
                    onPressed: () {
                      widget.controller.clear();
                    },
                    icon: Icon(Icons.close_rounded)),
              )),
          validator: widget.fieldValidator,
        ),
      ],
    );
  }
}
