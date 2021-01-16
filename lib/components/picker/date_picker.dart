import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class TextFieldDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final bool withClearButton;

  TextFieldDatePicker({this.controller, this.withClearButton = false});

  @override
  Widget build(BuildContext context) {
    return withClearButton
        ? Row(
            children: [
              Expanded(
                child: TextField(
                  readOnly: true,
                  controller: controller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFF6F6F6),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF3A6ED4),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        bottomLeft: Radius.circular(4.0),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF3A6ED4),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        bottomLeft: Radius.circular(4.0),
                      ),
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.all(8.0),
                  ),
                  onTap: () {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        minTime: DateTime.now(),
                        maxTime: DateTime.now().add(Duration(days: 365)),
                        onConfirm: (date) {
                      controller.text = DateFormat('yyyy-MM-dd').format(date);
                    }, currentTime: DateTime.now(), locale: LocaleType.en);
                  },
                ),
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF3A6ED4),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(4.0),
                      bottomRight: Radius.circular(4.0),
                    ),
                  ),
                  padding: EdgeInsets.all(6.0),
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                  ),
                ),
                onTap: () => controller.clear(),
              ),
            ],
          )
        : TextField(
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
              DatePicker.showDatePicker(context,
                  showTitleActions: true,
                  minTime: DateTime.now(),
                  maxTime: DateTime.now().add(Duration(days: 365)),
                  onConfirm: (date) {
                controller.text = DateFormat('yyyy-MM-dd').format(date);
              }, currentTime: DateTime.now(), locale: LocaleType.en);
            },
          );
  }
}
