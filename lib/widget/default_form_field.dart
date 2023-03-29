import 'package:flutter/material.dart';

class DefaultFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?) validate;
  final void Function()? suffixOnTap;
  final IconData prefix;
  final IconData? suffix;
  final String hint;
  final bool? obscureText;

  const DefaultFormField(
      {Key? key,
      required this.controller,
      required this.keyboardType,
      required this.validate,
      required this.prefix,
      required this.hint,
      this.suffix,
      this.suffixOnTap,
      this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validate,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          prefixIcon: Icon(prefix),
          label: Text(hint),
          suffixIcon: IconButton(
            onPressed: suffixOnTap,
            icon: Icon(suffix),
          )),
    );
  }
}
