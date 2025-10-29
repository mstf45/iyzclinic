import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/utils/shared_prefs_helper.dart';

class ProfileViewModel extends ChangeNotifier {
  // controllers
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

  /// init: verileri yükle
  Future<void> init() async {
    isLoading = true;
    notifyListeners();

    // Esnek okuma: SharedPrefsHelper'ın getData ile string veya map döndürebileceğini
    // göz önünde bulundurarak birkaç ihtimali kontrol ediyoruz.
    dynamic roleRaw;
    try {
      roleRaw = await SharedPrefsHelper.getData('userRole');
    } catch (_) {
      roleRaw = null;
    }

    String role = 'patient';
    if (roleRaw is String) {
      role = roleRaw;
    } else if (roleRaw is Map && roleRaw['role'] is String) {
      role = roleRaw['role'];
    } else if (roleRaw is Map && roleRaw['userType'] is String) {
      role = roleRaw['userType'];
    }

    // Kullanıcı verisini al
    dynamic data;
    try {
      data = await SharedPrefsHelper.getData(role == 'doctor' ? 'doctor' : 'patient');
    } catch (_) {
      data = null;
    }

    if (data != null && data is Map) {
      isDoctor = role == 'doctor';
      nameCtrl.text = (data['name'] ?? data['fullName'] ?? '') as String;
      emailCtrl.text = (data['email'] ?? '') as String;
      phoneCtrl.text = (data['phone'] ?? '') as String;
      specializationCtrl.text = (data['specialty'] ?? data['specialization'] ?? '') as String;
      diseaseCtrl.text = (data['chronicDisease'] ?? data['disease'] ?? '') as String;
      allergyCtrl.text = (data['allergy'] ?? '') as String;
    } else {
      // Eğer data yoksa, role bilgisi doğru olmayabilir; fallback olarak patient kontrolü
      isDoctor = false;
    }

    isLoading = false;
    notifyListeners();
  }

  /// Profil güncelle
  Future<void> updateProfile() async {
    // kontrolü view'de yap; burada sadece kaydet
    final updatedData = {
      "name": nameCtrl.text.trim(),
      "email": emailCtrl.text.trim(),
      "phone": phoneCtrl.text.trim(),
      "specialization": specializationCtrl.text.trim(),
      "chronicDisease": diseaseCtrl.text.trim(),
      "allergy": allergyCtrl.text.trim(),
    };

    await SharedPrefsHelper.saveData(isDoctor ? 'doctor' : 'patient', updatedData);

    Fluttertoast.showToast(msg: "Profil güncellendi ✅", backgroundColor: Colors.green);

    // isteğe bağlı: SharedPrefs'daki userRole tekrar set et (garanti)
    await SharedPrefsHelper.setString('userRole', isDoctor ? 'doctor' : 'patient');

    notifyListeners();
  }

  /// role değiştir (ör. admin panelinden veya testten)
  Future<void> setRole(bool doctor) async {
    isDoctor = doctor;
    await SharedPrefsHelper.setString('userRole', doctor ? 'doctor' : 'patient');
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
