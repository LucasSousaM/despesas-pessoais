import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final String label;
  final Function(String) onSubmitted;
  final TextEditingController controller;
  final TextInputType keyboardType;

  AdaptativeTextField({
    required this.label,
    required this.controller,
    required this.onSubmitted,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            controller: controller,
            keyboardType: keyboardType,
            onSubmitted: onSubmitted,
            placeholder: label,
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 12),
          )
        : Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
                labelText: label,
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).colorScheme.primary),
                ),
              ),
              keyboardType: keyboardType,
              onSubmitted: onSubmitted,
            ),
          );
  }
}
