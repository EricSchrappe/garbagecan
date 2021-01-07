class DateSlots {
  final String dateText;
  bool isSelected;

  DateSlots({this.dateText, this.isSelected = false});

  void toogleSelected() {
    isSelected = !isSelected;
  }
}
