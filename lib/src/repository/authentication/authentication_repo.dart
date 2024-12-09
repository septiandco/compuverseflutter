import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compuvers/src/features/dashboard/screen/dashboard.dart';
import 'package:compuvers/src/features/authentication/screen/welcome/welcome_screen.dart';
import 'package:compuvers/src/repository/authentication/exception/login_exception.dart';
import 'package:compuvers/src/repository/authentication/exception/signup_exception.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  final _auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;


  @override
  void onReady() {

    firebaseUser = Rx<User?>(_auth.currentUser);
    firebaseUser.bindStream(_auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user){
    user == null ? Get.offAll(() => const WelcomeScreen()) : Get.offAll(() => const UserDashboard());
  }

  Future<void> createUserWithEmailAndPassword(String email, String password) async{
    try{
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null ? Get.offAll(()=> const UserDashboard()) : Get.to(()=> const WelcomeScreen());
    } on FirebaseAuthException catch(e){
      final ex = SignUpWithEmailAndPasswordFailure.code(e.code);
      print('Exception: - ${ex.message}');
      throw ex;
    } catch (_){
      const ex = SignUpWithEmailAndPasswordFailure();
      print('Exception: - ${ex.message}');
      throw ex;
    }
  }
  Future<void> LogInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final ex = LogInWithEmailAndPasswordFailure.code(e.code);
      print('Exception: - ${ex.message}');
      throw ex;
    } catch (_) {
      const ex = LogInWithEmailAndPasswordFailure();
      print('Exception: - ${ex.message}');
      throw ex;
    }
  }


  Future<void> logout() async => await _auth.signOut();
}