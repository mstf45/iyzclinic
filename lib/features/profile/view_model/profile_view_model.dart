import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/utils/shared_prefs_helper.dart';

class ProfileViewModel extends ChangeNotifier {
  // Controllers
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController specializationCtrl = TextEditingController();
  final TextEditingController diseaseCtrl = TextEditingController();
  final TextEditingController allergyCtrl = TextEditingController();

  bool isDoctor = false;
  bool isLoading = true;

  ProfileViewModel() {
    init();
  }

  /// 🔹 Verileri başlat
  Future<void> init() async {
    isLoading = true;
    notifyListeners();

    // 1️⃣ Kullanıcı rolünü oku
    final userType = await SharedPrefsHelper.getString('userType');
    isDoctor = userType == 'doctor';

    // 2️⃣ Kullanıcı verisini getir
    final data = await SharedPrefsHelper.getData(isDoctor ? 'doctor' : 'patient');

    if (data != null) {
      nameCtrl.text = data['name'] ?? '';
      emailCtrl.text = data['email'] ?? '';
      phoneCtrl.text = data['phone'] ?? '';
      specializationCtrl.text = data['specialty'] ?? '';
      diseaseCtrl.text = data['chronicDisease'] ?? '';
      allergyCtrl.text = data['allergy'] ?? '';
    }

    isLoading = false;
    notifyListeners();
  }

  /// 🔹 Profili güncelle
  Future<void> updateProfile() async {
    final updatedData = {
      "name": nameCtrl.text.trim(),
      "email": emailCtrl.text.trim(),
      "phone": phoneCtrl.text.trim(),
      if (isDoctor)
        "specialty": specializationCtrl.text.trim()
      else ...{
        "chronicDisease": diseaseCtrl.text.trim(),
        "allergy": allergyCtrl.text.trim(),
      },
    };

    await SharedPrefsHelper.saveData(
      isDoctor ? 'doctor' : 'patient',
      updatedData,
    );

    Fluttertoast.showToast(
      msg: "Profil güncellendi ✅",
      backgroundColor: Colors.green,
    );

    notifyListeners();
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    phoneCtrl.dispose();
    specializationCtrl.dispose();
    diseaseCtrl.dispose();
    allergyCtrl.dispose();
    super.dispose();
  }
}
