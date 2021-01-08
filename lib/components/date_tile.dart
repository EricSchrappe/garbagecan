import 'package:flutter/material.dart';

class DateTile extends StatelessWidget {
  final String dateText;
  final bool isSelected;
  final Function selectedCallback;

  DateTile({this.dateText, this.isSelected, this.selectedCallback});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: Column(
        children: [
          Align(
            alignment: FractionalOffset.topCenter,
            child: GestureDetector(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: isSelected ? Color(0xFF3A6ED4) : Colors.transparent,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  dateText,
                  style: TextStyle(
                      color: isSelected ? Colors.white : Color(0xFF444444),
                      fontSize: 18.0),
                ),
              ),
              onTap: selectedCallback,
            ),
          ),
        ],
      ),
    );
  }
}
