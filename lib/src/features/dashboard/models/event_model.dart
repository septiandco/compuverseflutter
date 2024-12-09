import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String? id;
  final String eventType;
  final String eventName;
  final String eventDescription;
  final String imageUrl;


  const EventModel({
    this.id,
    required this.eventType,
    required this.eventName,
    required this.eventDescription,
    required this.imageUrl,
  });

  // Mengonversi objek EventModel menjadi format JSON untuk disimpan di Firestore
  Map<String, dynamic> toJson() {
    return {
      "EventType": eventType,
      "EventName": eventName,
      "EventDescription": eventDescription,
      "imageUrl": imageUrl,
    };
  }

  // Membaca snapshot dari Firestore dan mengonversinya ke EventModel
  factory EventModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return EventModel(
      id: document.id,
      eventType: data["EventType"],
      eventName: data["EventName"],
      eventDescription: data["EventDescription"],
      imageUrl: data["imageUrl"],
    );
  }
}
