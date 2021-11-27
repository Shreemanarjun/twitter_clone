import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/controller/authcontroller.dart';


class GoogleSignInPage extends StatelessWidget {
  GoogleSignInPage({Key? key}) : super(key: key);
  final AuthController signInController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Twitter"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: SizedBox(
              width: 100,
              child: SignInButton(
                Buttons.GoogleDark,
                onPressed: () async {
                  await signInController.signInWithGoogle();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
