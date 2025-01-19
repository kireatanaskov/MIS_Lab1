import 'package:flutter/material.dart';
import 'package:lab4/providers/exam_provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'add_exam_screen.dart';
import 'map_screen.dart';

class CalendarScreen extends StatefulWidget {
  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Календар'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2025, 1, 1),
              lastDay: DateTime.utc(2025, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: CalendarFormat.month,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              eventLoader: (day) {
                return context.read<ExamProvider>().getEventsForDay(day);
              },
              headerStyle: const HeaderStyle(
                titleCentered: true,
                leftChevronIcon: Icon(Icons.chevron_left, color: Colors.red),
                rightChevronIcon: Icon(Icons.chevron_right, color: Colors.red),
                formatButtonVisible: false,
              ),
              calendarStyle: const CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Colors.redAccent,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  weekendTextStyle: TextStyle(color: Colors.red)),
              availableGestures: AvailableGestures.none,
            ),
            Expanded(
              child: Consumer<ExamProvider>(
                  builder: (context, examProvider, child) {
                final exams = _selectedDay != null
                    ? examProvider.getEventsForDay(_selectedDay!)
                    : [];

                if (exams.isEmpty) {
                  return const Center(
                    child: Text('Нема закажани испити на овој ден',
                        style: TextStyle(fontSize: 16)),
                  );
                }
                return ListView.separated(
                  itemCount: exams.length,
                  itemBuilder: (context, index) {
                    final exam = exams[index];

                    final formattedDateTime =
                        DateFormat('yyyy-MM-dd HH:mm').format(exam.dateTime);

                    return ListTile(
                      title: Text(exam.title,
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('$formattedDateTime - ${exam.location}'),
                      leading: const Icon(Icons.event, color: Colors.green),
                      trailing: TextButton(
                          style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side: const BorderSide(
                                    color: Colors.blue, width: 2),
                              )),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MapScreen(exam: exam),
                              ),
                            );
                          },
                          child: const Text(
                            'Добиј насоки',
                            style: TextStyle(color: Colors.blue),
                          )),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                );
              }),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddExamScreen(selectedDate: _selectedDay),
              ),
            );
          },
          label: const Text('Додади испит'),
          icon: const Icon(Icons.add),
        ));
  }
}
