class PengantaranModel {
  final String Id;
  final String Order_Id;
  final String Item;
  final String Address;
  final String Tanggal_PickUp;
  final String Time;
  final String Quantities;
  final String Phone_Number;
  final String Status;
  final String Titik_Awal;
  final String Destination;
  final String Nama_Toko;
  final String Berat;
  final String Jumlah;
  final String Nama_Client;
  final String is_check;
  final String status_perjalanan;

  PengantaranModel({
    required this.Id,
    required this.Order_Id,
    required this.Item,
    required this.Address,
    required this.Tanggal_PickUp,
    required this.Time,
    required this.Quantities,
    required this.Phone_Number,
    required this.Status,
    required this.Titik_Awal,
    required this.Destination,
    required this.Nama_Toko,
    required this.Berat,
    required this.Jumlah,
    required this.Nama_Client,
    required this.is_check,
    required this.status_perjalanan,
  });

  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'Order_Id': Order_Id,
      'Item': Item,
      'Address': Address,
      'Tanggal_Pickup': Tanggal_PickUp,
      'Time': Time,
      'Quantities': Quantities,
      'Phone_Number': Phone_Number,
      'Status': Status,
      'Titik_Awal': Titik_Awal,
      'Destination': Destination,
      'Nama_Toko': Nama_Toko,
      'Weight': Berat,
      'Jumlah': Jumlah,
      'Nama_Client': Nama_Client,
    };
  }

  factory PengantaranModel.fromJson(Map<String, dynamic> json) {
    return PengantaranModel(
      Id: json['Id'] ?? '', // Assuming ekspedisi_Id is of type int
      Order_Id: json['Order_Id'] ?? '',
      Item: json['Item'] ?? '',
      Address: json['Address'] ?? '',
      Tanggal_PickUp: json['Tanggal_PickUp'] ?? '',
      Time: json['Time'] ?? '',
      Quantities: json['Quantities'] ?? 0,
      Phone_Number: json['Phone_Number'] ?? '',
      Status: json['Status'] ?? '',
      Titik_Awal: json['Titik_Awal'],
      Destination: json['Destination'],
      Nama_Toko: json['Nama_Toko'],
      Berat: json['Weight'],
      Jumlah: json['Jumlah'],
      Nama_Client: json['Nama_Client'],
      is_check: json['Is_Check'],
      status_perjalanan: json['Status_Perjalanan'],
    );
  }
}
