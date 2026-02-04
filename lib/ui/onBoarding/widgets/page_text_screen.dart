import 'package:evently_c17/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';

class PageTextScreen extends StatelessWidget {
  PageTextScreen({super.key, required this.title, required this.text});
  String title, text;
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: .w600,
            fontSize: 20,
            color: color.secondary,
          ),
        ),
        SizedBox(height: 8),
        Text(
          text,
          style: TextStyle(
            fontWeight: .w400,
            fontSize: 16,
            color: color.tertiary,
          ),
        ),
      ],
    );
  }
}
