import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/utils/shared_prefs_helper.dart';
import '../model/patient_model.dart';
import '../model/doctor_model.dart';

class AuthViewModel extends ChangeNotifier {
  bool isDoctor = false;
  bool isLoggedIn = false;
  String? loggedName;

  void toggleRole(bool doctor) {
    isDoctor = doctor;
    notifyListeners();
  }

  /// 🔹 Hasta kaydı
  Future<void> registerPatient(Patient patient) async {
    await SharedPrefsHelper.saveData('patient', patient.toJson());
  }

  /// 🔹 Doktor kaydı
  Future<void> registerDoctor(Doctor doctor) async {
    await SharedPrefsHelper.saveData('doctor', doctor.toJson());
  }

  /// 🔹 Giriş işlemi
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    final data = await SharedPrefsHelper.getData(isDoctor ? 'doctor' : 'patient');
    if (data == null) return false;

    if (data["email"] == email && data["password"] == password) {
      loggedName = data["name"];
      isLoggedIn = true;

      // 🔹 SharedPreferences'a oturum bilgisi kaydet
      await SharedPrefsHelper.setBool('isLoggedIn', true);
      await SharedPrefsHelper.setString('userType', isDoctor ? 'doctor' : 'patient');

      notifyListeners();

      Fluttertoast.showToast(
        msg: 'Hoş geldiniz $loggedName',
        backgroundColor: Colors.green,
      );

      return true;
    }

    Fluttertoast.showToast(
      msg: 'E-posta veya şifre hatalı',
      backgroundColor: Colors.red,
    );

    return false;
  }

  /// 🔹 Çıkış işlemi
  Future<void> logout() async {
    isLoggedIn = false;
    loggedName = null;

    // 🔹 SharedPreferences’tan oturum bilgilerini kaldır
    await SharedPrefsHelper.remove('isLoggedIn');
    await SharedPrefsHelper.remove('userType');

    notifyListeners();

    Fluttertoast.showToast(
      msg: 'Çıkış yapıldı',
      backgroundColor: Colors.amber,
    );
  }
}
