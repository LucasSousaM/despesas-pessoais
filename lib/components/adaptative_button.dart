import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  AdaptativeButton(
    this.label,
    this.onPressed,
  );

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            padding: EdgeInsets.symmetric(horizontal: 20),
            color: Theme.of(context).primaryColor,
            onPressed: onPressed,
            child: Text(
              label,
              style: TextStyle(color: Theme.of(context).colorScheme.surface),
            ),
          )
        : ElevatedButton(
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).colorScheme.surface,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            onPressed: onPressed,
            child: Text('Nova transação'),
          );
  }
}
