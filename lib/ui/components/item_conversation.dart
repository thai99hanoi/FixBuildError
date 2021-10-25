import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/components/item_image_avatar.dart';
import 'package:heath_care/utils/time_util.dart';

import '../chat_conversation.dart';

class ItemConversation extends StatelessWidget {
  String friendName;
  QueryDocumentSnapshot chatDocument;
  late final Future<User?> friend;
  Map<String, dynamic> lastMessage;
  bool isSeen;

  ItemConversation(
      this.chatDocument, this.friendName, this.lastMessage, this.isSeen) {
    print('khoi tao lai');
    friend = UserRepository().getUserByUserName(friendName);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: friend,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildItem(context, snapshot.data!);
          }
          return buildItem(context, User(username: friendName));
        });
  }

  Padding buildItem(BuildContext context, User user) {
    String prefix = lastMessage['from'] == friendName
        ? user.getLastName() + ": "
        : "Bạn: ";
    bool isSeen = this.isSeen || lastMessage['from'] != friendName;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20 * 0.75),
      child: InkWell(
        onTap: () {
          Route route = MaterialPageRoute(
              builder: (context) =>
                  ConversationChat(chatDocument.reference, user));
          Navigator.push(context, route);
        },
        child: Row(
          children: [
            ItemAvatarNetworkImage(image: user.avatar),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.getDisplayName(),
                    style: getTextStyle(isSeen, 15.0),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    lastMessage['content']
                            .toString()
                            .contains("data:image;")
                        ?prefix+ "Đã gửi 1 hình ảnh"
                        : prefix + lastMessage['content'],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getTextStyle(isSeen, 13),
                  ),
                ],
              ),
            )),
            Text(
              getTimeMess(lastMessage['created_time']),
              style: getTextStyle(isSeen, 12),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle getTextStyle(bool isSeen, double fontSize) {
    return isSeen
        ? TextStyle(color: Colors.black87)
        : TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: fontSize);
  }
}
