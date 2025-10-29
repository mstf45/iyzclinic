import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iyzclinic/core/utils/components/material/custom_material.dart';
import 'package:iyzclinic/features/auth/view/login_view.dart';
import 'package:iyzclinic/features/home/view/patient_home_view.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/components/button/custom_elevated_button.dart';
import '../../../core/utils/components/testfield/custom_text_from_field.dart';
import '../../../core/utils/constants/app_strings.dart';
import '../../../core/utils/constants/bottom_dialog_boz.dart';
import '../../../core/utils/constants/custom_sized_box.dart';
import '../../../core/utils/constants/home_style.dart';
import '../../../core/utils/validators/validate_class.dart';
import '../mixin/register_mixin.dart';
import '../model/doctor_model.dart';
import '../model/patient_model.dart';
import '../view_model/auth_view_model.dart';
import '../widgets/manager/basic_usage_manager.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> with RegisterMixin {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AuthViewModel>(context);
    return CustomMaterial(
      child: SafeArea(
        child: Padding(
          padding: LoginStyle.appbarPadding,
          child: Form(
            key: globalKey,
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomSizedBoxHeight.small(),
                Text(
                  vm.isDoctor ? "Doktor Kayıt Alanı" : "Hasta Kayıt Alanı",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    CustomTextFromField(
                      label: AppStrings.registerNameLabel,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) => ValidateClass().validateName(v),
                      controller: nameController,
                    ),
                    CustomTextFromField(
                      label: AppStrings.registerEmailLabel,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) => ValidateClass().validateEmail(v),
                      controller: emailController,
                    ),
                    CustomTextFromField(
                      label: AppStrings.loginPasswordLabel,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (v) => ValidateClass().validatePassword(v),
                      controller: passwordController,
                    ),
                  ],
                ),
                if (vm.isDoctor)
                  CustomTextFromField(
                    label: "Uzmanlık Alanı",
                    controller: specialController,
                    validator: (v) => ValidateClass().validateSpecialty(v),
                  )
                else ...[
                  CustomTextFromField(
                    label: "Kronik Hastalık",
                    controller: chronicController,
                    validator: (v) => ValidateClass().validateChronicDisease(v),
                  ),
                  CustomTextFromField(
                    label: "Alerji",
                    controller: allergyController,
                    validator: (v) => ValidateClass().validateAllergy(v),
                  ),
                ],
                SwitchListTile(
                  title: const Text("Doktor olarak kayıt ol"),
                  value: vm.isDoctor,
                  onChanged: vm.toggleRole,
                ),
                Spacer(),
                CustomElevatedButton(
                  text: "Kayıt Ol",
                  onPressed: () async {
                    if (globalKey.currentState!.validate()) {
                      if (vm.isDoctor) {
                        await vm.registerDoctor(
                          Doctor(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            specialty: specialController.text,
                          ),
                        );
                      } else {
                        await vm.registerPatient(
                          Patient(
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            chronicDisease: chronicController.text,
                            allergy: allergyController.text,
                          ),
                        );
                      }

                      if (context.mounted) {
                        BottomDialogBox().successToastDialog(
                          msg: 'Kayıt başarılı! Giriş yapabilirsiniz.',
                        );
                        context.basicNavigate
                            .setTargetPage(LoginView())
                            .pushPageNavigateProperty();
                        //    Navigator.pop(context);
                      }
                    }
                  },
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
