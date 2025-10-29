import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../view/login_view.dart';
import '../view_model/auth_view_model.dart';

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

/*   bool isDoctor = false;
  @override
  void initState() {
    super.initState();
  //  isDoctor = Provider.of<AuthViewModel>(context).isDoctor;
  }*/
}
