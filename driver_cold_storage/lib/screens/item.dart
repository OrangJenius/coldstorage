class Item {
  Item({
    required this.id,
    required this.expandedValue,
    required this.headerValue,
    required this.tanggal,
    required this.isCheck,
    required this.canSubmit,
    required this.tanggalAmbil,
    required this.status,
  });

  int id;
  List<String> expandedValue;
  String headerValue;
  List<String> tanggal;
  List<String> isCheck;
  bool canSubmit;
  List<String> tanggalAmbil;
  String status;
}
