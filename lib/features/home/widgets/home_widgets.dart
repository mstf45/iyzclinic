import 'package:flutter/material.dart';
import 'package:iyzclinic/core/utils/constants/custom_bottom_appbar.dart';
import 'package:iyzclinic/features/home/model/home_model.dart';
import 'package:iyzclinic/features/home/view/drawer_view.dart';
import 'package:iyzclinic/features/home/view/home_view.dart';
import '../../../core/utils/components/custom_appbar.dart';
import '../mixin/home_mixin.dart';

class HomeWidgets extends StatefulWidget {
  const HomeWidgets({super.key});

  @override
  State<HomeWidgets> createState() => _HomeWidgetsState();
}

class _HomeWidgetsState extends State<HomeWidgets> with HomeMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerView(),
      backgroundColor: Colors.white,
      appBar: CustomAppbar(),
      body: ListView(
        children: [for (int i = 0; i < 20; i++) HomeView(homeModel: homeModel)],
      ),
      bottomNavigationBar: CustomBottomAppbar(),
    );
  }
}
