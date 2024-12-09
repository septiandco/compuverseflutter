import 'package:cloud_firestore/cloud_firestore.dart';
class UserModel{
  final String? id;
  final String fullName;
  final String email;
  final String password;

  const UserModel({
    this.id,
    required this.email,
    required this.fullName,
    required this.password,
  });

  toJson(){
    return{
      "FullName": fullName,
      "Email": email,
      "Password": password,
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document){
    final data = document.data()!;
    return UserModel(
        id: document.id,
        email: data["Email"],
        fullName:data["FullName"],
        password: data["Password"],
    );
  }
}