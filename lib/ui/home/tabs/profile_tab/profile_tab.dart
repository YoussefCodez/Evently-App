import 'package:easy_localization/easy_localization.dart';
import 'package:evently_c17/core/providers/theme_provider.dart';
import 'package:evently_c17/core/providers/user_provider.dart';
import 'package:evently_c17/core/remote/local/prefs_helper.dart';
import 'package:evently_c17/core/resources/assets_manager.dart';
import 'package:evently_c17/core/resources/strings_manager.dart';
import 'package:evently_c17/ui/home/tabs/profile_tab/widgets/settings_item.dart';
import 'package:evently_c17/ui/signin/screen/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 58,
              backgroundImage: AssetImage(AssetsManager.route),
            ),
            SizedBox(height: 16),
            Text(
              userProvider.user?.name ?? "User",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              userProvider.user?.email ?? "",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 32),
            SettingsItem(
              title: StringsManager.darkMode,
              action: CupertinoSwitch(
                value: themeProvider.themeMode == ThemeMode.dark,
                activeTrackColor: Theme.of(context).colorScheme.primary,
                onChanged: (value) {
                  ThemeMode newMode = value ? ThemeMode.dark : ThemeMode.light;
                  themeProvider.toggleTheme(newMode);
                  PrefsHelper.saveThemeMode(newMode);
                },
              ),
            ),
            SizedBox(height: 16),
            SettingsItem(
              title: StringsManager.language,
              action: CupertinoSwitch(
                value: context.locale.languageCode == 'ar',
                activeTrackColor: Theme.of(context).colorScheme.primary,
                onChanged: (value) {
                  if (value) {
                    context.setLocale(const Locale('ar'));
                  } else {
                    context.setLocale(const Locale('en'));
                  }
                },
              ),
            ),
            SizedBox(height: 16),
            SettingsItem(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, SigninScreen.routeName);
              },
              title: StringsManager.logout,
              action: SvgPicture.asset(AssetsManager.logout),
            ),
          ],
        ),
      ),
    );
  }
}
