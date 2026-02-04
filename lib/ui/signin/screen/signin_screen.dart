import 'package:evently_c17/core/resources/strings_manager.dart';
import 'package:evently_c17/core/resources/validations.dart';
import 'package:evently_c17/core/resources/widgets/dialog_utils.dart';
import 'package:evently_c17/core/reusable/custom_button_reusable.dart';
import 'package:evently_c17/core/reusable/custom_field.dart';
import 'package:evently_c17/ui/forget_pass/screen/forgetpas_screen.dart';
import 'package:evently_c17/ui/home/screen/home_screen.dart';
import 'package:evently_c17/ui/signup/screen/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/resources/assets_manager.dart';

class SigninScreen extends StatefulWidget {
  static const String routeName = "signin";

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          AssetsManager.logo,
          height: 27,
          fit: BoxFit.fitHeight,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  StringsManager.loginToYourAcc,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 24),
                CustomField(
                  controller: emailController,
                  hint: StringsManager.enterYourEmail,
                  prefix: AssetsManager.email,
                  validator: Validations.validateEmail,
                ),
                SizedBox(height: 16),
                CustomField(
                  controller: passwordController,
                  hint: StringsManager.enterYourPassword,
                  prefix: AssetsManager.lock,
                  isPassword: true,

                  validator: Validations.validatePassword,
                ),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, ForgetpassScreen.routeName);
                    },
                    child: Text(
                      StringsManager.forgetPassAsk,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ),
                ),
                SizedBox(height: 48),
                Container(
                  width: double.infinity,
                  child: CustomButton(
                    title: StringsManager.login,
                    onClick: () {
                      login();
                    },
                  ),
                ),
                SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      StringsManager.dontHaveAcc,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                          context,
                          SignupScreen.routeName,
                        );
                      },
                      child: Text(
                        StringsManager.signUp,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  login() async {
    if (formKey.currentState?.validate() ?? false) {
      try {
        DialogUtils.showLoadingDialog(context);
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        if (e.code == 'user-not-found') {
          DialogUtils.showMessageDialog(
            context,
            'No user found for that email.',
          );
        } else if (e.code == 'wrong-password') {
          DialogUtils.showMessageDialog(
            context,
            'Wrong password provided for that user.',
          );
        }
      } catch (e) {
        Navigator.pop(context);
        DialogUtils.showMessageDialog(
          context,
          'Something went wrong: ${e.toString()}',
        );
      }
    }
  }
}
