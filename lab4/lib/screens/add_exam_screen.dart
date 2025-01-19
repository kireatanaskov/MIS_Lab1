import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

import '../models/exam.dart';
import '../providers/exam_provider.dart';

class AddExamScreen extends StatefulWidget {
  final DateTime? selectedDate;

  const AddExamScreen({Key? key, this.selectedDate}) : super(key: key);

  @override
  _AddExamScreenState createState() => _AddExamScreenState();
}

class _AddExamScreenState extends State<AddExamScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _locationController;
  late DateTime _selectedDate;
  TimeOfDay _selectedTime = TimeOfDay.now();
  LatLng? _selectedLocation;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _locationController = TextEditingController();
    _selectedLocation = const LatLng(42.0041, 21.4095);

    _selectedDate = widget.selectedDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Додади нов испит'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Предмет',
                prefixIcon: const Icon(Icons.book, color: Colors.blue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Внесете предмет';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Локација',
                prefixIcon: const Icon(Icons.location_on, color: Colors.blue),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Внесете локација';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            ListTile(
              title: Text(
                  'Датум: ${DateFormat('dd.MM.yyyy').format(_selectedDate)}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: null,
            ),
            ListTile(
              title: Text(
                'Време: ${_selectedTime.format(context)}',
              ),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: _selectedTime,
                );
                if (picked != null) {
                  setState(() {
                    _selectedTime = picked;
                  });
                }
              },
            ),
            const SizedBox(height: 16.0),
            Container(
              height: 300,
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: _selectedLocation!,
                  initialZoom: 13.0,
                  onTap: (tapPosition, point) {
                    setState(() {
                      _selectedLocation = point;
                    });
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  if (_selectedLocation != null)
                    MarkerLayer(
                      markers: [
                        Marker(
                          width: 40.0,
                          height: 40.0,
                          point: _selectedLocation!,
                          child: const Icon(
                            Icons.location_on,
                            color: Colors.red,
                            size: 40.0,
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            if (_selectedLocation != null)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'Избрана локација: ${_selectedLocation!.latitude}, ${_selectedLocation!.longitude}',
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate() &&
                    _selectedLocation != null) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Зачувај Испит'),
                        content: const Text(
                            'Дали сте сигурни дека сакате да го зачувате испитот?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Откажи'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              final event = Exam(
                                id: DateTime.now().toString(),
                                title: _titleController.text,
                                dateTime: DateTime(
                                  _selectedDate.year,
                                  _selectedDate.month,
                                  _selectedDate.day,
                                  _selectedTime.hour,
                                  _selectedTime.minute,
                                ),
                                location: _selectedLocation!,
                                locationName: _locationController.text,
                              );

                              context.read<ExamProvider>().addEvent(event);
                              Navigator.pop(context);
                            },
                            child: const Text('Да'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: const Text('Зачувај'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    super.dispose();
  }
}
