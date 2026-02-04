import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.text, required this.onTap});
  final String text;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          decoration: .underline,
          decorationColor: Theme.of(context).colorScheme.primary,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
