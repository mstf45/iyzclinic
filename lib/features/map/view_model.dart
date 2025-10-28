import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationProvider extends ChangeNotifier {
  List<LatLng> carPositions = [
    LatLng(39.922, 32.854),
    LatLng(39.925, 32.850),
    LatLng(39.918, 32.858),
  ];
  static final String _apiKey = '00e6c66f30ab4391b381a944bbd1bf49';
  final String apiKey = _apiKey;
  LatLng? endPosition;
  LatLng? startPosition;
  String selectedLocation = "";
  LatLng? markerPosition;
  bool isLoading = false;
  MapController mapController = MapController();
  bool selectingStart = true;
  double distance = 0.0;
  double fare = 0.0;
  void selectLocation(LatLng latLng) {
    if (startPosition == null) {
      startPosition = latLng;
    } else if (endPosition == null) {
      endPosition = latLng;
      calculateDistanceAndFare();
    } else {
      // Eğer ikisi de doluysa sıfırlayıp yeniden başla
      startPosition = latLng;
      endPosition = null;
      distance = 0;
      fare = 0;
    }
    notifyListeners();
  }

  // 2 konum arası mesafeyi ve ücreti hesaplıyoruz
  void calculateDistanceAndFare() {
    if (startPosition != null && endPosition != null) {
      final Distance distanceCalc = Distance();
      double meters = distanceCalc(startPosition!, endPosition!);
      distance = meters / 1000;
      fare = distance * 50;
    }
    notifyListeners();
  }

  Future<void> requestUserLocation() async {
    isLoading = true;
    notifyListeners();

    try {
      // Konum izinlerini kontrol et
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        if (permission != LocationPermission.whileInUse &&
            permission != LocationPermission.always) {
          selectedLocation = "Konum izinleri reddedildi.";
          isLoading = false;
          notifyListeners();
          return;
        }
      }

      // Konumu al
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation,
      );
      await updateMarkerAndFetchLocation(position.latitude, position.longitude);
    } catch (e) {
      selectedLocation = "Hata: $e";
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateMarkerAndFetchLocation(double lat, double lon) async {
    markerPosition = LatLng(lat, lon);
    notifyListeners();

    await fetchLocationName(lat, lon);
  }

  Future<void> fetchLocationName(double lat, double lon) async {
    final url = Uri.parse(
      'https://api.geoapify.com/v1/geocode/reverse?lat=$lat&lon=$lon&apiKey=$apiKey',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['features'] != null &&
            data['features'].isNotEmpty &&
            data['features'][0]['properties'] != null) {
          final properties = data['features'][0]['properties'];
          final city = properties['city'] ?? properties['county'] ?? "";
          if (city.isNotEmpty) {
            selectedLocation = "$city / Türkiye";
          } else {
            selectedLocation = "Konum bilgisi alınamadı.";
          }
        } else {
          selectedLocation = "Konum bilgisi bulunamadı.";
        }
      } else {
        selectedLocation =
            "Error: Konum getirilemedi (status: ${response.statusCode}).";
      }
    } catch (e) {
      selectedLocation = "Error: $e";
    }

    isLoading = false;
    notifyListeners();
  }

  Future<LatLng?> searchLocationByCity(String city) async {
    isLoading = true;
    notifyListeners();

    final url = Uri.parse(
      'https://api.geoapify.com/v1/geocode/search?text=$city&apiKey=$apiKey',
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['features'] != null && data['features'].isNotEmpty) {
          double lat = data['features'][0]['geometry']['coordinates'][1];
          double lon = data['features'][0]['geometry']['coordinates'][0];

          markerPosition = LatLng(lat, lon);
          selectedLocation = city;

          // 📌 Haritayı otomatik olarak hareket ettir
          mapController.move(markerPosition!, 6.0);

          isLoading = false;
          notifyListeners();
          return markerPosition;
        } else {
          selectedLocation = "Şehir Bulunamadı";
        }
      } else {
        selectedLocation =
            "Error: Şehir konumu getirilemedi (status: ${response.statusCode}).";
      }
    } catch (e) {
      selectedLocation = "Error: $e";
    }

    isLoading = false;
    notifyListeners();
    return null;
  }
}
