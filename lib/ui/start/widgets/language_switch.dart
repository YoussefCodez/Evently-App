import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c17/core/resources/strings_manager.dart';
import 'package:flutter/material.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    String currentLanguage = context.locale.languageCode;
    return Row(
      children: [
        InkWell(
          onTap: () {
            context.setLocale(const Locale('en'));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: currentLanguage == "en"
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSecondaryContainer,
              border: Border.all(color: Theme.of(context).colorScheme.primary),
            ),
            child: Text(
              StringsManager.english,
              style: currentLanguage == "en"
                  ? Theme.of(context).textTheme.labelMedium
                  : Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        InkWell(
          onTap: () {
            context.setLocale(const Locale('ar'));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: currentLanguage == "ar"
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSecondaryContainer,
              border: Border.all(color: Theme.of(context).colorScheme.primary),
            ),
            child: Text(
              StringsManager.arabic,
              style: currentLanguage == "ar"
                  ? Theme.of(context).textTheme.labelMedium
                  : Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
