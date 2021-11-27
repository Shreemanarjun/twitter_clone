import 'package:flutter/material.dart';

import 'package:getxfire/getxfire.dart';
import 'package:twitter_clone/routes/app_pages.dart';


class AuthGuard extends GetMiddleware {
//   Get the auth service
  var fireauth = GetxFire.auth;

//   The default is 0 but you can update it to any number. Please ensure you match the priority based
//   on the number of guards you have.
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    //for login page
    if (route == Routes.startpage) {
      return fireauth.currentUser == null
          ? null
          : const RouteSettings(name: Routes.homepage);
    }
    //for other pages
    else {
      return fireauth.currentUser == null
          ? const RouteSettings(name: Routes.startpage)
          : null;
    }
  }
}
