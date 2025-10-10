import 'package:flutter/material.dart';

class CustomSearchbar extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final void Function(String)? onSubmit;
  const CustomSearchbar({
    super.key,
    this.hintText = "Search...",
    required this.controller,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: TextFormField(
        controller: controller,
        onFieldSubmitted: onSubmit,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          hintText: hintText,
          hintStyle: const TextStyle(fontWeight: FontWeight.w200),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}
