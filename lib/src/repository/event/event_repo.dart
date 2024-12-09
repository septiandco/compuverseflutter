import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compuvers/src/features/dashboard/models/event_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventRepository extends GetxController {
  static EventRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Menambahkan Event baru ke Firestore
  createEvent(EventModel event) async {
    await _db.collection("Events").add(event.toJson()).whenComplete(() {
      Get.snackbar(
        "Success",
        "Event has been created",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.withOpacity(0.1),
        colorText: Colors.green,
      );
    }).catchError((error, stackTrace) {
      Get.snackbar(
        "Error",
        "Something went wrong. Try Again",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
      print("ERROR - $error");
    });
  }

  // Mengambil Detail Event berdasarkan ID
  Future<EventModel> getEventDetails(String eventId) async {
    final snapshot = await _db.collection("Events").doc(eventId).get();
    if (snapshot.exists) {
      return EventModel.fromSnapshot(snapshot);
    } else {
      throw Exception("Event not found");
    }
  }

  // Mengambil Daftar Semua Event
  Future<List<EventModel>> allEvents() async {
    final snapshot = await _db.collection("Events").get();
    final eventData = snapshot.docs.map((e) => EventModel.fromSnapshot(e)).toList();
    return eventData;
  }
}
