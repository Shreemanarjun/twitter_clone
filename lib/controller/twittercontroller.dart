import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';
import 'package:twitter_clone/data/model/tweet_model.dart';

class TwitterController extends GetxController
    with StateMixin<List<TweetModel>> {
  final firestore = GetxFire.firestore;

  @override
  void onInit() async {
    gettweetstreams().listen(
        (tweets) {
          //   print(tweets.length);
          if (tweets.isEmpty) {
            change(null, status: RxStatus.empty());
          } else {
            change(tweets, status: RxStatus.success());
          }
        },
        cancelOnError: true,
        onDone: () {},
        onError: (e) {
          // print(e);
          change(null,
              status: RxStatus.error(
                e.toString(),
              ));
        });
    super.onInit();
  }

  Stream<List<TweetModel>> gettweetstreams() {
    Stream<QuerySnapshot> tweetsstream =
        firestore.streamData(collection: 'tweets');

    return tweetsstream.map((queryshot) => queryshot.docs.map((doc) {
          // print((doc.data()));
          var map = doc.data() as Map;
          return TweetModel(
            tweetid: map['tweetid'],
            tweet: map['tweet'],
            currentdatetime:
                DateTime.parse(map['currentdatetime']).toLocal().toString(),
            userid: map['userid'],
          );
        }).toList());
  }

  Future<void> addAtweet({required String tweetdata}) async {
    var tweetcollection = FirebaseFirestore.instance.collection('tweets');

    var tweet = TweetModel(
        currentdatetime: DateTime.now().toLocal().toString(),
        tweet: tweetdata,
        userid: GetxFire.currentUser!.uid);

    try {
      await tweetcollection.add(tweet.toMap()).then((value) async {
        await tweetcollection.doc(value.id).update({'tweetid': value.id});
      });

      Get.back();
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Tweet added successfully'),
        backgroundColor: Colors.green,
      ));
    } catch (e) {
     // print(e);
    }
  }

  Future<void> updateaTweet(
      {required String tweetid, required String tweetdata}) async {
    var isupdated = await firestore.updateData(
        collection: 'tweets',
        id: tweetid,
        data: {
          'tweet': tweetdata,
          'currentdatetime': DateTime.now().toString()
        });
    if (isupdated) {
      Get.back();
      ScaffoldMessenger.of(Get.context!).showSnackBar(const SnackBar(
        content: Text('Tweet updated successfully'),
        backgroundColor: Colors.green,
      ));
    }
  }

  Future<void> deleteATweet(String tweetid) async {
    await firestore.deleteData(collection: 'tweets', id: tweetid);
    Get.back();
  }
}
