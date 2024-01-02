import 'package:flutter/material.dart';

class RoundedContainerScreen extends StatelessWidget {
  const RoundedContainerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
          bottomLeft: Radius.circular(50), // Adjust the value for the left-bottom corner radius
          bottomRight: Radius.circular(0),
        ),
      ),
      // Your content goes here
    );
  }
}
