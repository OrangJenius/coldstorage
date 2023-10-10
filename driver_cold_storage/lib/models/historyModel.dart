class HistoryModel {
  final String Id;
  final String distibuteId;
  final String namaToko;
  final String alamat;
  final String time;
  final DateTime tanggalPickup;
  final String status;
  final String titikAwal;
  final String destination;
  final String orderId;
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
  final String namaClient;
  final String namaUser;

  HistoryModel({
    required this.Id,
    required this.distibuteId,
    required this.namaToko,
    required this.alamat,
    required this.time,
    required this.tanggalPickup,
    required this.status,
    required this.titikAwal,
    required this.destination,
    required this.orderId,
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
    required this.namaClient,
    required this.namaUser,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    try {
      return HistoryModel(
        Id: json['Id'] ?? '',
        distibuteId: json['Distribute_Id'] ?? '',
        namaToko: json['Nama_Toko'] ?? '',
        alamat: json['Alamat'] ?? '',
        time: json['Time'] ?? '',
        tanggalPickup:
            json['Tanggal_PickUp'] != null && json['Tanggal_PickUp'] != ""
                ? DateTime.parse(json['Tanggal_PickUp'])
                : DateTime.now(),
        status: json['Status'] ?? '',
        titikAwal: json['Titik_Awal'] ?? '',
        destination: json['Destination'] ?? '',
        orderId: json['Order_Id'] ?? '',
        namaItem: json['Nama_Item'] ?? '',
        jumlah: json['Jumlah'] ?? 0,
        berat: json['Berat'] ?? 0,
        tanggalMasuk:
            json['Tanggal_Masuk'] != null && json['Tanggal_Masuk'] != ""
                ? DateTime.parse(json['Tanggal_Masuk'])
                : DateTime.now(),
        gedung: json['gedung'] ?? '',
        aisle: json['Aisle'] ?? '',
        place: json['Place'] ?? '',
        serviceType: json['Service_Type'] ?? '',
        rentDriver: json['Rent_Driver'] ?? '',
        tanggalAmbil:
            json['Tanggal_Ambil'] != null && json['Tanggal_Ambil'] != ""
                ? DateTime.parse(json['Tanggal_Ambil'])
                : DateTime.now(),
        photo: json['Foto'] ?? '',
        notes: json['Notes'] ?? '',
        kendaraanId: json['Kendaraan_id'] ?? 0,
        userId: json['User_Id'] ?? 0,
        clientId: json['Client_Id'] ?? 0,
        namaClient: json['Nama_Client'] ?? '',
        namaUser: json['Nama_User'] ?? '',
      );
    } catch (e) {
      print('Error parsing date: $e');
      return HistoryModel(
        Id: '',
        distibuteId: '',
        namaToko: '',
        alamat: '',
        time: '',
        tanggalPickup: DateTime.now(),
        status: '',
        titikAwal: '',
        destination: '',
        orderId: '',
        namaItem: '',
        jumlah: 0,
        berat: 0,
        tanggalMasuk: DateTime.now(),
        gedung: '',
        aisle: '',
        place: '',
        serviceType: '',
        rentDriver: '',
        tanggalAmbil: DateTime.now(),
        photo: '',
        notes: '',
        kendaraanId: 0,
        userId: 0,
        clientId: 0,
        namaClient: '',
        namaUser: '',
      );
    }
  }
}

class HistoryModel2 {
  final String Id;
  final String distibuteId;
  final String namaToko;
  final String alamat;
  final String time;
  final DateTime tanggalPickup;
  final String status;
  final String titikAwal;
  final String destination;
  final String orderId;
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
  final String namaClient;
  final String namaUser;

  HistoryModel2({
    required this.Id,
    required this.distibuteId,
    required this.namaToko,
    required this.alamat,
    required this.time,
    required this.tanggalPickup,
    required this.status,
    required this.titikAwal,
    required this.destination,
    required this.orderId,
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
    required this.namaClient,
    required this.namaUser,
  });

  factory HistoryModel2.fromJson(Map<String, dynamic> json) {
    try {
      return HistoryModel2(
        Id: json['Id'] ?? '',
        distibuteId: json['Distribute_Id'] ?? '',
        namaToko: json['Nama_Toko'] ?? '',
        alamat: json['Alamat'] ?? '',
        time: json['Time'] ?? '',
        tanggalPickup:
            json['Tanggal_PickUp'] != null && json['Tanggal_PickUp'] != ""
                ? DateTime.parse(json['Tanggal_PickUp'])
                : DateTime.now(),
        status: json['Status'] ?? '',
        titikAwal: json['Titik_Awal'] ?? '',
        destination: json['Destination'] ?? '',
        orderId: json['Order_Id'] ?? '',
        namaItem: json['Nama_Item'] ?? '',
        jumlah: json['Jumlah'] ?? 0,
        berat: json['Berat'] ?? 0,
        tanggalMasuk:
            json['Tanggal_Masuk'] != null && json['Tanggal_Masuk'] != ""
                ? DateTime.parse(json['Tanggal_Masuk'])
                : DateTime.now(),
        gedung: json['gedung'] ?? '',
        aisle: json['Aisle'] ?? '',
        place: json['Place'] ?? '',
        serviceType: json['Service_Type'] ?? '',
        rentDriver: json['Rent_Driver'] ?? '',
        tanggalAmbil:
            json['Tanggal_Ambil'] != null && json['Tanggal_Ambil'] != ""
                ? DateTime.parse(json['Tanggal_Ambil'])
                : DateTime.now(),
        photo: json['Foto'] ?? '',
        notes: json['Notes'] ?? '',
        kendaraanId: json['Kendaraan_id'] ?? 0,
        userId: json['User_Id'] ?? 0,
        clientId: json['Client_Id'] ?? 0,
        namaClient: json['Nama_Client'] ?? '',
        namaUser: json['Nama_User'] ?? '',
      );
    } catch (e) {
      print('Error parsing date: $e');
      return HistoryModel2(
        Id: '',
        distibuteId: '',
        namaToko: '',
        alamat: '',
        time: '',
        tanggalPickup: DateTime.now(),
        status: '',
        titikAwal: '',
        destination: '',
        orderId: '',
        namaItem: '',
        jumlah: 0,
        berat: 0,
        tanggalMasuk: DateTime.now(),
        gedung: '',
        aisle: '',
        place: '',
        serviceType: '',
        rentDriver: '',
        tanggalAmbil: DateTime.now(),
        photo: '',
        notes: '',
        kendaraanId: 0,
        userId: 0,
        clientId: 0,
        namaClient: '',
        namaUser: '',
      );
    }
  }
}
