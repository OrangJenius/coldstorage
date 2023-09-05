import 'package:flutter/material.dart';

class CustomVerticalStepper extends StatelessWidget {
  final List<Widget> steps;

  CustomVerticalStepper({required this.steps});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: steps,
    );
  }
}
