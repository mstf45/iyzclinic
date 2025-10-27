import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BasicUsageManagerInterface {
  void showToastMsg();
  void pushPageNavigateProperty();
  void pushAndRemoveUntilNavigate();
}

final class BasicUsageManager implements BasicUsageManagerInterface {
  BasicUsageManager({required BuildContext context, this.targetPage})
    : _context = context;

  final BuildContext _context;
  late Widget? targetPage;
  BasicUsageManager setTargetPage(Widget page) {
    targetPage = page;
    return this;
  }

  @override
  void pushPageNavigateProperty() {
    if (targetPage == null) {
      Fluttertoast.showToast(msg: 'Hedef sayfa tanımlı değil!');
      return;
    }
    Navigator.push(
      _context,
      CupertinoPageRoute(builder: (context) => targetPage!),
    );
  }

  @override
  void pushAndRemoveUntilNavigate() {
    if (targetPage == null) {
      Fluttertoast.showToast(msg: 'Hedef sayfa tanımlı değil!');
      return;
    }
    Navigator.pushAndRemoveUntil(
      _context,
      CupertinoPageRoute(builder: (context) => targetPage!),
      (route) => false,
    );
  }

  @override
  void showToastMsg() {
    Fluttertoast.showToast(msg: 'Test Ediyorum');
  }
}
