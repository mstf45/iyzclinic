import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iyzclinic/features/auth/view/login_view.dart';
import 'package:iyzclinic/features/profile/view/profile_view.dart';
import 'package:provider/provider.dart';
import '../../../../features/auth/view_model/auth_view_model.dart';

final class CustomAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AuthViewModel>(context);
    return AppBar(
      surfaceTintColor: Colors.white,
      shadowColor: Colors.white,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        'Hasta Sayfası bu',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            vm.logout();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginView()),
                  (route) => false,
            );
          },
          icon: Icon(Icons.exit_to_app),
        ),
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => ProfileView()),
            );
          },
          icon: Icon(Icons.person),
        ),

        /*        IconButton(
          onPressed: () {
            vm.logout();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => LoginView()),
              (route) => false,
            );
          },
          icon: Icon(Icons.exit_to_app),
        ),*/
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
