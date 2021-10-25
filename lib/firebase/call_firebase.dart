import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heath_care/model/message.dart';
import 'package:heath_care/model/user.dart';

class CallFireBase {
  static CallFireBase? _instance;
  final _firebaseInstance = FirebaseFirestore.instance;

  static CallFireBase getInstance() {
    if (_instance != null) return _instance!;
    _instance = CallFireBase();
    return _instance!;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getRequestsStream(
      String currentUserName) {
    return FirebaseFirestore.instance
        .collection('requests')
        .where('completed', isEqualTo: false)
        .where('participants', arrayContainsAny: [currentUserName]).snapshots();
  }

  makeCall(User currentUser, friendUserName, String chatId,
      bool isVoiceCall) async {
    await _firebaseInstance.collection('requests').add({
      'participants': [currentUser.username, friendUserName],
      'from': currentUser.username,
      'full_name_from': currentUser.getDisplayName(),
      'avatar_from': currentUser.avatar,
      'incoming_call': true,
      'completed': false,
      'is_voice_call': isVoiceCall,
      'room_id': '',
      'chat_id': chatId,
    });
  }

  void seenMessage(DocumentReference chatDocument) {
    chatDocument.update({
      'status': 'Đã xem',
    });
  }
}
