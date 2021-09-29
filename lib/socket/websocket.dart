import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:heath_care/utils/message_chat_json.dart';

class Websocket {
  IOWebSocketChannel? channel;
  String? url;

  Websocket(String url){
      this.url = url;
      this.channel = IOWebSocketChannel.connect('ws://$url/chat');
  }

  void disconnectFromServer() {
    // TODO: error handling, for now it will crash and burn
    channel!.sink.close(status.goingAway);
  }

  void listenForMessages(void onMessageReceived(dynamic  message)) {
    // TODO: error handling, for now it will crash and burn
    channel!.stream.listen(onMessageReceived);
    print('now listening for messages');
  }

  void sendMessage(String message) {
    print('sending a message: ' + message);
    // TODO: error handling, for now it will crash and burn
    channel!.sink.add(MessageJson.encodeMessageJSON(message));
  }
}
