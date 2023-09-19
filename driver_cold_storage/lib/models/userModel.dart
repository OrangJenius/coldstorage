import 'dart:math';

class UserModel {
  final int id;
  final String name;
  final DateTime tanggal_lahir;
  final String Email;
  final String Role;
  final String Password;
  final String workplace;

  UserModel({
    required this.Email,
    required this.tanggal_lahir,
    required this.Role,
    required this.Password,
    required this.id,
    required this.name,
    required this.workplace,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["Id"] ?? 0,
      name: json["Nama"] ?? '',
      tanggal_lahir: DateTime.parse(json['Tanggal_Lahir'] ?? ''),
      Email: json["Email"] ?? '',
      Role: json["Role"] ?? '',
      Password: json["Password"] ?? '',
      workplace: json["Workplace"] ?? '',
    );
  }
}
