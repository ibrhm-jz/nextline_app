import 'package:flutter/material.dart';

class DefaultPrefixField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool? obscure;
  final bool? enabled;
  final FormFieldValidator<String>? validator;
  final IconData icon;
  final int maxLines;

  const DefaultPrefixField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.obscure = false,
    this.enabled = true,
    this.validator,
    this.maxLines = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        focusColor: Colors.grey,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo),
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
        hintText: hintText,
        prefixIcon: Icon(icon),
      ),
    );
  }
}
