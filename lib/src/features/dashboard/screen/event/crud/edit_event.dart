import 'package:compuvers/src/features/dashboard/controller/event_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditEventPage extends StatefulWidget {
  @override
  _EditEventPageState createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  final _formKey = GlobalKey<FormState>();
  String? _eventType;
  String? _eventName;
  String? _eventDescription;
  String? _imageUrl;

  // Daftar tipe event
  final List<String> _eventTypes = ['Conference', 'Workshop', 'Seminar', 'Webinar'];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EventController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Input Tipe Event dengan Dropdown
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Tipe Event',
                  border: OutlineInputBorder(),
                ),
                value: _eventType,
                onChanged: (String? newValue) {
                  setState(() {
                    _eventType = newValue;
                  });
                },
                items: _eventTypes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an event type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),

              // Input Nama Event
              TextFormField(
                controller: controller.eventName,
                decoration: InputDecoration(
                  labelText: 'Nama Event',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _eventName = value;
                },
              ),
              SizedBox(height: 16.0),

              // Input Event Description
              TextFormField(
                controller: controller.eventDescription,
                decoration: InputDecoration(
                  labelText: 'Event Description',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an event description';
                  }
                  return null;
                },
                onSaved: (value) {
                  _eventDescription = value;
                },
              ),
              SizedBox(height: 16.0),

              // Input Image URL
              TextFormField(
                controller: controller.imageUrl,
                decoration: InputDecoration(
                  labelText: 'Image URL',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an image URL';
                  }
                  return null;
                },
                onSaved: (value) {
                  _imageUrl = value;
                },
              ),
              SizedBox(height: 32.0),

              // Tombol Submit
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    // Menambahkan logika untuk menyimpan event
                    print('Event Type: $_eventType');
                    print('Event Name: $_eventName');
                    print('Event Description: $_eventDescription');
                    print('Image URL: $_imageUrl');

                    // Panggil fungsi untuk menambah event melalui EventController
                    controller.addEvent(_eventType!, _eventName!, _eventDescription!, _imageUrl!);

                    // Kembali ke halaman sebelumnya atau lakukan aksi lainnya
                    Navigator.pop(context);
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
