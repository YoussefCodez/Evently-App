import 'package:evently_c17/core/resources/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogUtils {
  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ShowLoadingDialog();
      },
    );
  }

  static void showMessageDialog(BuildContext context,String message) {
    showDialog(
      context: context,
      builder: (context) {
        return ShowMessageDialog(message: message,);
      },
    );
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: ColorsManager.primaryColor,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

}


class ShowLoadingDialog extends StatelessWidget {
  const ShowLoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: CircularProgressIndicator(
              color: ColorsManager.primaryColor,
            ),
          ),
        ],
      )
    );
  }
}

class ShowMessageDialog extends StatelessWidget {
  final String message;
  const ShowMessageDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(message),
          ),
        ],
      )
    );
  }
}