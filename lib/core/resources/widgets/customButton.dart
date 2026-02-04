import 'package:evently_c17/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  const Custombutton({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 9),
      margin: EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: ColorsManager.onPrimaryColor,
          fontSize: 20,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
