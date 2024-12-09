import 'package:compuvers/src/constants/colors.dart';
import 'package:compuvers/src/constants/image_strings.dart';
import 'package:compuvers/src/constants/sizes.dart';
import 'package:compuvers/src/constants/text_strings.dart';
import 'package:compuvers/src/features/dashboard/controller/profile_controller.dart';
import 'package:compuvers/src/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateProfile extends StatelessWidget {
  const UpdateProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    // Menambahkan RxBool untuk mengontrol status visibility password
    RxBool obscurePassword = true.obs;

    return Scaffold(
      appBar: AppBar(title: Text(cEditProfile, style: Theme.of(context).textTheme.headlineMedium),),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(cDefaultSize),
          child: FutureBuilder(
            future: controller.getUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  UserModel userData = snapshot.data as UserModel;

                  final email = TextEditingController(text: userData.email);
                  final fullName = TextEditingController(text: userData.fullName);
                  final password = TextEditingController(text: userData.password);

                  return Column(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: const Image(image: AssetImage(cProfilePict)),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Form(
                        child: Column(
                          children: [
                            // Full Name Field - Disabled
                            TextFormField(
                              controller: fullName,
                              enabled: false, // Disable the full name input
                              decoration: const InputDecoration(
                                label: Text(cFullName),
                                prefixIcon: Icon(Icons.person),
                                hintText: 'Name cannot be edited',
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Email Field - Disabled
                            TextFormField(
                              controller: email,
                              enabled: false, // Disable the email input
                              decoration: const InputDecoration(
                                label: Text(cEmail),
                                prefixIcon: Icon(Icons.email),
                                hintText: 'Email cannot be edited',
                              ),
                            ),
                            const SizedBox(height: 20),
                            // Password Field - Editable with Eye Icon
                            Obx(() {
                              return TextFormField(
                                controller: password,
                                obscureText: obscurePassword.value, // Use RxBool for visibility
                                decoration: InputDecoration(
                                  label: const Text(cPwd),
                                  prefixIcon: const Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      obscurePassword.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                    ),
                                    onPressed: () {
                                      obscurePassword.value =
                                      !obscurePassword.value;
                                    },
                                  ),
                                ),
                              );
                            }),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (userData.id == null) {
                                    Get.snackbar(
                                      "Error",
                                      "User ID is missing",
                                      snackPosition: SnackPosition.TOP,
                                    );
                                    return;
                                  }

                                  final updatedUserData = UserModel(
                                    id: userData.id, // Ensure ID is included
                                    email: email.text.trim(), // Email remains the same
                                    fullName: fullName.text.trim(), // Full name remains the same
                                    password: password.text.trim(), // Update the password
                                  );

                                  await controller.updateRecord(updatedUserData);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: cPrimaryColor,
                                  side: BorderSide.none,
                                  shape: const StadiumBorder(),
                                ),
                                child: const Text(cEditProfile, style: TextStyle(color: cWhiteColor)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30.0),
                    ],
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
        ),
      ),
    );
  }
}
