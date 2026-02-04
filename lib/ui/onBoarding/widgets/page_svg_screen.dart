import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PageSvgScreen extends StatelessWidget {
  PageSvgScreen({super.key, required this.svg, this.size = 0.9});
  String svg;
  double size;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          svg,
          width: MediaQuery.of(context).size.width * size,
          colorFilter: ColorFilter.mode(
            Theme.of(context).colorScheme.primary,
            BlendMode.srcIn,
          ),
        ),
      ],
    );
  }
}
