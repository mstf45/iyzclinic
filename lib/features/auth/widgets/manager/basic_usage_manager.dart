import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class BasicUsageManagerInterface {
  void showToastMsg();
  void pageNavigateProperty();
}

final class BasicUsageManager implements BasicUsageManagerInterface {
  BasicUsageManager({required BuildContext context}) : _context = context;

  final BuildContext _context;

  @override
  void pageNavigateProperty() {
    // TODO: implement pageNavigateProperty
    Navigator.push(
      _context,
      CupertinoPageRoute(builder: (context) => Scaffold()),
    );
  }

  @override
  void showToastMsg() {
    // TODO: implement showToastMsg
    Fluttertoast.showToast(msg: 'Test Ediyorum');
  }
}
