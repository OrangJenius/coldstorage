class PengantaranModel {
  final String Distribute_Id;
  final String Order_Id;
  final DateTime Tanggal_PickUp;
  final String Time;
  final String Customer;
  final String Quantities;
  final int Weight;
  final String Address;
  final String Phone_Number;
  final String Status;
  final String Titik_Awal;
  final String Destination;
  final String Nama_Item;
  final int Jumlah;
  final int Berat;
  final DateTime Tanggal_Masuk;
  final String Gedung;
  final String Aisle;
  final String Place;
  final String Service_Type;
  final String Rent_Driver;
  final DateTime Tanggal_Ambil;
  final String Foto;
  final String Notes;
  final String kendaraan;
  final String User;
  final String Client;
  final String Nama_Toko;

  PengantaranModel({
    required this.Distribute_Id,
    required this.Order_Id,
    required this.Tanggal_PickUp,
    required this.Time,
    required this.Customer,
    required this.Quantities,
    required this.Weight,
    required this.Address,
    required this.Phone_Number,
    required this.Status,
    required this.Titik_Awal,
    required this.Destination,
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
    required this.kendaraan,
    required this.User,
    required this.Client,
    required this.Nama_Toko,
  });

  Map<String, dynamic> toJson() {
    return {
      'Distribute_Id': Distribute_Id,
      'Order_Id': Order_Id,
      'Tanggal_PickUp': Tanggal_PickUp.toIso8601String(),
      'Time': Time,
      'Customer': Customer,
      'Quantities': Quantities,
      'Weight': Weight,
      'Address': Address,
      'Phone_Number': Phone_Number,
      'Status': Status,
      'Titik_Awal': Titik_Awal,
      'Destination': Destination,
      'Nama_Item': Nama_Item,
      'Jumlah': Jumlah,
      'Berat': Berat,
      'Tanggal_Masuk': Tanggal_Masuk.toIso8601String(),
      'Gedung': Gedung,
      'Aisle': Aisle,
      'Place': Place,
      'Service_Type': Service_Type,
      'Rent_Driver': Rent_Driver,
      'Tanggal_Ambil': Tanggal_Ambil.toIso8601String(),
      'Notes': Notes,
      'kendaraan': kendaraan,
      'User': User,
      'Client': Client,
      'Nama_Toko': Nama_Toko,
    };
  }

  factory PengantaranModel.fromJson(Map<String, dynamic> json) {
    return PengantaranModel(
      Distribute_Id:
          json['Distribute_Id'] ?? '', // Assuming ekspedisi_Id is of type int
      Order_Id: json['Order_Id'] ?? '',
      Tanggal_PickUp: DateTime.parse(json['Tanggal_PickUp'] ?? ''),
      Time: json['Time'] ?? '',
      Customer: json['Customer'] ?? '',
      Quantities: json['Quantities'] ?? '',
      Weight: json['Weight'] ?? 0,
      Address: json['Address'] ?? '',
      Phone_Number: json['Phone_Number'] ?? '',
      Status: json['Status'],
      Titik_Awal: json['Titik_Awal'],
      Destination: json['Destination'] ?? '',
      Nama_Item: json['Nama_Item'] ?? '',
      Jumlah: json['Jumlah'] ?? 0,
      Berat: json['Berat'] ?? 0,
      Tanggal_Masuk: DateTime.parse(json['Tanggal_Masuk'] ?? ''),
      Gedung: json['Gedung'] ?? '',
      Aisle: json['Aisle'] ?? '',
      Place: json['Place'] ?? '',
      Service_Type: json['Service_Type'] ?? '',
      Rent_Driver: json['Rent_Driver'] ?? '',
      Tanggal_Ambil: DateTime.parse(json['Tanggal_Ambil'] ?? ''),
      Foto: json['Foto'] ?? '',
      Notes: json['Notes'] ?? '',
      kendaraan: json['kendaraan'] ?? '',
      User: json['User'] ?? '',
      Client: json['Client'] ?? '',
      Nama_Toko: json['Nama_Toko'] ?? '',
    );
  }
}
