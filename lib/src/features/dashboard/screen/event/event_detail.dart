import 'package:compuvers/src/constants/text_strings.dart';
import 'package:compuvers/src/features/dashboard/controller/event_controller.dart';
import 'package:compuvers/src/features/dashboard/models/event_model.dart';
import 'package:compuvers/src/features/dashboard/screen/event/crud/edit_event.dart';
import 'package:compuvers/src/repository/authentication/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventDetailPage extends StatelessWidget {
  final EventModel event;

  // Constructor to accept event data
  const EventDetailPage({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final authRepo = AuthenticationRepository.instance;
    final controller = Get.put(EventController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          cEditProfile,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        actions: [
          Obx(() {
            final user = authRepo.firebaseUser.value;
            if (user != null && user.email == 'septiandwica@gmail.com') {
              return IconButton(
                icon: Icon(Icons.edit),
                onPressed: () async {
                  // Navigate to the EventDetailPage
                  // Pass the current event to the EventDetailPage
                  await Get.to(() => EditEventPage());
                },
              );
            } else {
              return SizedBox.shrink(); // Tidak menampilkan tombol jika tidak sesuai
            }
          }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                event.imageUrl ?? 'assets/images/default.png',  // Use event's image or default
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 20.0),

            // Event Title
            Text(
              event.eventName ?? 'No Title',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),

            // Event Description
            Text(
              event.eventDescription ?? 'No Description',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20.0),

            // RSVP Button
            ElevatedButton(
              onPressed: () {
                // RSVP button action
                print('RSVP button pressed');
              },
              style: ElevatedButton.styleFrom(
                shape: StadiumBorder(),
              ),
              child: Text('RSVP'),
            ),
          ],
        ),
      ),
    );
  }
}
