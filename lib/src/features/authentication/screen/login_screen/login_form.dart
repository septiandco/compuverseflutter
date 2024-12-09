import 'package:compuvers/src/constants/text_strings.dart';
import 'package:compuvers/src/features/authentication/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                labelText: cEmail,
                hintText: cEmail,
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20.0),
            TextFormField(
              controller: controller.password,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock_outline_rounded),
                labelText: cPwd,
                hintText: cPwd,
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: null, 
                  icon: Icon(Icons.remove_red_eye_sharp)
                )
              ),
            ),
            const SizedBox(height: 5.0,),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: (){}, 
                child: const Text(cForgotPwd),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:() => controller.login(),
                child: Text(cLogin.toUpperCase())
              ),
            )
          ],
        ),
      )
    );
  }
}