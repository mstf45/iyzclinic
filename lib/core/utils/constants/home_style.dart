import 'package:flutter/cupertino.dart';
import 'package:kartal/kartal.dart';

final class HomeStyle {
  HomeStyle({required BuildContext context}) : _context = context;
  final BuildContext _context;

  Color get appbarColor => _context.general.colorScheme.surface;

  static EdgeInsets get apbarpading => EdgeInsets.symmetric(horizontal: 16);
}
