class ProfileModel {
  final int id;
  final String name;
  final String nomor_telpon;
  final String Email;
  final String Role;

  ProfileModel({
    required this.Email,
    required this.nomor_telpon,
    required this.Role,
    required this.id,
    required this.name,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json["Id"] ?? 0,
      name: json["Nama"] ?? '',
      nomor_telpon: json["Nomor_Telepon"] ?? '',
      Email: json["Email"] ?? '',
      Role: json["Role"] ?? '',
    );
  }
}
