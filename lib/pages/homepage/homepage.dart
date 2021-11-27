import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';

import 'package:twitter_clone/controller/authcontroller.dart';
import 'package:twitter_clone/pages/homepage/tweetlist.dart';
import 'package:twitter_clone/pages/homepage/widgets/addatweet.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final AuthController authController = Get.find();
  final auth = GetxFire.auth;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        endDrawerEnableOpenDragGesture: false,
        appBar: twitterappbar(),
        bottomNavigationBar: bottomappbar(),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Get.to(() => AddaTweet(
                  isUpdate: false,
                ));
          },
        ),
        drawer: cutomdrawer(),
        body: const TweetListBody());
  }

  Widget cutomdrawer() {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              child: Image.network(
            auth.currentUser!.photoURL!,
          )),
          ListTile(
            leading: const Icon(Icons.exit_to_app_outlined),
            title: const Text('Logout'),
            onTap: () async {
              await authController.logout();
            },
          ),
        ],
      ),
    );
  }

  BottomAppBar bottomappbar() {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildBottomIconButton(Icons.home, Colors.blue),
          buildBottomIconButton(Icons.search, Colors.black45),
          buildBottomIconButton(Icons.notifications, Colors.black45),
          buildBottomIconButton(Icons.mail_outline, Colors.black45),
        ],
      ),
    );
  }

  AppBar twitterappbar() {
    return AppBar(
      centerTitle: true,
      title: Image.asset(
        'assets/logo.png',
        height: 25,
        width: 25,
      ),
      backgroundColor: Colors.white,
      elevation: 1,
      leading: InkWell(
        onTap: () {
          _scaffoldKey.currentState!.openDrawer();
        },
        child: Container(
          margin: const EdgeInsets.all(12),
          child: CircleAvatar(
            radius: 8,
            backgroundImage: NetworkImage(auth.currentUser!.photoURL!),
          ),
        ),
      ),
    );
  }

  Widget buildBottomIconButton(IconData icon, Color color) {
    return IconButton(
      icon: Icon(
        icon,
        color: color,
      ),
      onPressed: () {},
    );
  }
}
