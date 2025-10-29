import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:iyzclinic/core/utils/constants/app_strings.dart';
import 'package:iyzclinic/features/auth/view/login_view.dart';
import 'package:iyzclinic/features/auth/view/register_view.dart';
import 'package:iyzclinic/features/auth/view_model/auth_view_model.dart';
import 'package:iyzclinic/features/home/view/patient_home_view.dart';
import 'package:iyzclinic/features/home/view_model/home_view_model.dart';
import 'package:iyzclinic/features/home/widgets/home_widgets.dart';
import 'package:iyzclinic/features/profile/view_model/profile_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/home/view/home_view.dart';
import 'features/home/view_model/location_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => HomeViewModel()),
          ChangeNotifierProvider(create: (context) => AuthViewModel()),
          ChangeNotifierProvider(create: (context) => LocationViewModel()),
          ChangeNotifierProvider(create: (context) => ProfileViewModel()),
        ],
        child: MyApp(isLoggedIn: isLoggedIn),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, this.isLoggedIn = false});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isLoggedIn ? const PatientHomeView() : const LoginView(),
    );
  }
}

// PatientHomeView

// HomeWidgets
