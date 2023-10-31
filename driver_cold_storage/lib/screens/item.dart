class Item {
  Item({
    required this.id,
    required this.expandedValue,
    required this.headerValue,
    required this.tanggal,
    required this.isCheck,
    required this.canSubmit,
  });

  int id;
  String expandedValue;
  String headerValue;
  String tanggal;
  String isCheck;
  bool canSubmit;
}
