import 'package:flutter/material.dart';

class DateTile extends StatelessWidget {
  final String dateText;
  final bool isSelected;
  final Function selectedCallback;

  DateTile({this.dateText, this.isSelected, this.selectedCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        dateText,
        style: TextStyle(color: Color(0xFF444444), fontSize: 18.0),
      ),
      dense: true,
      selected: isSelected,
      selectedTileColor: Colors.blue,
      onTap: () {},
    );
  }
}
