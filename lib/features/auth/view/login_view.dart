import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iyzclinic/core/utils/components/button/custom_elevated_button.dart';
import 'package:iyzclinic/core/utils/components/material/custom_material.dart';
import 'package:iyzclinic/core/utils/components/testfield/custom_text_from_field.dart';
import 'package:iyzclinic/core/utils/constants/app_strings.dart';
import 'package:iyzclinic/core/utils/constants/custom_sized_box.dart';
import 'package:iyzclinic/core/utils/constants/home_style.dart';
import 'package:iyzclinic/features/auth/view/forget_password_view.dart';
import 'package:iyzclinic/features/auth/view/register_view.dart';
import 'package:iyzclinic/features/auth/widgets/manager/basic_usage_manager.dart';
import 'package:iyzclinic/features/home/view/home_view.dart';
import 'package:iyzclinic/features/home/widgets/home_widgets.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/constants/custom_decoration_box.dart';
import '../../../core/utils/validators/validate_class.dart';
import '../../home/view/patient_home_view.dart';
import '../mixin/login_mixin.dart';
import '../view_model/auth_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> with LoginMixin {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final screenHeight = MediaQuery.sizeOf(context).height;
    final vm = Provider.of<AuthViewModel>(context);
    return CustomMaterial(
      child: SafeArea(
        child: Form(
          key: globalKey,
          child: Padding(
            padding: LoginStyle.appbarPadding,
            child: Column(
              spacing: 10,
              children: [
                CustomSizedBoxHeight.small(),
                CustomTextFromField(
                  controller: emailController,
                  label: AppStrings.loginEmailLabel,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (v) => ValidateClass().validateEmail(v),
                  keyboardType: TextInputType.emailAddress,
                ),
                CustomTextFromField(
                  controller: passwordController,
                  label: AppStrings.loginPasswordLabel,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (v) => ValidateClass().validatePassword(v),
                  keyboardType: TextInputType.text,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.basicNavigate
                            .setTargetPage(ForgetPasswordView())
                            .pushPageNavigateProperty();
                      },
                      child: Text(
                        AppStrings.forgetPasswordTitle,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                /*   SwitchListTile(
                  title: const Text("Doktor olarak giriş yap"),
                  value: vm.isDoctor,
                  onChanged: vm.toggleRole,
                ),*/
                Spacer(),
                CustomElevatedButton(
                  onPressed: () async {
                    if (globalKey.currentState!.validate()) {
                      final success = await vm.login(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      if (success && context.mounted) {

                        context.basicNavigate
                            .setTargetPage(
                          context.read<AuthViewModel>().isDoctor
                              ? PatientHomeView()
                              : HomeWidgets(),
                        )
                            .pushAndRemoveUntilNavigate();
                        Fluttertoast.showToast(
                          msg: 'Giriş Başarılı',
                          backgroundColor: Colors.green,
                        );
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Giriş başarısız!',
                          backgroundColor: Colors.red,
                        );
                      }
                    }
                  },
                  text: AppStrings.loginButton,
                ),

                RichText(
                  text: TextSpan(
                    text: AppStrings.haveAccount,
                    style: TextStyle(color: Colors.black),
                    children: [
                      TextSpan(
                        text: AppStrings.registerButton,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            context.basicNavigate
                                .setTargetPage(const RegisterView())
                                .pushPageNavigateProperty();
                          },
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
