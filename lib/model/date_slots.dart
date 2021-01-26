class DateSlots {
  final String dateText;
  bool isSelected;
  bool isBlocked;

  DateSlots({this.dateText, this.isSelected = false, this.isBlocked = false});

  void toogleSelected() {
    isSelected = !isSelected;
  }

  void toogleBlocked() {
    isBlocked = true;
  }

  void toogleUnblocked() {
    isBlocked = false;
  }
}
