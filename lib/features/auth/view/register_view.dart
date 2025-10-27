import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:iyzclinic/features/auth/view/login_view.dart';

import '../../../core/utils/components/custom_elevated_button.dart';
import '../../../core/utils/components/custom_text_from_field.dart';
import '../../../core/utils/constants/app_strings.dart';
import '../../../core/utils/constants/custom_sized_box.dart';
import '../../../core/utils/constants/home_style.dart';
import '../../../core/utils/validators/validate_class.dart';
import '../mixin/register_mixin.dart';
import '../widgets/manager/basic_usage_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> with RegisterMixin {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: LoginStyle.appbarPadding,
          child: Form(
            key: globalKey,
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSizedBoxHeight.small(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    CustomTextFromField(
                      label: AppStrings.registerNameLabel,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) => ValidateClass().validateName(v),
                    ),
                    CustomTextFromField(
                      label: AppStrings.registerEmailLabel,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) => ValidateClass().validateEmail(v),
                    ),
                    CustomTextFromField(
                      label:  AppStrings.loginPasswordLabel,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) => ValidateClass().validatePassword(v),
                    ),
                  ],
                ),
                Spacer(),
                CustomElevatedButton(
                  onPressed: () {
                    if (globalKey.currentState!.validate()) {
                      context.basicNavigate.pushPageNavigateProperty();
                    }
                  },
                  text: 'Kayıt Ol',
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: AppStrings.registerDontHaveAccount,
                          style: const TextStyle(color: Colors.black),
                          children: [
                            TextSpan(
                              text: AppStrings.loginRichSubText,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                  //    context.basicNavigate.pageNavigateProperty();
                                },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                CustomSizedBoxHeight.small(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension _HomeStyleExtension on BuildContext {
  LoginStyle get homeStyle => LoginStyle(context: this);
  BasicUsageManager get basicNavigate => BasicUsageManager(context: this);
}
