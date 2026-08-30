import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../providers/medication_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    final medProvider = Provider.of<MedicationProvider>(context);

    final selectedResults = _selectedDay != null
        ? medProvider.getStatusForDate(_selectedDay!)
        : <Map<String, dynamic>>[];

    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _selectedDay == null
                ? const Center(child: Text('Select a date to see history'))
                : selectedResults.isEmpty
                    ? const Center(child: Text('No records for this day'))
                    : ListView.builder(
                        itemCount: selectedResults.length,
                        itemBuilder: (context, index) {
                          final entry = selectedResults[index];
                          return ListTile(
                            leading: Icon(
                              entry['status'] == 'taken' ? Icons.check_circle : Icons.cancel,
                              color: entry['status'] == 'taken' ? Colors.green : Colors.red,
                            ),
                            title: Text(entry['name']),
                            subtitle: Text(entry['status']),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}