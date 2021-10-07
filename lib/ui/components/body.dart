import 'package:flutter/material.dart';
import 'package:heath_care/model/message.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/socket/websocket.dart';

import 'chat_input_field.dart';

class Body extends StatelessWidget {
  Future<User?> _currentUser = UserRepository().getCurrentUser();
  late final ChatService chatService;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: _currentUser,
        builder: (context, snapshotUser) {
          if (snapshotUser.hasData) {
            chatService = ChatService(snapshotUser.data?.username!);
            chatService.activeChat();
            return Column(
              children: [
                Expanded(
                  child: StreamBuilder<List<Message>>(
                      stream: chatService.chatStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                if (snapshot.data?[index].userName ==
                                    snapshotUser.data?.username) {
                                  return Container(
                                      alignment: Alignment.centerRight,
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                      child: Text(
                                          snapshot.requireData[index].content));
                                }
                                return Container(
                                    alignment: Alignment.centerLeft,
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    child: Text(
                                        snapshot.requireData[index].content));
                              });
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ),
                ChatInputField((message) {
                  print('press');
                 chatService.sendMessage(message);
                }),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
