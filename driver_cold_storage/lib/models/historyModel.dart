class HistoryModel {
  final String Id;
  final String distibuteId;
  final String namaToko;
  final String alamat;
  final String time;
  final String tanggalPickup;
  final String status;
  final String titikAwal;
  final String destination;
  final String orderId;
  final String namaItem;
  final String jumlah;
  final String berat;
  final String tanggalMasuk;
  final String gedung;
  final String aisle;
  final String place;
  final String serviceType;
  final String rentDriver;
  final String tanggalAmbil;
  final String photo;
  final String notes;
  final String kendaraanId;
  final String userId;
  final String clientId;
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
    //try {
    return HistoryModel(
      Id: json['Id'] ?? '',
      distibuteId: json['Distribute_Id'] ?? '',
      namaToko: json['Nama_Toko'] ?? '',
      alamat: json['Alamat'] ?? '',
      time: json['Time'] ?? '',
      tanggalPickup: json['Tanggal_PickUp'] ?? '',
      status: json['Status'] ?? '',
      titikAwal: json['Titik_Awal'] ?? '',
      destination: json['Destination'] ?? '',
      orderId: json['Order_Id'] ?? '',
      namaItem: json['Nama_Item'] ?? '',
      jumlah: json['Jumlah'] ?? '',
      berat: json['Berat'] ?? '',
      tanggalMasuk: json['Tanggal_Masuk'] ?? '',
      gedung: json['gedung'] ?? '',
      aisle: json['Aisle'] ?? '',
      place: json['Place'] ?? '',
      serviceType: json['Service_Type'] ?? '',
      rentDriver: json['Rent_Driver'] ?? '',
      tanggalAmbil: json['Tanggal_Ambil'] ?? '',
      photo: json['Foto'] ?? '',
      notes: json['Notes'] ?? '',
      kendaraanId: json['Kendaraan_id'] ?? '',
      userId: json['User_Id'] ?? '',
      clientId: json['Client_Id'] ?? '',
      namaClient: json['Nama_Client'] ?? '',
      namaUser: json['Nama_User'] ?? '',
    );
    //   } catch (e) {
    //     print('Error parsing date: $e');
    //     return HistoryModel(
    //       Id: '',
    //       distibuteId: '',
    //       namaToko: '',
    //       alamat: '',
    //       time: '',
    //       tanggalPickup: DateTime.now().toString(),
    //       status: '',
    //       titikAwal: '',
    //       destination: '',
    //       orderId: '',
    //       namaItem: '',
    //       jumlah: 0,
    //       berat: 0,
    //       tanggalMasuk: DateTime.now().toString(),
    //       gedung: '',
    //       aisle: '',
    //       place: '',
    //       serviceType: '',
    //       rentDriver: '',
    //       tanggalAmbil: DateTime.now().toString(),
    //       photo: '',
    //       notes: '',
    //       kendaraanId: 0,
    //       userId: 0,
    //       clientId: 0,
    //       namaClient: '',
    //       namaUser: '',
    //     );
    //   }
  }
}

class HistoryModel2 {
  final String Id;
  final String distibuteId;
  final String namaToko;
  final String alamat;
  final String time;
  final String tanggalPickup;
  final String status;
  final String titikAwal;
  final String destination;
  final String orderId;
  final String namaItem;
  final String jumlah;
  final String berat;
  final String tanggalMasuk;
  final String gedung;
  final String aisle;
  final String place;
  final String serviceType;
  final String rentDriver;
  final String tanggalAmbil;
  final String photo;
  final String notes;
  final String kendaraanId;
  final String userId;
  final String clientId;
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
    //try {
    return HistoryModel2(
      Id: json['Id'] ?? '',
      distibuteId: json['Distribute_Id'] ?? '',
      namaToko: json['Nama_Toko'] ?? '',
      alamat: json['Alamat'] ?? '',
      time: json['Time'] ?? '',
      tanggalPickup: json['Tanggal_PickUp'] ?? '',
      status: json['Status'] ?? '',
      titikAwal: json['Titik_Awal'] ?? '',
      destination: json['Destination'] ?? '',
      orderId: json['Order_Id'] ?? '',
      namaItem: json['Nama_Item'] ?? '',
      jumlah: json['Jumlah'] ?? '',
      berat: json['Berat'] ?? '',
      tanggalMasuk: json['Tanggal_Masuk'] ?? '',
      gedung: json['gedung'] ?? '',
      aisle: json['Aisle'] ?? '',
      place: json['Place'] ?? '',
      serviceType: json['Service_Type'] ?? '',
      rentDriver: json['Rent_Driver'] ?? '',
      tanggalAmbil: json['Tanggal_Ambil'] ?? '',
      photo: json['Foto'] ?? '',
      notes: json['Notes'] ?? '',
      kendaraanId: json['Kendaraan_id'] ?? '',
      userId: json['User_Id'] ?? '',
      clientId: json['Client_Id'] ?? '',
      namaClient: json['Nama_Client'] ?? '',
      namaUser: json['Nama_User'] ?? '',
    );
    //} catch (e) {
    //print('Error parsing date: $e');
    // return HistoryModel2(
    //   Id: '',
    //   distibuteId: '',
    //   namaToko: '',
    //   alamat: '',
    //   time: '',
    //   tanggalPickup: DateTime.now().toString(),
    //   status: '',
    //   titikAwal: '',
    //   destination: '',
    //   orderId: '',
    //   namaItem: '',
    //   jumlah: 0,
    //   berat: 0,
    //   tanggalMasuk: DateTime.now().toString(),
    //   gedung: '',
    //   aisle: '',
    //   place: '',
    //   serviceType: '',
    //   rentDriver: '',
    //   tanggalAmbil: DateTime.now().toString(),
    //   photo: '',
    //   notes: '',
    //   kendaraanId: 0,
    //   userId: 0,
    //   clientId: 0,
    //   namaClient: '',
    //   namaUser: '',
    // );
    //}
  }
}
