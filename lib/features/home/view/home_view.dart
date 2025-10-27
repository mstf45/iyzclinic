import 'package:flutter/material.dart';
import 'package:iyzclinic/core/utils/constants/custom_decoration_box.dart';
import 'package:iyzclinic/core/utils/constants/custom_sized_box.dart';
import '../model/home_model.dart';

class HomeView extends StatelessWidget {
  final HomeModel? homeModel;
  const HomeView({super.key, required this.homeModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: CustomDecorationBox.homeView(),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            height: 60,
                            width: 60,
                            'assets/icon/png/hospital.png',
                          ),
                        ],
                      ),
                      CustomSizedBoxWidth.small(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(homeModel!.hospitalName ?? ''),
                          Row(
                            children: [
                              Text(homeModel!.province ?? ''),
                              Text(homeModel!.district ?? ''),
                            ],
                          ),
                          Text(homeModel!.location ?? ''),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: homeModel!.phoneNumber != null
                          ? Image.asset(
                              'assets/icon/png/phone.png',
                              height: 20,
                              width: 20,
                            )
                          : SizedBox.shrink(),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon:
                          homeModel!.latitude != null &&
                              homeModel!.latitude != null
                          ? Image.asset(
                              'assets/icon/png/map.png',
                              height: 20,
                              width: 20,
                            )
                          : SizedBox.shrink(),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: homeModel!.webSiteLink != null
                          ? Image.asset(
                              'assets/icon/png/world.png',
                              height: 20,
                              width: 20,
                            )
                          : SizedBox.shrink(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
