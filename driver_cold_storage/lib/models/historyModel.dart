class HistoryModel {
  final String Id;
  final String orderNumber;
  final String namaItem;
  final int jumlah;
  final int berat;
  final DateTime tanggalMasuk;
  final String gedung;
  final String aisle;
  final String place;
  final String serviceType;
  final String rentDriver;
  final DateTime tanggalAmbil;
  final String photo;
  final String notes;
  final int kendaraanId;
  final int userId;
  final int clientId;

  HistoryModel({
    required this.Id,
    required this.orderNumber,
    required this.namaItem,
    required this.jumlah,
    required this.berat,
    required this.tanggalMasuk,
    required this.gedung,
    required this.aisle,
    required this.place,
    required this.serviceType,
    required this.rentDriver,
    required this.tanggalAmbil,
    required this.photo,
    required this.notes,
    required this.kendaraanId,
    required this.userId,
    required this.clientId,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      Id: json['Id'] ?? '',
      orderNumber: json['Order_Id'] ?? '',
      namaItem: json['Nama_Item'] ?? '',
      jumlah: json['Jumlah'] ?? 0,
      berat: json['Berat'] ?? 0,
      tanggalMasuk: DateTime.parse(json['Tanggal_Masuk'] ?? ''),
      gedung: json['gedung'] ?? '',
      aisle: json['Aisle'] ?? '',
      place: json['Place'] ?? '',
      serviceType: json['Service_Type'] ?? '',
      rentDriver: json['Rent_Driver'] ?? '',
      tanggalAmbil: DateTime.parse(json['Tanggal_Ambil'] ?? ''),
      photo: json['Foto'] ?? '',
      notes: json['Notes'] ?? '',
      kendaraanId: json['Kendaraan_id'] ?? 0,
      userId: json['User_Id'] ?? 0,
      clientId: json['Client_Id'] ?? 0,
    );
  }
}
