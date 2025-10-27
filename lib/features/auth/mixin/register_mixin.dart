import 'package:flutter/cupertino.dart';
import '../view/register_view.dart';

mixin RegisterMixin on  State<RegisterView> {
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