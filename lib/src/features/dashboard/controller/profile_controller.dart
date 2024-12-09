import 'package:compuvers/src/features/authentication/models/user_model.dart';
import 'package:compuvers/src/repository/authentication/authentication_repo.dart';
import 'package:compuvers/src/repository/user/user_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController{
  static ProfileController get instance => Get.find();



  final _authRepo = Get.put(AuthenticationRepository());
  final _userRepo = Get.put(UserRepository());

  getUserData(){
    final email = _authRepo.firebaseUser.value?.email;
    if(email != null){
      return _userRepo.getUserDetails(email);
    } else{
      Get.snackbar("Error", "Login to Continue");
    }
  }

  Future<List<UserModel>> getAllUser() async{
    return await _userRepo.allUser();
  }

  updateRecord(UserModel user) async{
    await _userRepo.updateUserRecord(user);
  }
}