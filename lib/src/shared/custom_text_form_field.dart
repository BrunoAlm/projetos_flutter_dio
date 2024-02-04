import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final InputBorder? inputBorder;
  final InputDecoration? inputDecoration;
  final String? label;
  final int? maxLenght;
  final Function(String)? onChanged;

  const CustomTextField({
    super.key,
    required this.controller,
    this.label,
    this.onChanged,
    this.maxLenght,
    this.inputBorder,
    this.inputDecoration,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      maxLength: maxLenght,
      decoration: inputDecoration ??
          InputDecoration(
            label: Text(
              label ?? '',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            enabledBorder: inputBorder ?? const OutlineInputBorder(),
            focusedBorder: inputBorder ?? const OutlineInputBorder(),
          ),
    );
  }
}
