import 'package:flutter/cupertino.dart';

import '../view/login_view.dart';

mixin LoginMixin on State<LoginView> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  /// Controller
   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();


  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
