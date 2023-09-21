class PengantaranModel {
  final String orderNumber;
  final DateTime jadwalPengantaran;
  final String time;
  final String item;
  final String titik_awal;
  final String destination;
  final int quantities;
  final String phoneNumber;
  final String status;

  PengantaranModel({
    required this.orderNumber,
    required this.jadwalPengantaran,
    required this.item,
    required this.time,
    required this.titik_awal,
    required this.destination,
    required this.quantities,
    required this.phoneNumber,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'Order_Id': orderNumber,
      'Tanggal_PickUp': jadwalPengantaran.toIso8601String(),
      'Item': item,
      'Time': time,
      'Titik_Awal': titik_awal,
      'destination': destination,
      'Quantities': quantities,
      'Phone_Number': phoneNumber,
      'Status': status,
    };
  }

  factory PengantaranModel.fromJson(Map<String, dynamic> json) {
    return PengantaranModel(
      orderNumber:
          json['Order_Id'] ?? '', // Assuming ekspedisi_Id is of type int
      jadwalPengantaran: DateTime.parse(json['Tanggal_PickUp'] ?? ''),
      item: json['Item'],
      time: json['Time'],
      titik_awal: json['Titik_Awal'] ?? '',
      destination: json['Destination'] ?? '',
      quantities: json['Quantities'] ?? 0,
      phoneNumber: json['Phone_Number'] ?? '',
      status: json['Status'] ?? '',
    );
  }
}
