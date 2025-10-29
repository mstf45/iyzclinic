import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iyzclinic/core/utils/constants/bottom_dialog_boz.dart';
import '../../../core/utils/shared_prefs_helper.dart';
import '../model/patient_model.dart';
import '../model/doctor_model.dart';

class AuthViewModel extends ChangeNotifier {
  bool isDoctor = false;
  bool isLoggedIn = false;
  String? loggedName;

  void toggleRole(bool doctor) {
    isDoctor = doctor;
    debugPrint('Durumunuz:${isDoctor}');
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
  Future<bool> login({required String email, required String password}) async {

    final data = await SharedPrefsHelper.getData(
      isDoctor ? 'doctor' : 'patient',
    );
    if (data == null) return false;

    if (data["email"] == email && data["password"] == password) {
      loggedName = data["name"];
      isLoggedIn = true;

      // 🔹 SharedPreferences'a oturum bilgisi kaydet
      await SharedPrefsHelper.setBool('isLoggedIn', true);
      await SharedPrefsHelper.setString(
        'userType',
        isDoctor ? 'doctor' : 'patient',
      );

      notifyListeners();
      BottomDialogBox().successToastDialog(msg: 'Hoş geldiniz $loggedName');

      return true;
    }
    BottomDialogBox().errorToastDialog(msg: 'E-posta veya şifre hatalı');

    return false;
  }

  /// 🔹 Çıkış işlemi
  Future<void> logout() async {
    isLoggedIn = false;
    loggedName = null;

    // kullanıcıya özel verileri temizle
    await SharedPrefsHelper.clearUserData();

    notifyListeners();
    BottomDialogBox().infoToastDialog(msg: 'Çıkış yapıldı');
  }


}
