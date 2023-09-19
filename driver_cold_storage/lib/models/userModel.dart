class UserModel {
  final int id_driver;
  final String driver_name;
  final String tanggalLahir;
  final String Email;

  final String Role;
  final String Password;
  final String Workplace;

  UserModel({
    required this.Email,
    required this.Role,
    required this.Password,
    required this.Workplace,
    required this.id_driver,
    required this.driver_name,
    required this.tanggalLahir,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id_driver: json["Id"] ?? 0,
      driver_name: json["Nama"] ?? '',
      tanggalLahir: json["Tanggal_Lahir"] ?? '',
      Email: json["Email"] ?? '',
      Password: json["Password"] ?? '',
      Role: json["Role"] ?? '',
      Workplace: json["status"] ?? '',
    );
  }
}
