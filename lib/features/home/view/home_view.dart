import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:iyzclinic/core/utils/components/material/custom_material.dart';
import 'package:iyzclinic/core/utils/constants/custom_decoration_box.dart';
import 'package:iyzclinic/core/utils/constants/custom_sized_box.dart';
import 'package:provider/provider.dart';
import '../model/home_model.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../view_model/location_view_model.dart';

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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => LocationPickerScreen(),
                            ),
                          );
                        },
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  String searchQuery = "";
  final TextEditingController _locationController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Kullanıcı açtığında konum alınsın
    Future.delayed(Duration.zero, () {
      Provider.of<LocationViewModel>(
        context,
        listen: false,
      ).requestUserLocation().then((_) {
        // Eğer konum alındıysa haritayı o konuma taşınır.
        final markerPos = Provider.of<LocationViewModel>(
          context,
          listen: false,
        ).markerPosition;
        if (markerPos != null) {
          Provider.of<LocationViewModel>(
            context,
            listen: false,
          ).mapController.move(markerPos, 5.0);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var locationProvider = Provider.of<LocationViewModel>(context);
    var urlTemplate =
        'https://maps.geoapify.com/v1/tile/carto/{z}/{x}/{y}.png?apiKey=${locationProvider.apiKey}';
    return CustomMaterial(
      child: SafeArea(
        child: Consumer<LocationViewModel>(
          builder: (context, locationProvider, child) {
            return Column(
              children: [
                Row(children: [BackButton(), Text('Konum Ara')]),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: _locationController.text.isNotEmpty
                        ? locationProvider.selectedLocation
                        : locationProvider.selectedLocation,
                    onTapOutside: (event) =>
                        FocusManager.instance.primaryFocus?.unfocus(),
                    decoration: InputDecoration(
                      labelText: '',
                      suffixIcon: IconButton(
                        onPressed: () async {
                          if (searchQuery.isNotEmpty) {
                            await locationProvider.searchLocationByCity(
                              searchQuery,
                            );
                          }
                        },
                        icon: Icon(Icons.search_rounded),
                      ),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      searchQuery = value;
                    },
                  ),
                ),
                if (locationProvider.isLoading)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircularProgressIndicator(),
                  ),
                Expanded(
                  child: FlutterMap(
                    mapController: locationProvider.mapController,
                    options: MapOptions(
                      initialCenter: LatLng(39.92077, 32.85411),
                      initialZoom: 5.0,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: urlTemplate,
                        userAgentPackageName: 'com.example.app',
                      ),
                      if (locationProvider.markerPosition != null)
                        MarkerLayer(
                          markers: [
                            Marker(
                              width: 50,
                              height: 50,
                              point: locationProvider.markerPosition!,
                              child: Icon(
                                Icons.location_on,
                                size: 40,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
