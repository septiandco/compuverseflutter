import 'package:compuvers/src/constants/colors.dart';
import 'package:compuvers/src/constants/text_strings.dart';
import 'package:compuvers/src/features/dashboard/controller/event_controller.dart';
import 'package:compuvers/src/features/dashboard/models/event_model.dart';
import 'package:compuvers/src/features/dashboard/screen/event/crud/add_event.dart';
import 'package:compuvers/src/repository/authentication/authentication_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'event_detail.dart';

class EventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authRepo = AuthenticationRepository.instance;
    final controller = Get.put(EventController());

    return Scaffold(
      appBar: AppBar(
        title: Text(cEventPage, style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          Obx(() {
            final user = authRepo.firebaseUser.value;
            if (user != null && user.email == 'septiandwica@gmail.com') {
              return IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // Navigate to the AddEventPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddEventPage()),
                  );
                },
              );
            } else {
              return SizedBox.shrink();
            }
          }),
        ],
      ),
      body: FutureBuilder<List<EventModel>>(
        future: controller.getAllEvents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (c, index) {
                  final event = snapshot.data![index];  // Get the event at this index
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    elevation: 1.0,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              event.imageUrl ?? 'assets/images/default.png',
                              width: MediaQuery.of(context).size.width,  // Use the full width of the screen
                              height: 200.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 16.0),

                          // Event name and description
                          Text(
                            event.eventName ?? 'No Title',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            event.eventType ?? 'No Type',
                            style: Theme.of(context).textTheme.bodyMedium
                          ),
                          SizedBox(height: 4.0),
                          Text(
                            event.eventDescription.split(' ')
                                .take(10)  // Display up to 10 words
                                .join(' ') + (event.eventDescription.split(' ').length > 10 ? '...' : ''),
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.grey,
                            ),
                          ),

                          // Button with "More" text and arrow icon
                          InkWell(
                            onTap: () async {
                              // Navigate to the EventDetailPage
                              // Pass the current event to the EventDetailPage
                              await Get.to(() => EventDetailPage(event: event));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  "More",
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.blue,
                                  ),
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  size: 20.0,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              return const Center(child: Text("Something went wrong"));
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
