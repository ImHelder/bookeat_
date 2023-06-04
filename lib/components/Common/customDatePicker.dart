import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({super.key, required this.getDate});

  final Function getDate;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    dateController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 200,
      child: TextField(
          controller: dateController,
          decoration: const InputDecoration(
              icon: Icon(Icons.calendar_today),
              labelText: "Choisissez une date"),
          readOnly: true,
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 180)));
            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              setState(() {
                dateController.text = formattedDate;
                widget.getDate(formattedDate);
              });
            } else {
              print("Date is not selected");
            }
          }),
    );
  }
}
