/*
import 'dart:convert';

class UserModel {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? profileImageUrl;
  final DateTime? createdAt;

  const UserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.profileImageUrl,
    this.createdAt,
  });

  /// 🔹 Modeli JSON'dan oluşturur
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }

  /// 🔹 Modeli JSON'a dönüştürür (örneğin kayıt için API’ye gönderirken)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profileImageUrl': profileImageUrl,
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  /// 🔹 Modeli JSON string’e çevirme (opsiyonel)
  String toRawJson() => json.encode(toJson());

  /// 🔹 JSON string’ten model oluşturma (opsiyonel)
  factory UserModel.fromRawJson(String str) =>
      UserModel.fromJson(json.decode(str));

  /// 🔹 Modeli kopyalamak için (örneğin güncellemede)
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profileImageUrl,
    DateTime? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
*/
