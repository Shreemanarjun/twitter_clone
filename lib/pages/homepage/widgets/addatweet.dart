import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:getxfire/getxfire.dart';
import 'package:twitter_clone/controller/twittercontroller.dart';
import 'package:twitter_clone/data/model/tweet_model.dart';

class AddaTweet extends StatelessWidget {
  AddaTweet({Key? key, required this.isUpdate}) : super(key: key);
  final tweetmessagecontroller = TextEditingController();
  final TwitterController twittercontroller = Get.find();
  final bool isUpdate;
  final tweetModel = TweetModel().obs;
  final _formKey = GlobalKey<FormState>();
  void checkUpdateScreen() {
    if (isUpdate) {
      tweetModel.value = Get.arguments;
      tweetmessagecontroller.text = tweetModel.value.tweet!;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkUpdateScreen();
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          child: Row(
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close)),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ClipRRect(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      fixedSize: const Size.fromHeight(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: const BorderSide(color: Colors.blue),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (isUpdate) {
                          twittercontroller.updateaTweet(
                              tweetid: tweetModel.value.tweetid!,
                              tweetdata: tweetmessagecontroller.text);
                        } else {
                          await twittercontroller.addAtweet(
                              tweetdata: tweetmessagecontroller.text);
                        }
                      }
                    },
                    child: isUpdate
                        ? const Text('Update Tweet')
                        : const Text('Tweet'),
                  ),
                ),
              )
            ],
          ),
          preferredSize: const Size.fromHeight(80),
        ),
        body: Row(
          children: [
            Flexible(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        NetworkImage(GetxFire.currentUser!.photoURL!),
                  )
                ],
              ),
            )),
            Flexible(
                flex: 7,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: Form(
                          key: _formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: TextFormField(
                            controller: tweetmessagecontroller,
                            maxLines: null,
                            expands: true,
                            keyboardType: TextInputType.multiline,
                            maxLength: 280,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Enter a tweet here',
                              
                            ),
                            validator: ValidationBuilder()
                                .required()
                                .maxLength(280)
                                .build(),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
