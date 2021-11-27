import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';
import 'package:intl/intl.dart';
import 'package:twitter_clone/controller/twittercontroller.dart';
import 'package:twitter_clone/pages/homepage/widgets/addatweet.dart';

class TweetListBody extends GetView<TwitterController> {
  const TweetListBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (tweets) => tweets != null
          ? ListView.builder(
              itemCount: tweets.length,
              itemBuilder: (context, index) {
                var tweet = tweets[index];
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.account_circle,
                              size: 50.0,
                              color: Colors.grey,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: RichText(
                                          text: TextSpan(children: [
                                            const TextSpan(
                                              text: "@arjun",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14.0,
                                                  color: Colors.black),
                                            ),
                                            const TextSpan(
                                                text: " ",
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.grey)),
                                            TextSpan(
                                                text: DateFormat("MMMM d h:m:s")
                                                    .format(DateTime.parse(tweet
                                                            .currentdatetime!)
                                                        .toLocal()),
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.grey))
                                          ]),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        flex: 5,
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 4.0),
                                          child: IconButton(
                                            onPressed: () {
                                              Get.bottomSheet(Container(
                                                color: Colors.white,
                                                child: ListTile(
                                                  leading: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ),
                                                  title: const Text(
                                                      'Delete tweet'),
                                                  onTap: () {
                                                    controller.deleteATweet(
                                                        tweet.tweetid!);
                                                  },
                                                ),
                                              ));
                                            },
                                            icon: const Icon(
                                              Icons.more_vert,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                        flex: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Wrap(
                                    children: [
                                      Text(
                                        tweet.tweet ?? "",
                                        style: const TextStyle(fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      const FaIcon(
                                        FontAwesomeIcons.comment,
                                        color: Colors.grey,
                                        size: 14,
                                      ),
                                      const FaIcon(
                                        FontAwesomeIcons.retweet,
                                        color: Colors.grey,
                                        size: 14,
                                      ),
                                      const FaIcon(
                                        FontAwesomeIcons.heart,
                                        color: Colors.grey,
                                        size: 14,
                                      ),
                                      const FaIcon(
                                        FontAwesomeIcons.shareAlt,
                                        color: Colors.grey,
                                        size: 14,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(
                                              () => AddaTweet(isUpdate: true),
                                              arguments: tweet);
                                        },
                                        child: const Icon(
                                          Icons.edit,
                                          size: 18,
                                          color: Colors.green,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                  ],
                );
              },
            )
          : const Center(child: Text('No Tweets')),
      onEmpty: const Center(child: Text('No Tweets')),
      onError: (error) {
        return const Center(child: Text('error'));
      },
    );
  }
}
