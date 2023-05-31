import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;

  const CustomContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.lightBlue.shade50,
            borderRadius: BorderRadius.circular(15)),
        child: child);
  }
}
