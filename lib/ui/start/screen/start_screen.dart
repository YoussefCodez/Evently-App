import 'package:evently_c17/core/providers/theme_provider.dart';
import 'package:evently_c17/core/resources/assets_manager.dart';
import 'package:evently_c17/core/resources/strings_manager.dart';
import 'package:evently_c17/core/reusable/custom_button_reusable.dart';
import 'package:evently_c17/ui/signin/screen/signin_screen.dart';
import 'package:evently_c17/ui/start/widgets/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/language_switch.dart';

class StartScreen extends StatelessWidget {
  static const String routeName = "start";
  const StartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AssetsManager.logo,
          height: 27,
          fit: BoxFit.fitHeight,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              AssetsManager.beingCreative,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
            SizedBox(height: 24),
            Text(
              StringsManager.startTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 8),
            Text(
              StringsManager.startDesc,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringsManager.language,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const LanguageSwitch(),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringsManager.theme,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                ThemeSwitch(
                  themeProvider.themeMode == ThemeMode.light ? "light" : "dark",
                ),
              ],
            ),
            Spacer(),
            Container(
              width: double.infinity,
              child: CustomButton(
                title: StringsManager.letsStart,
                onClick: () {
                  Navigator.pushReplacementNamed(
                    context,
                    SigninScreen.routeName,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
