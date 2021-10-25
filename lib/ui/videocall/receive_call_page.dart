import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heath_care/firebase/chat_firebase.dart';
import 'package:heath_care/model/message.dart';
import 'package:heath_care/ui/components/item_image_avatar.dart';

class ReceiveCallPage extends StatefulWidget {
  DocumentReference reference;
  Function onHangUp;

  ReceiveCallPage(this.reference, this.onHangUp,
      {this.fullNameFrom, this.avatarFrom});

  String? fullNameFrom;
  String? avatarFrom;

  @override
  State<StatefulWidget> createState() => _ReceiveCallPageState();
}

class _ReceiveCallPageState extends State<ReceiveCallPage> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  Map<String, dynamic> dataRoom = {};

  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 60;
  bool _isShowDialog = false;

  Future<void> _response(bool accept) async {
    updateRequest(accept);
    assetsAudioPlayer.stop();
  }

  playLocal() async {
    try {
      await assetsAudioPlayer.open(
        Audio('assets/audio/calling.mp3'),
        loopMode: LoopMode.single,
      );
    } catch (t) {
      //stream unreachable
    }
  }

  bool isCompleted = false;

  Future<bool> _onWillPop() async {
    _isShowDialog = true;
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Thoát cuộc gọi?'),
            content: new Text('Bạn chắc chắn muốn kết thúc cuộc gọi?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _isShowDialog = false;
                  Navigator.of(context).pop();
                },
                child: new Text('Tiếp tục gọi'),
              ),
              TextButton(
                onPressed: () {
                  _isShowDialog = false;
                  Navigator.pop(context);
                  _response(false);
                },
                child: new Text('Thoát'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  void initState() {
    super.initState();
    playLocal();
    widget.reference.snapshots().listen((event) {
      dataRoom['participants'] = event.get('participants');
      dataRoom['from'] = event.get('from');
      dataRoom['chat_id'] = event.get('chat_id');
      if (event.get('completed') == true) {
        Navigator.pop(context);
        if(_isShowDialog){
          Navigator.pop(context);
        }
        widget.onHangUp();
      }
      setState(() {
        isCompleted = event.get('completed');
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    assetsAudioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        _isShowDialog = !_isShowDialog;
        return await _onWillPop();
      },
      child: Scaffold(
        body: Container(
          height: size.height,
          width: size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.15,
              ),
              StreamBuilder(
                stream: widget.reference.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  }
                  return Column(
                    children: [
                      Text(
                        'Incoming Call',
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: size.width / 18.4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: size.height * .08,
                      ),
                      ItemAvatarNetworkImage(
                        image: widget.avatarFrom,
                      ),
                      SizedBox(
                        height: 24.0,
                      ),
                      Text(
                        widget.fullNameFrom ?? dataRoom['from'],
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: size.width / 16.8,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: size.height * .24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await _response(false);
                            },
                            child: Container(
                              height: size.width * .18,
                              width: size.width * .18,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.redAccent,
                              ),
                              child: Icon(
                                Icons.call_end,
                                color: Colors.white,
                                size: size.width / 18.0,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await _response(true);
                            },
                            child: Container(
                              height: size.width * .18,
                              width: size.width * .18,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                              child: Icon(
                                Icons.call,
                                color: Colors.white,
                                size: size.width / 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateRequest(bool response) {
    widget.onHangUp();
    if (isCompleted) return;
    if (response == false) {
      String nameFrom = dataRoom['from'].toString();
      var myCurrentUserName = (dataRoom['participants'] as List)
          .firstWhere((element) => element != nameFrom);
      Message message =
          Message(myCurrentUserName, "Đã từ chối cuộc gọi!", Timestamp.now());
      ChatFireBase.getInstance()
          .sendMessageWithId(message, dataRoom['chat_id']);
    }
    widget.reference
        .update({'completed': !response, 'incoming_call': !response});
  }
}
