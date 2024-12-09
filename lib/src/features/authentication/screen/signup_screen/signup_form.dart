import 'package:compuvers/src/constants/text_strings.dart';
import 'package:compuvers/src/features/authentication/controllers/signup_controller.dart';
import 'package:compuvers/src/features/authentication/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignupForm extends StatelessWidget {
  const SignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: controller.fullName,

                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline_outlined),
                  labelText: cFullName,
                  hintText: cFullName,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20.0),
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
              const SizedBox(height: 20.0,),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: (){
                      if(_formKey.currentState!.validate()){

                        final user = UserModel(
                            email: controller.email.text.trim(),
                            fullName: controller.fullName.text.trim(),
                            password: controller.password.text.trim());
                        SignUpController.instance.createUser(user);
                      }
                    },
                    child: Text(cSignUp.toUpperCase())
                ),
              )
            ],
          ),
        )
    );
  }
}