import 'package:flutter/material.dart';

class RSVPListPage extends StatelessWidget {
  final String eventId;

  RSVPListPage({required this.eventId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RSVP List'),
      ),
      body: FutureBuilder(
        // Ganti dengan logika untuk mengambil daftar RSVP menggunakan `eventId`
        future: _fetchRSVPList(eventId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // Asumsikan data yang diterima adalah List<String> (list nama orang yang RSVP)
            List<String> rsvpList = snapshot.data as List<String>;
            return ListView.builder(
              itemCount: rsvpList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(rsvpList[index]),
                );
              },
            );
          } else {
            return Center(child: Text('No RSVP found.'));
          }
        },
      ),
    );
  }

  // Simulasi fungsi untuk mengambil data RSVP dari API atau database
  Future<List<String>> _fetchRSVPList(String eventId) async {
    // Gantilah dengan logika yang sesungguhnya untuk mengambil data RSVP berdasarkan eventId
    await Future.delayed(Duration(seconds: 2)); // Simulasi delay
    return ['John Doe', 'Jane Smith', 'Alice Brown']; // Contoh data RSVP
  }
}
