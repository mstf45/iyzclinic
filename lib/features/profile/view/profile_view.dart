import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iyzclinic/core/utils/components/material/custom_material.dart';
import 'package:iyzclinic/core/utils/constants/custom_sized_box.dart';
import 'package:iyzclinic/core/utils/shared_prefs_helper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/utils/components/testfield/custom_text_from_field.dart';
import '../../../core/utils/validators/validate_class.dart';
import '../../auth/view_model/auth_view_model.dart';
import '../view_model/profile_view_model.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _formKey = GlobalKey<FormState>();
  final _validate = ValidateClass();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<ProfileViewModel>(context);
    final authVm = Provider.of<AuthViewModel?>(context, listen: false);
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 600;

    return CustomMaterial(
      child: SafeArea(
        child: vm.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? size.width * 0.18 : 20,
                        vertical: 20,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BackButton(),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Profil Düzenle",
                                    style: TextStyle(
                                      fontSize: isTablet ? 28 : 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                  Text(
                                    vm.isDoctor
                                        ? "Doktor Bilgileriniz"
                                        : "Hasta Bilgileriniz",
                                    style: TextStyle(
                                      fontSize: isTablet ? 18 : 14,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    CustomSizedBoxHeight.medium(),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? size.width * 0.18 : 20,
                        //  vertical: 20,
                      ),
                      child: Column(
                        spacing: 15,
                        children: [
                          // Name
                          CustomTextFromField(
                            controller: vm.nameCtrl,
                            label: "Ad Soyad",
                            validator: _validate.validateName,
                          ),

                          // Email
                          CustomTextFromField(
                            controller: vm.emailCtrl,
                            label: "E-posta",
                            validator: _validate.validateEmail,
                            keyboardType: TextInputType.emailAddress,
                          ),

                          // Phone
                          CustomTextFromField(
                            maxLength: 10,
                            controller: vm.phoneCtrl,
                            label: "Telefon",
                            validator: _validate.validatePhone,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),

                          if (vm.isDoctor) ...[
                            CustomTextFromField(
                              controller: vm.specializationCtrl,
                              label: "Uzmanlık Alanı",
                              validator: _validate.validateSpecialty,
                            ),
                          ] else ...[
                            CustomTextFromField(
                              controller: vm.diseaseCtrl,
                              label: "Kronik Hastalık",
                              validator: _validate.validateChronicDisease,
                            ),

                            CustomTextFromField(
                              controller: vm.allergyCtrl,
                              label: "Alerji Bilgisi",
                              validator: _validate.validateAllergy,
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () async {
                            if (!_formKey.currentState!.validate()) return;
                            await vm.updateProfile();
                            // authVm varsa loggedName güncelle
                            if (authVm != null) {
                              authVm.loggedName = vm.nameCtrl.text.trim();
                              authVm.notifyListeners();
                            }
                          },
                          icon: const Icon(Icons.save, color: Colors.white),
                          label: const Text(
                            "Güncelle",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            padding: EdgeInsets.symmetric(
                              horizontal: isTablet ? 36 : 24,
                              vertical: isTablet ? 16 : 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        OutlinedButton(
                          onPressed: () {
                            vm.init();
                          },
                          child: const Text("Sıfırla"),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // küçük not
                    Center(
                      child: Text(
                        "Bilgileriniz yerel olarak cihazda saklanır.",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: isTablet ? 14 : 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}
