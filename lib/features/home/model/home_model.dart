class HomeModel {
  final String? hospitalName;
  final String? province; //il
  final String? district; //ilçe
  final String? location;
  final int? phoneNumber;
  final double? latitude; //enlem
  final double? longitude;//boylam
  final String? webSiteLink;

  HomeModel({
    required this.hospitalName,
    required this.province,
    required this.district,
    required this.location,
    required this.phoneNumber,
    required this.latitude,
    required this.longitude,
    required this.webSiteLink,
  });
}
