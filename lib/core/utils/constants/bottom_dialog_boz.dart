import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

final class BottomDialogBox {
  Future<void> successToastDialog({required String msg}) async {
    Fluttertoast.showToast(msg: msg, backgroundColor: Colors.green);
  }

  Future<void> errorToastDialog({required String msg}) async {
    Fluttertoast.showToast(msg: msg, backgroundColor: Colors.red);
  }

  Future<void> infoToastDialog({required String msg}) async {
    Fluttertoast.showToast(msg: msg, backgroundColor: Colors.amber);
  }
}
