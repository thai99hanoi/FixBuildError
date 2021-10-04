import 'dart:async';
import 'dart:convert';

import 'package:heath_care/networks/auth.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

String? username;

dynamic onConnect(StompClient client, StompFrame frame) {
  client.subscribe(
      destination: '/topic/public',
      callback: onMessageReceive);

  Timer.periodic(Duration(seconds: 10), (_) {
    client.send(
        destination: '/app/chat.register',
        body: json.encode({'sender': username, 'type': 'JOIN'}));
  });
}

Future<String> getToken() async {
  String token = await Auth().getToken();
  return token;
}

var token = getToken();

final stompClient = StompClient(
    config: StompConfig(
        url: 'ws://10.0.2.2:8080/chat-test',
        onConnect: onConnect,
        onWebSocketError: (dynamic error) => print(error.toString()),
        stompConnectHeaders: {'Authorization': 'Bearer $token'},
        webSocketConnectHeaders: {'Authorization': 'Bearer $token'}));

void onMessageReceive(StompFrame frame) {
  var message = json.decode(frame.body);

  if (message.type == 'JOIN') {
    message.content = message.sender + 'joined';
  } else if (message.type == 'LEAVE') {
    message.content = message.sender + ' left!';
  } else {

  }
}
