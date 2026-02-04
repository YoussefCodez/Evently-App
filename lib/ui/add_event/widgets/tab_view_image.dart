import 'package:flutter/material.dart';

import '../../../core/resources/colors_manager.dart';

class TabViewImage extends StatelessWidget {
  String image;
  TabViewImage(this.image);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height:height*0.25 ,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorsManager.fieldBorder),
          image: DecorationImage(
              image: AssetImage(image)
          )
      ),
    );
  }
}
