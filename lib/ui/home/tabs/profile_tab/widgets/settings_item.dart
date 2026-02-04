import 'package:flutter/material.dart';

import '../../../../../core/resources/colors_manager.dart';

class SettingsItem extends StatelessWidget {
  String title;
  Widget action;
  void Function()? onTap;
  SettingsItem({required this.title,required this.action,this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
            border: Border.all(
              color: ColorsManager.fieldBorder,
            ),
            borderRadius: BorderRadius.circular(16),
            color: Theme.of(context).colorScheme.onSecondaryContainer
        ),
        child: Row(
          children: [
            Text(title,style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 16
            ),),
            Spacer(),
            action
          ],
        ),
      ),
    );
  }
}
