import 'package:flutter/material.dart';
import 'package:getxfire/getxfire.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:twitter_clone/routes/app_pages.dart';


class AuthController extends GetxController {
  final FirebaseAuth auth = GetxFire.auth;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final GetxFire getxFire = GetxFire();
  

  Future<void> signInWithGoogle() async {
    await GetxFire.showProgressHud();
    try {
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.disconnect();
      }
    } catch (e) {
     // print(e);
    }

    try {
      await GetxFire.signInWithGoogle(
        isErrorDialog: true,
        isSuccessDialog: true,
        onSuccess: (userCredential) async {
          if (userCredential != null) {
            final user = userCredential.user;
            // This for hide loading progress bar
            await GetxFire.hideProgressHud();
            if (user != null) {
          
              Get.offAllNamed(Routes.homepage);
            } else {
              ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
                content: Text('Failed to create account beacause null user'),
              ));
            }
          }
        },
        onError: (code, message) async {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: Text('Failed to sign in with Google: $message'),
            ),
          );
        },
      );
    } catch (e) {
   //   print(e);
    }
    await GetxFire.hideProgressHud();

    // Once signed in, return the UserCredential
  }

  Future<void> logout() async {
    await GetxFire.showProgressHud();
    try {
      await GetxFire.signOut(isSocialLogout: true);
    } catch (e) {
    //  print(e);
    }

    await GetxFire.hideProgressHud();
    Get.offAllNamed(Routes.startpage);
  }

  Future<void> createAccount() async {

  }
}
