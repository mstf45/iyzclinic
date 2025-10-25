import 'package:flutter/cupertino.dart';
import 'package:kartal/kartal.dart';

final class LoginStyle {
  LoginStyle({required BuildContext context}) : _context = context;
  final BuildContext _context;

  Color get appbarColor => _context.general.colorScheme.surface;

  static EdgeInsets get appbarPadding => EdgeInsets.symmetric(horizontal: 16);
}
