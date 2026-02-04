import 'package:evently_c17/core/providers/user_provider.dart';
import 'package:evently_c17/core/resources/assets_manager.dart';
import 'package:evently_c17/core/resources/strings_manager.dart';
import 'package:evently_c17/ui/add_event/screen/add_event_screen.dart';
import 'package:evently_c17/ui/home/tabs/favorite_tab/favorite_tab.dart';
import 'package:evently_c17/ui/home/tabs/home_tab/home_tab.dart';
import 'package:evently_c17/ui/home/tabs/profile_tab/profile_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).getUser();
  }

  int selectedIndex = 0;
  List<Widget> tabs = [HomeTab(), FavoriteTab(), ProfileTab()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset(AssetsManager.home),
            label: StringsManager.home,
            selectedIcon: SvgPicture.asset(AssetsManager.home_selected),
          ),
          NavigationDestination(
            icon: SvgPicture.asset(AssetsManager.heart),
            label: StringsManager.favorite,
            selectedIcon: SvgPicture.asset(AssetsManager.heart_selected),
          ),
          NavigationDestination(
            icon: SvgPicture.asset(AssetsManager.profile),
            label: StringsManager.profile,
            selectedIcon: SvgPicture.asset(AssetsManager.profile_selected),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddEventScreen.routeName);
        },
        child: SvgPicture.asset(AssetsManager.add),
      ),
      body: tabs[selectedIndex],
    );
  }
}
