class Item {
  Item({
    required this.id,
    required this.expandedValue,
    required this.headerValue,
    required this.tanggal,
    this.isChecked = false,
    this.isSubmitted = false,
  });

  int id;
  String expandedValue;
  String headerValue;
  String tanggal;
  bool isChecked;
  bool isSubmitted;
}
