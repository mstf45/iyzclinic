import 'package:flutter/material.dart';
import 'package:iyzclinic/core/utils/components/custom_elevated_button.dart';
import 'package:iyzclinic/core/utils/components/custom_text_from_field.dart';

import '../../../core/utils/validators/validate_class.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _globalKey,
        child: Column(
          children: [
            CustomTextFromField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (v) => ValidateClass().validateEmail(v),
            ),
            CustomElevatedButton(onPressed: () {
              _globalKey.currentState!.validate();
            }, text: 'Tıkla'),
          ],
        ),
      ),
    );
  }
}
