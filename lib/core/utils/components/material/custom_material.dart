import 'package:flutter/material.dart';

class CustomMaterial extends StatelessWidget {
  final Widget child;
  const CustomMaterial({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Material(color: Colors.white, child: child);
  }
}
