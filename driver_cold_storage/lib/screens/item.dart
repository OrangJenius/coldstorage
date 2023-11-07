class Item {
  Item({
    required this.id,
    required this.expandedValue,
    required this.headerValue,
    required this.tanggal,
    required this.isCheck,
    required this.canSubmit,
    required this.tanggalAmbil,
  });

  int id;
  List<String> expandedValue;
  String headerValue;
  List<String> tanggal;
  List<String> isCheck;
  bool canSubmit;
  List<String> tanggalAmbil;
}
