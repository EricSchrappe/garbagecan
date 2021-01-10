class Item {
  final String name;
  bool isChecked;

  Item({this.name, this.isChecked = false});

  void toogleCheckbox() {
    isChecked = !isChecked;
  }
}
