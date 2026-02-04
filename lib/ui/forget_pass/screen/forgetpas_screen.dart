import 'package:evently_c17/core/resources/assets_manager.dart';
import 'package:evently_c17/core/resources/strings_manager.dart';
import 'package:evently_c17/core/resources/validations.dart';
import 'package:evently_c17/core/resources/widgets/dialog_utils.dart';
import 'package:evently_c17/core/reusable/custom_button_reusable.dart';
import 'package:evently_c17/core/reusable/custom_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgetpassScreen extends StatelessWidget {
  static const String routeName = "forgetpass";
  TextEditingController controller = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ForgetpassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringsManager.forgetPass, style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),),
        leading: BackButton(style: ButtonStyle(
          iconColor: WidgetStateColor.resolveWith((states) {
            return Theme.of(context).colorScheme.onSurfaceVariant;
          },)
        ),),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Image.asset(AssetsManager.forgetPass),
                SizedBox(height: 16,),
                CustomField(controller: controller, hint: "Enter Email", validator: Validations.validateEmail),
                SizedBox(height: 16,),
                Container(
                  width: double.infinity,
                  child: CustomButton(title: StringsManager.resetPass, onClick: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        await FirebaseAuth.instance.sendPasswordResetEmail(email: controller.text);
                        DialogUtils.showToast("Password reset email sent");
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          DialogUtils.showToast("User not found");
                        }
                      } catch (e) {
                        DialogUtils.showToast(e.toString());
                      }
                    }
                  },),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
