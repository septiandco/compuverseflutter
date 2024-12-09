import 'package:compuvers/src/features/dashboard/models/event_model.dart';
import 'package:compuvers/src/repository/event/event_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EventController extends GetxController {
  static EventController get instance => Get.find();

  final eventType = TextEditingController();
  final eventName = TextEditingController();
  final eventDescription = TextEditingController();
  final imageUrl = TextEditingController();

  final _eventRepo = Get.put(EventRepository());

  // Fungsi untuk membuat event baru
  Future<void> createEvent(EventModel event) async {
    await _eventRepo.createEvent(event);
  }

  // Fungsi untuk menambahkan event berdasarkan data input dari form
  void addEvent(String eventType, String eventName, String eventDescription, String imageUrl) {
    final newEvent = EventModel(
      eventType: eventType, // eventType from form
      eventName: eventName, // eventName from form
      eventDescription: eventDescription, // eventDescription from form
      imageUrl: imageUrl, // imageUrl from form
    );

    createEvent(newEvent);
  }

  Future<EventModel> getEventData(String eventId) async {
    try {
      final event = await _eventRepo.getEventDetails(eventId);
      return event;  // Mengembalikan event yang ditemukan
    } catch (e) {
      print('Error fetching event: $e');
      throw Exception('Event not found');  // Mengatasi error dan memberikan pesan yang sesuai
    }
  }

  Future<List<EventModel>> getAllEvents() async{
    return await _eventRepo.allEvents();
  }
  // Bersihkan controller setelah selesai


}
