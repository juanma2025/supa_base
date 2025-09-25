import 'package:flutter/material.dart';

class DateSelector extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const DateSelector({super.key, required this.onDateSelected});

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime? selectedDate;

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(selectedDate == null
            ? "Seleccionar fecha"
            : "Fecha: ${selectedDate!.toLocal()}".split(' ')[0]),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: _pickDate,
          child: const Text("Elegir"),
        ),
      ],
    );
  }
}
