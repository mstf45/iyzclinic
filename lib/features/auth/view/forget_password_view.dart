import 'package:flutter/material.dart';
import 'package:iyzclinic/core/utils/components/button/custom_elevated_button.dart';
import 'package:iyzclinic/core/utils/components/testfield/custom_text_from_field.dart';
import 'package:iyzclinic/core/utils/constants/app_strings.dart';
import 'package:iyzclinic/core/utils/constants/custom_sized_box.dart';
import 'package:iyzclinic/core/utils/constants/home_style.dart';
import 'package:iyzclinic/core/utils/validators/validate_class.dart';
import 'package:iyzclinic/features/auth/widgets/manager/basic_usage_manager.dart';
import 'package:kartal/kartal.dart';

import '../../../core/utils/components/material/custom_material.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomMaterial(
      child: SafeArea(
        child: Form(
          key: globalKey,
          child: Padding(
            padding: LoginStyle.appbarPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextFromField(
                  controller: emailController,
                  label: AppStrings.loginEmailLabel,
                  hint: AppStrings.forgetPasswordInstruction,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (v) => ValidateClass().validateEmail(v),
                ),
                CustomSizedBoxHeight.medium(),
                CustomElevatedButton(
                  onPressed: () {
                    if (globalKey.currentState!.validate()) {
                      context.basicNavigate
                          .setTargetPage(ForgetPasswordView())
                          .pushPageNavigateProperty();
                    }
                  },
                  text: AppStrings.loginButton,
                ),
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
