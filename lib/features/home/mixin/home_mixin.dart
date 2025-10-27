import 'package:flutter/material.dart';

import '../model/home_model.dart';
import '../widgets/home_widgets.dart';

mixin HomeMixin on State<HomeWidgets> {
  final homeModel = HomeModel(
    hospitalName: 'Merkez Efendi Hastanesi',
    province: 'Manisa',
    district: ' / YunusEmre',
    location: 'Manisa / Yunusemre 4711sk. No:9/3',
    phoneNumber: 5059819525,
    latitude: 10.0,
    longitude: 10.0,
    webSiteLink: 'https://www.youtube.com/@FlutterYazalim',
  );

}