class TimeSlot {
  final int hour;
  final int minute;
  bool isSelected;
  bool isBlocked;

  TimeSlot(
    this.hour, [
    this.minute = 0,
  ])  : isSelected = false,
        isBlocked = false;

  void toggleSelected() {
    isSelected = !isSelected;
  }

  void toggleBlocked() {
    isBlocked = true;
  }

  void toggleUnblocked() {
    isBlocked = false;
  }
}
