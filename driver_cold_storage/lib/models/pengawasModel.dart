-class PengawasModel {
  final String Id;
  final String Nama_Item;
  final String Jumlah;
  final String Berat;
  final String Tanggal_Masuk;
  final String Gedung;
  final String Aisle;
  final String Place;
  final String Service_Type;
  final String Rent_Driver;
  final String Tanggal_Ambil;
  final String Foto;
  final String Notes;
  final String Jenis_Pembayaran;
  final String Jumlah_Pembayaran;
  final String Nama_Client;
  final String Nama_User;
  final String Nama_Pengawas;
  final String Id_Distribute;
  final String Temperature;
  final String Status_Distribute;
  bool isExpanded;

  PengawasModel({
    required this.Id,
    required this.Nama_Item,
    required this.Jumlah,
    required this.Berat,
    required this.Tanggal_Masuk,
    required this.Gedung,
    required this.Aisle,
    required this.Place,
    required this.Service_Type,
    required this.Rent_Driver,
    required this.Tanggal_Ambil,
    required this.Foto,
    required this.Notes,
    required this.Jenis_Pembayaran,
    required this.Jumlah_Pembayaran,
    required this.Nama_Client,
    required this.Nama_User,
    required this.Nama_Pengawas,
    required this.Id_Distribute,
    required this.Temperature,
    required this.Status_Distribute,
    required this.isExpanded,
  });

  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'Nama_Item': Nama_Item,
      'Jumlah': Jumlah,
      'Berat': Berat,
      'Gedung': Gedung,
      'Aisle': Aisle,
      'Place': Place,
      'Service_Type': Service_Type,
      'Tanggal_Masuk': Tanggal_Masuk,
      'Rent_Driver': Rent_Driver,
      'Tanggal_Ambil': Tanggal_Ambil,
      'Foto': Foto,
      'Notes': Notes,
      'Jenis_Pembayaran': Jenis_Pembayaran,
      'Jumlah_Pembayaran': Jumlah_Pembayaran,
      'Nama_Client': Nama_Client,
      'Nama_User': Nama_User,
      'Nama_Pengawas': Nama_Pengawas,
      'Id_Distribute': Id_Distribute,
      'Temperature': Temperature,
      'Status_Distribute': Status_Distribute,
    };
  }

  factory PengawasModel.fromJson(Map<String, dynamic> json) {
    return PengawasModel(
      Id: json['Id'] ?? '', // Assuming ekspedisi_Id is of type int

      Nama_Item: json['Nama_Item'] ?? '',
      Jumlah: json['Jumlah'],
      Berat: json['Berat'],
      Tanggal_Masuk: json['Tanggal_Masuk'] ?? '',
      Gedung: json['Gedung'] ?? '',
      Aisle: json['Aisle'] ?? '',
      Place: json['Place'] ?? '',
      Service_Type: json['Service_Type'] ?? '',
      Rent_Driver: json['Rent_Driver'] ?? '',
      Tanggal_Ambil: json['Tanggal_Ambil'] ?? '',
      Foto: json['Foto'] ?? '',
      Notes: json['Notes'] ?? '',
      Jenis_Pembayaran: json['Jenis_Pembayaran'] ?? '',
      Jumlah_Pembayaran: json['Jumlah_Pembayaran'] ?? '',
      Nama_Client: json['Nama_Client'] ?? '',
      Nama_User: json['Nama_User'] ?? '',
      Nama_Pengawas: json['Nama_Pengawas'] ?? '',
      Id_Distribute: json['Id_Distribute'] ?? '',
      Temperature: json['Temperature'] ?? '',
      Status_Distribute: json['Status_Distribute'] ?? '',
      isExpanded: false,
    );
  }
}