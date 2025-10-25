import 'package:flutter/material.dart';
import 'package:iyzclinic/core/utils/components/custom_elevated_button.dart';
import 'package:iyzclinic/core/utils/components/custom_text_from_field.dart';
import 'package:iyzclinic/core/utils/constants/home_style.dart';
import 'package:iyzclinic/features/auth/widgets/manager/basic_usage_manager.dart';

import '../../../core/utils/validators/validate_class.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: context.homeStyle.appbarColor),
      body: Form(
        key: _globalKey,
        child: Column(
          children: [
            CustomTextFromField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (v) => ValidateClass().validateEmail(v),
            ),
            CustomElevatedButton(
              onPressed: () => context.basicNavigate.pageNavigateProperty(),
              text: 'Tıkla',
            ),
          ],
        ),
      ),
    );
  }
}

extension _HomeStyleExtension on BuildContext {
  HomeStyle get homeStyle => HomeStyle(context: this);
  BasicUsageManager get basicNavigate => BasicUsageManager(context: this);
}
