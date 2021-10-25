import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heath_care/model/message.dart';

class ChatFireBase {
  static ChatFireBase? _instance;
  final _firebaseInstance = FirebaseFirestore.instance;

  static ChatFireBase getInstance() {
    if (_instance != null) return _instance!;
    _instance = ChatFireBase();
    return _instance!;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getConversationStream(
      String currentUserName) {
    return _firebaseInstance
        .collection('chats')
        .orderBy('updated_time', descending: true)
        .where('participants', arrayContains: currentUserName)
        .snapshots();
  }

  sendMessage(Message message, DocumentReference chatDocument) async {
    if (message.content == null) return;
    await chatDocument.update({
      'status': 'Đã gửi',
      'messages': FieldValue.arrayUnion([message.toMap()]),
      'updated_time': message.createdTime,
    });
  }

  sendMessageWithId(Message message, String documentID) async {
    if (message.content == null) return;
    FirebaseFirestore.instance.collection('chats').doc(documentID).update({
      'status': 'Đã gửi',
      'messages': FieldValue.arrayUnion([message.toMap()]),
      'updated_time': message.createdTime,
    });
  }

  void seenMessage(DocumentReference chatDocument) {
    chatDocument.update({
      'status': 'Đã xem',
    });
  }
}
