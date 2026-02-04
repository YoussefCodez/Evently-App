import 'package:evently_c17/core/resources/assets_manager.dart';
import 'package:evently_c17/core/resources/colors_manager.dart';
import 'package:evently_c17/core/resources/strings_manager.dart';
import 'package:evently_c17/core/resources/widgets/custom_button.dart';
import 'package:evently_c17/ui/onBoarding/widgets/page_svg_screen.dart';
import 'package:evently_c17/ui/onBoarding/widgets/page_text_screen.dart';
import 'package:evently_c17/ui/signin/screen/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class OnBoardingScreen extends StatefulWidget {
  static const String routeName = "onBoarding";
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controllerSvg = .new();
  final PageController _controllerText = .new();

  int index = 0;

  void nextPage() {
    index++;
    _controllerSvg.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _controllerText.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {});
  }

  void previousPage() {
    index--;
    _controllerSvg.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    _controllerText.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _controllerSvg.dispose();
    _controllerText.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        leading: index == 0
            ? null
            : IconButton(
          splashColor: Colors.transparent,
          onPressed: () {
            previousPage();
          },
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.onSurface,
              border: Border.all(color: color.surface),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: color.primary,
              size: 20,
            ),
          ),
        ),
        title: Image.asset(
          AssetsManager.logo,
          width: size.width * 0.4,
          height: size.height * 0.06,
          color: color.primary,
        ),
        centerTitle: true,
        actions: [
          if (index != 2)
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, SigninScreen.routeName);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: color.onSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: color.surface),
                ),
                child: Text(
                  StringsManager.onBoardSkip,
                  style: TextStyle(
                    color: color.primary,
                    fontSize: size.width * 0.04,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              flex: 4,
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _controllerSvg,
                children: [
                  PageSvgScreen(svg: AssetsManager.onBoardSvg1, size: 0.66),
                  PageSvgScreen(svg: AssetsManager.onBoardSvg2),
                  PageSvgScreen(svg: AssetsManager.onBoardSvg3),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: .center,
              children: [
                Dot(active: index == 0),
                SizedBox(width: 6),
                Dot(active: index == 1),
                SizedBox(width: 6),
                Dot(active: index == 2),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              flex: 3,
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _controllerText,
                children: [
                  PageTextScreen(
                    title: StringsManager.onBoard1Title,
                    text: StringsManager.onBoard1Desc,
                  ),
                  PageTextScreen(
                    title: StringsManager.onBoard2Title,
                    text: StringsManager.onBoard2Desc,
                  ),
                  PageTextScreen(
                    title: StringsManager.onBoard3Title,
                    text: StringsManager.onBoard3Desc,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 0,
              child: GestureDetector(
                onTap: () {
                  if (index < 2) {
                    nextPage();
                  } else {
                    Navigator.pushReplacementNamed(context, SigninScreen.routeName);
                  }
                },
                child: Custombutton(
                  text: index == 2
                      ? StringsManager.onBoardGetStarted
                      : StringsManager.onBoardNext,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Dot extends StatelessWidget {
  Dot({super.key, required this.active});
  bool active;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      width: active ? size.width * 0.080 : size.width * 0.023,
      height: 8,
      decoration: BoxDecoration(
        color: active ? ColorsManager.primaryColor : ColorsManager.darkTeritaryColor,
        borderRadius: BorderRadius.circular(999),
      ),
    );
  }
}
