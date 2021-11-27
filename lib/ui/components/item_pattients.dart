import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/ui/pattient_detail.dart';

import '../chat_conversation.dart';
import 'item_image_avatar.dart';

class ItemPatttients extends StatelessWidget {
  User pattients;
  String currentUserName;

  ItemPatttients(this.pattients, this.currentUserName);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PattientDetail(userName: pattients.username.toString()),
          ),
        );
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      ItemAvatarNetworkImage(image: pattients.avatar),
                    ],
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Text(
                    pattients.getDisplayName(),
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  void navigatorToConversation(
      BuildContext context, DocumentReference chatDocument) {
    Route route = MaterialPageRoute(
        builder: (context) => ConversationChat(chatDocument, pattients));
    Navigator.push(context, route);
  }
}
