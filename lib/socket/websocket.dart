import 'dart:async';
import 'dart:convert';

import 'package:heath_care/model/message.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

class ChatService {
  String? userName;

  String roomId = '1'; // change it's value to join roomChat

  StompClient? stompClient;

  ChatService(this.userName) {
    initChat();
    chatController.sink.add(_currentMessages);
  }

  StreamController<List<Message>> chatController =
      new StreamController<List<Message>>();

  Stream<List<Message>> get chatStream => chatController.stream;

  final List<Message> _currentMessages = [];

  void onMessageReceive(StompFrame frame) {
    var message = json.decode(frame.body);
    print('response' + message.toString());
    if (message['type'] == 'JOIN') {
      message['content'] = message['sender'] + ' joined';
    } else if (message['type'] == 'LEAVE') {
      message['content'] = message['sender'] + ' left!';
    }
    Message currentMessage = Message(message['sender'], message['content']);
    _currentMessages.add(currentMessage);
    chatController.sink.add(_currentMessages);
  }

  void onConnect(StompClient client, StompFrame frame, String userName,
      Function(StompFrame) onMessageReceive) {
    print('onConnect');
    client.subscribe(
        destination: '/channel/$roomId', callback: onMessageReceive);

    client.send(
        destination: '/app/chat/$roomId/addUser',
        body: json.encode({'sender': userName, 'type': 'JOIN'}));
  }

  void initChat() {
    print('activeChat');
    print('userName:' + userName.toString());
    token.then((value) {
      print('token:' + value.toString());
      stompClient = StompClient(
          config: StompConfig(
              url: 'ws://10.0.2.2:8080/ws',
              onConnect: (client, frame) {
                print('connect roi');
                onConnect(client, frame, userName!, onMessageReceive);
              },
              connectionTimeout: Duration(seconds: 5),
              onWebSocketError: (error) =>
                  print("error active socket}" + error.toString()),
              onStompError: (d) => print('error stomp ${d.toString()}'),
              onDisconnect: (f) => print('disconnected ${f.toString()}'),
              onDebugMessage: (mess) => print("debug ${mess}"),
              stompConnectHeaders: {'Authorization': 'Bearer $value'},
              webSocketConnectHeaders: {'Authorization': 'Bearer $value'}));
    });
  }

  Future<void> activeChat() async {
    await Future.delayed(Duration(seconds: 1));
    stompClient?.activate();
  }

  void sendMessage(String message) {
    if (stompClient != null) {
      stompClient?.send(
          destination: '/app/chat/$roomId/sendMessage',
          body: json.encode(
              {'sender': userName, 'type': 'CHAT', 'content': message}));
    }
  }

  void dispose() {
    chatController.close();
  }
}

Future<String> getToken() async {
  String token = await Auth().getToken();
  return token;
}

var token = getToken();
