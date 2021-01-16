import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class TextFieldTimePicker extends StatelessWidget {
  final TextEditingController controller;

  TextFieldTimePicker({this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      textAlign: TextAlign.center,
      readOnly: true,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color(0xFFF6F6F6),
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF3A6ED4),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFF3A6ED4),
          ),
        ),
        isDense: true,
        contentPadding: EdgeInsets.all(8.0),
      ),
      onTap: () {
        DatePicker.showTimePicker(context,
            showTitleActions: true,
            showSecondsColumn: false, onConfirm: (date) {
          if (date.minute < 15) {
            controller.text = '${date.hour}:00';
          } else if (date.minute > 15 && date.minute <= 30) {
            controller.text = '${date.hour}:30';
          } else {
            controller.text = '${date.hour + 1}:00';
          }
        }, currentTime: DateTime.now(), locale: LocaleType.en);
      },
    );
  }
}
