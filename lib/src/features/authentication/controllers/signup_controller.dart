import 'package:compuvers/src/features/authentication/models/user_model.dart';
import 'package:compuvers/src/repository/authentication/authentication_repo.dart';
import 'package:compuvers/src/repository/user/user_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();

  final userRepo = Get.put(UserRepository());

  Future<void> createUser(UserModel user) async{
    await userRepo.createUser(user);
    registerUser(user.email, user.password);
  }
  void registerUser(String email, String password){
    AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);
  }
}