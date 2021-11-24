import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heath_care/model/user.dart';

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
        CollectionReference chats =
            FirebaseFirestore.instance.collection('chats');
        chats
            .where('participants', arrayContains: currentUserName)
            .get()
            .then((value) {
          QueryDocumentSnapshot? chatDocument;
          List results = value.docs.where((element) {
            return (element['participants'].toString())
                .contains(pattients.username.toString());
          }).toList();
          if (results.isNotEmpty) chatDocument = results.first;

          if (value.docs.length > 0 && chatDocument != null) {
            navigatorToConversation(context, chatDocument.reference);
          } else {
            chats
                .add({
                  'messages': [],
                  'participants': [currentUserName, pattients.username],
                  'updated_time': Timestamp.now(),
                })
                .then((value) => navigatorToConversation(context, value))
                .catchError((error) => print("Failed to add user: $error"));
          }
        });
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
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                        ),
                      )
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
              Opacity(
                opacity: 0.64,
                child: Text(
                  "Online",
                  style: TextStyle(fontSize: 12),
                ),
              )
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
