class TimeSlot {
  final String id;
  final DateTime dateTime;
  bool isSelected;
  bool isBlocked;

  DateTime get date => DateTime(dateTime.year, dateTime.month, dateTime.day);

  TimeSlot(this.id,this.dateTime, {this.isBlocked = false, this.isSelected = false});

  void toggleSelected() {
    isSelected = !isSelected;
  }
}
