import 'package:flutter/material.dart';

final class CustomAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.white,
      shadowColor: Colors.white,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text('Ana Sayfa'),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
