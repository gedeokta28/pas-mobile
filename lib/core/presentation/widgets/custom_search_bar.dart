import 'package:flutter/material.dart';
import 'package:pas_mobile/core/presentation/widgets/rounded_container.dart';

class CustomSearchBar extends StatelessWidget {
  final bool isFromHome;
  final TextEditingController? controller;
  final Function(bool focus)? onFocus;
  final Function(String value)? onChanged;
  final void Function(String)? onSubmitted;
  final FocusNode? focusNode;
  final VoidCallback? onSearch;
  final bool enabled;
  final double height;
  final String? hint;
  const CustomSearchBar(
      {Key? key,
      this.controller,
      this.isFromHome = false,
      this.onSearch,
      this.enabled = true,
      this.height = 48.0,
      this.onFocus,
      this.focusNode,
      this.hint,
      this.onSubmitted,
      this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      height: height,
      color: Colors.grey[200]!,
      child: Focus(
        onFocusChange: isFromHome ? null : onFocus,
        child: TextField(
          enabled: isFromHome ? false : enabled,
          focusNode: focusNode,
          onSubmitted: onSubmitted,
          controller: controller,
          textInputAction: TextInputAction.search,
          onEditingComplete: onSearch,
          style: const TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          textAlignVertical: TextAlignVertical.center,
          onChanged: onChanged,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(0.0),
            border: InputBorder.none,
            isDense: true,
            prefixIcon: Icon(
              Icons.search_rounded,
              size: height / 1.5,
            ),
            prefixIconColor: Colors.grey,
            hintText: hint ?? "Search",
            hintStyle: const TextStyle(fontSize: 14.0),
          ),
        ),
      ),
    );
  }
}
