import 'dart:async';
import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:stomp_dart_client/stomp.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:stomp_dart_client/stomp_config.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:stomp_dart_client/stomp_frame.dart';

onConnect(StompFrame frame) {
  stompClient.subscribe(
    destination: '/topic/public/',
    callback: (frame) {
      List<dynamic>? result = json.decode(frame.body!);
      print(result);
    },
  );

  Timer.periodic(Duration(seconds: 10), (_) {
    stompClient.send(
      destination: '/app/test/endpoints',
      body: json.encode({'a': 123}),
    );
  });
}

final stompClient = StompClient(
  config: StompConfig(
    url: 'ws://localhost:8080',
    onConnect: onConnect,
    beforeConnect: () async {
      print('waiting to connect...');
      await Future.delayed(Duration(milliseconds: 200));
      print('connecting...');
    },
    onWebSocketError: (dynamic error) => print(error.toString()),
    stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
    webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
  ),
);
