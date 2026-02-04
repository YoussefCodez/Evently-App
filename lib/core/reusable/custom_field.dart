import 'package:evently_c17/core/resources/assets_manager.dart';
import 'package:evently_c17/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomField extends StatefulWidget {
  String hint;
  String? prefix;
  bool isPassword;
  String? Function(String?) validator;
  TextEditingController controller;
  String? suffix;
  int maxLines;
  CustomField({
    this.maxLines=1,
    required this.controller,this.suffix,required this.hint,this.prefix,this.isPassword = false,required this.validator});

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
      maxLines: widget.maxLines,
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.isPassword
          ?!isVisible
          :false,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        fillColor: Theme.of(context).colorScheme.onSecondaryContainer,
        filled: true,
        hintText: widget.hint,
        suffixIconConstraints: BoxConstraints(
            maxWidth: 24,
            maxHeight: 24,
            minWidth: 24,
            minHeight:24
        ),
        suffixIcon: widget.isPassword
            ?IconButton(
            onPressed:() {
              setState(() {
                isVisible = !isVisible;
              });
            } , icon: SvgPicture.asset(
          isVisible?AssetsManager.visibleOn:AssetsManager.visibleOff,
        height: 24,
          width: 24,
        ))
            :widget.suffix!=null
            ?SvgPicture.asset(widget.suffix!,height: 24,width: 24,)
            :null,
        hintStyle: TextStyle(
          color: ColorsManager.hintTextColor,
          fontWeight: FontWeight.w400,
          fontSize: 14
        ),
        prefixIconConstraints: BoxConstraints(
          maxWidth: 40,
          maxHeight: 40,
          minWidth: 40,
          minHeight:40
        ),
        prefixIcon: widget.prefix!=null
            ?Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SvgPicture.asset(widget.prefix!,height: 24,width: 24,),
        ):null,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:BorderSide(color: Theme.of(context).colorScheme.onTertiaryContainer)
        ),
        enabledBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:BorderSide(color: Theme.of(context).colorScheme.onTertiaryContainer)
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:BorderSide(color: Theme.of(context).colorScheme.onTertiaryContainer)
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide:BorderSide(color: Theme.of(context).colorScheme.onTertiaryContainer)
        )
      ),
    );
  }
}
