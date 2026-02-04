import 'package:evently_c17/core/providers/theme_provider.dart';
import 'package:evently_c17/core/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatelessWidget {
  String theme;
  ThemeSwitch(this.theme);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return Row(
      children: [
        GestureDetector(
          onTap: (){
            themeProvider.toggleTheme(ThemeMode.light);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 5
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color:theme=="light"
                    ?Theme.of(context).colorScheme.primary
                    :Theme.of(context).colorScheme.onSecondaryContainer,
                border: Border.all(
                    color: Theme.of(context).colorScheme.primary
                )
            ),
            child: SvgPicture.asset(
              AssetsManager.sun,
              colorFilter: ColorFilter.mode(
                    theme=="light"
                        ?Colors.white
                        :Theme.of(context).colorScheme.onPrimaryContainer,
                    BlendMode.srcIn),
            ),
          ),
        ),
        SizedBox(width: 8,),
        GestureDetector(
          onTap: (){
            themeProvider.toggleTheme(ThemeMode.dark);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 5
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color:theme=="dark"
                    ?Theme.of(context).colorScheme.primary
                    :Theme.of(context).colorScheme.onSecondaryContainer,
                border: Border.all(
                    color: Theme.of(context).colorScheme.primary
                )
            ),
            child:SvgPicture.asset(
              AssetsManager.moon,
              colorFilter: ColorFilter.mode(
                  theme=="dark"
                      ?Colors.white
                      :Theme.of(context).colorScheme.onPrimaryContainer,
                  BlendMode.srcIn),
            ) ,
          ),
        ),
      ],
    );
  }
}
