import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compuvers/src/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();
  
  final _db = FirebaseFirestore.instance;

  
  createUser(UserModel user) async {
    await _db.collection("Users").add(user.toJson()).whenComplete(
        () => Get.snackbar("Success", "Your Account Has been Created",
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.green.withOpacity(0.1),
              colorText: Colors.green),

    )
    .catchError((error, stackTrace){
      Get.snackbar("Error", "Something went wrong. Try Again",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(0.1),
          colorText: Colors.red);
      print("ERROR - $error");
    });
  }

  Future<UserModel> getUserDetails(String email) async{
    final snapshot = await _db.collection("Users").where("Email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    return userData;
  }
  Future<List<UserModel>> allUser() async{
    final snapshot = await _db.collection("Users").get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }

  Future<void> updateUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).update(user.toJson());
      print("User updated successfully");

      // Menampilkan snackbar setelah rendering frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.snackbar(
          "Success",
          "Profile Updated",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green.withOpacity(0.8),  // Background dengan warna hijau dan sedikit transparansi
          colorText: Colors.white,  // Warna teks menjadi putih agar kontras dengan background
          borderRadius: 10.0,  // Menambahkan border radius agar sudut snackbar lebih melengkung
          margin: EdgeInsets.all(16.0),  // Menambahkan margin agar snackbar tidak terlalu menempel ke sisi layar
          icon: Icon(Icons.check_circle, color: Colors.white),  // Menambahkan ikon check-circle untuk visualisasi sukses
          snackStyle: SnackStyle.FLOATING,  // Memungkinkan snackbar untuk tampil lebih di atas
        );
      });
    } catch (e) {
      print("Error: $e");
      Get.snackbar(
        "Error",
        "Something went wrong. Try Again",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.withOpacity(0.1),
        colorText: Colors.red,
      );
    }
  }
}