import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:heath_care/firebase/chat_firebase.dart';
import 'package:heath_care/model/message.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/components/item_image.dart';
import 'package:heath_care/utils/image_util.dart';

import 'chat_input_field.dart';

class Body extends StatefulWidget {
  DocumentReference chatDocument;

  Body(this.chatDocument);

  @override
  State<StatefulWidget> createState() {
    return _BodyState();
  }
}

class _BodyState extends State<Body> {
  Future<User?> _currentUser = UserRepository().getCurrentUser();

  bool isProgressImage = false;
  bool hasErrorImage = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: _currentUser,
        builder: (context, snapshotUser) {
          if (snapshotUser.hasData) {
            return Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                      stream: widget.chatDocument.snapshots(),
                      builder:
                          (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if (snapshot.hasData &&
                            (snapshot.data!['messages'] as List).isNotEmpty) {
                          List messages = snapshot.data!['messages'] as List;

                          return buildListMessage(
                              messages, snapshotUser, snapshot);
                        } else {
                          return Center(
                              child: Text("Bắt đầu trò chuyện ngay thôi!"));
                        }
                      }),
                ),
                ChatInputField(
                      (content) async {
                    Message message = Message(
                        snapshotUser.data!.username!, content, Timestamp.now());
                    await ChatFireBase.getInstance()
                        .sendMessage(message, widget.chatDocument);
                    setState(() {
                      clearStatus();
                    });
                  },
                  onProgress: () {
                    setState(() {
                      isProgressImage = true;
                    });
                  },
                  onErrorImage: () {
                    setState(() {
                      hasErrorImage = true;
                    });
                  },
                  onDone: () {
                    clearStatus();
                  },
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }

  ListView buildListMessage(List messages, AsyncSnapshot<User?> snapshotUser,
      AsyncSnapshot<DocumentSnapshot<Object?>> snapshot) {
    return ListView.builder(
        shrinkWrap: true,
        reverse: true,
        itemCount: isProgressImage ? messages.length + 1 : messages.length,
        itemBuilder: (context, index) {
          if (index == 0 &&
              messages[messages.length - 1]['from'] !=
                  snapshotUser.data?.username) {
            ChatFireBase.getInstance().seenMessage(widget.chatDocument);
          }
          if (index == 0 && isProgressImage) {
            return Container(
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width * 0.7,
                child: buildTextStatus());
          }

          int indexMessage = isProgressImage
              ? messages.length - index
              : messages.length - index - 1;
          if (messages[indexMessage]['from'] == snapshotUser.data?.username) {
            return Container(
                alignment: Alignment.centerRight,
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      buildMessage(context, messages[indexMessage]['content'],
                          Colors.blue, Colors.white,
                          status: index == 0 ? snapshot.data!['status'] : null),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(),
                            Visibility(
                                visible: index == 0,
                                child: Text(
                                  snapshot.data!['status'].toString(),
                                  style: TextStyle(fontSize: 12),
                                )),
                          ],
                        ),
                      ),
                    ]));
          }

          return Container(
              alignment: Alignment.centerLeft,
              width: MediaQuery.of(context).size.width * 0.7,
              child: buildMessage(context, messages[indexMessage]['content'],
                  Colors.grey.shade300, Colors.black));
        });
  }

  void clearStatus() {
    setState(() {
      isProgressImage = false;
      hasErrorImage = false;
    });
  }

  Widget buildTextStatus() {
    if (isProgressImage && !hasErrorImage)
      return Text("Đang tải lên 1 ảnh...");
    else if (hasErrorImage)
      return Text(
        "Không thể tải ảnh lên",
        style: TextStyle(color: Colors.red),
      );
    return SizedBox(
      height: 1,
    );
  }

  Widget buildMessage(
      BuildContext context, String content, Color background, Color textColor,
      {String? status}) {
    bool isImage = content.contains("data:image;");
    return Padding(
        padding: const EdgeInsets.all(4),
        child: Container(
          constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: isImage ? Colors.transparent : background,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: isImage
              ? ItemNetworkImage(image: content.replaceFirst("data:image;", ""))
              : Text(
            content,
            style: TextStyle(color: textColor),
          ),
        ));
  }
}