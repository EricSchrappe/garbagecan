import 'package:flutter/material.dart';

class ItemTile extends StatelessWidget {
  final bool isChecked;
  final String itemText;
  final int itemValue;
  final String itemUnit;
  final Function checkboxCallback;

  ItemTile({
    this.isChecked,
    this.itemText,
    this.itemValue,
    this.itemUnit,
    this.checkboxCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        itemText,
        style: TextStyle(
          color: Color(0xFF444444),
          fontSize: 18.0,
        ),
      ),
      subtitle: Text(
        'The current value is $itemValue Rs. per $itemUnit',
        style: TextStyle(
          color: Color(0xFF444444),
          fontSize: 12.0,
        ),
      ),
      trailing: Checkbox(
        activeColor: Color(0xFF3A6ED4),
        value: isChecked,
        onChanged: checkboxCallback,
      ),
    );
  }
}
