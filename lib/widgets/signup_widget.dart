import 'package:firetest/controllers/auth_controller.dart';
import 'package:firetest/core/adaptives/adaptive_textfield.dart';
import 'package:firetest/core/responsive_body_builder.dart';
import 'package:firetest/core/shared/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupWidget extends StatelessWidget {
  final AuthController googleAuthController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return BuildResponsiveChild(
        child: Stack(
      children: [
        //! background Image
        Container(
          color: Colors.amber,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: getProportionateScreenHeight(20.0),
              ),
              Text(
                "Signup",
                style: TextStyle(
                  fontSize: 22.0,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: getProportionateScreenHeight(20.0),
              ), //!Form
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: AdaptiveTextField(
                  textEditingController: googleAuthController.emailController,
                  textInputType: TextInputType.emailAddress,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(25.0),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 0),
                child: AdaptiveTextField(
                  textEditingController:
                      googleAuthController.passwordController,
                  textInputType: TextInputType.visiblePassword,
                ),
              ),
              SizedBox(
                height: getProportionateScreenHeight(25.0),
              ),

              SizedBox(
                  width: getProportionateScreenWidth(150),
                  child: ElevatedButton(
                    onPressed: () {
                      googleAuthController.createUserWithEmailAndPassword();
                    },
                    child: Text("Signup"),
                  ))
            ],
          ),
        ),
      ],
    ));
  }
}
