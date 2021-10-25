import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:heath_care/firebase/chat_firebase.dart';
import 'package:heath_care/model/message.dart';
import 'package:heath_care/ui/components/call_component.dart';
import 'package:heath_care/ui/components/icon_behavior.dart';
import 'package:heath_care/utils/dialog_util.dart';
import 'package:heath_care/utils/signaling.dart';
import 'package:permission_handler/permission_handler.dart';

class CallPage extends StatefulWidget {
  DocumentReference reference;
  bool createRoom;
  bool isVoiceCall;
  Function onHangUp;
  String? currentName;

  CallPage(this.isVoiceCall, this.createRoom, this.reference, this.currentName,
      this.onHangUp);

  @override
  State<StatefulWidget> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  String? roomId;
  bool isCalling = false;
  bool isMute = false;
  String timeCall = '';
  int start = 0;
  bool isFrontCamera = true;
  bool isReady = false;
  int timeOut = 45;
  bool isSpeakerPhone = true;
  bool isDisConnected = false;
  bool enableCamera = true;
  bool remoteEnableCamera = true;
  bool completed = false;
  bool isShowDialog = false;
  Timer? timerInstance;
  Timer? timerTimeOutInstance;

  Signaling signaling = Signaling();
  RTCVideoRenderer localRenderer = RTCVideoRenderer();
  RTCVideoRenderer remoteRenderer = RTCVideoRenderer();

  final assetsAudioPlayer = AssetsAudioPlayer();

  playLocal() async {
    try {
      assetsAudioPlayer
          .open(
        Audio('assets/audio/beep.wav'),
        loopMode: LoopMode.none,
      )
          .then((value) {
        assetsAudioPlayer.stop();
      });
    } catch (t) {
      //stream unreachable
    }
  }

  void startTimeOut() {
    var oneSec = Duration(seconds: 1);
    timerTimeOutInstance = Timer.periodic(oneSec, (Timer timer) {
      if (timer.tick >= timeOut) {
        if (!isReady && !completed) {
          makeCallCompleted();
          sendMessage(widget.currentName, "Không thể thực hiện cuộc gọi!");
        }
        timerTimeOutInstance?.cancel();
      }
    });
  }

  String getTimerTime(int start) {
    int minutes = (start ~/ 60);
    String sMinute = '';
    if (minutes.toString().length == 1) {
      sMinute = '0' + minutes.toString();
    } else
      sMinute = minutes.toString();

    int seconds = (start % 60);
    String sSeconds = '';
    if (seconds.toString().length == 1) {
      sSeconds = '0' + seconds.toString();
    } else
      sSeconds = seconds.toString();

    return sMinute + ':' + sSeconds;
  }

  void startTimer() {
    var oneSec = Duration(seconds: 1);
    timerInstance = Timer.periodic(
        oneSec,
        (Timer timer) => setState(() {
              if (start < 0) {
                timerInstance?.cancel();
              } else {
                start = start + 1;
                timeCall = getTimerTime(start);
              }
            }));
  }


  updateEnableCamera(bool isEnable) {
    widget.reference.get().then((value) {
      if (widget.currentName == value.get('from')) {
        widget.reference.update({
          'camera_from': isEnable,
        });
      } else {
        widget.reference.update({
          'camera_to': isEnable,
        });
      }
    });
  }

  makeCallCompleted() {
    widget.reference.update({
      'completed': true,
    });
  }


  sendMessage(String? userName, String content) {
    widget.reference.get().then((value) {
      Message message =
      Message(userName ?? value['from'], content, Timestamp.now());
      ChatFireBase.getInstance()
          .sendMessageWithId(message, value.get('chat_id'));
    });
  }

  void updateRoom() {
    widget.reference.update({
      'room_id': roomId,
    });
  }

  hangUp({bool pop = true}) {
    if (pop) {
      Navigator.pop(context);
    }
    if (isShowDialog) {
      Navigator.pop(context);
    }
    playLocal();
    signaling.hangUp(localRenderer);
    timerInstance?.cancel();
    widget.onHangUp();
  }

  initListener() {
    widget.reference.snapshots().listen((event) {
      try {
        if (widget.currentName == event.get('from') &&
            event.get('camera_to') != null) {
          final to = event.get('camera_to');
          setState(() {
            remoteEnableCamera = to;
          });
        } else if (widget.currentName != event.get('from') &&
            event.get('camera_from') != null) {
          final from = event.get('camera_from');
          setState(() {
            remoteEnableCamera = from;
          });
        }
      } catch (e) {
        print(e);
      }

      if ((event.get('completed') == false &&
          event.get('incoming_call') == false)) {
        setState(() {
          isReady = true;
        });
      }
      if (event.get('completed') == true && !isDisConnected) {
        completed = true;
        hangUp();
      }
    });
  }

  initPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.camera,
      Permission.microphone,
    ].request();
    if (statuses[Permission.camera]!.isGranted &&
        statuses[Permission.microphone]!.isGranted &&
        !isCalling) {
      await signaling.openUserMedia(
          widget.isVoiceCall, localRenderer, remoteRenderer);
      if (widget.createRoom) {
        roomId = await signaling.createRoom(remoteRenderer);
        updateRoom();
      } else {
        final snapshot = await widget.reference.get();
        String idJoin = snapshot['room_id'];
        signaling.joinRoom(
          idJoin,
          remoteRenderer,
        );
      }
      isCalling = true;
      setState(() {});
    }
  }

  Future<bool> onWillPop() async {
    isShowDialog = true;
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Thoát cuộc gọi?'),
            content: new Text('Kết thúc cuộc gọi'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  isShowDialog = false;
                  Navigator.of(context).pop();
                },
                child: new Text('Tiếp tục gọi'),
              ),
              TextButton(
                onPressed: () {
                  isShowDialog = false;
                  Navigator.pop(context);
                  sendMessage(null, "Kết thúc cuộc gọi");
                  makeCallCompleted();
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
    SystemChrome.setEnabledSystemUIOverlays([]);
    localRenderer.initialize();
    remoteRenderer.initialize();
    signaling.onAddRemoteStream = ((stream) {
      remoteRenderer.srcObject = stream;
      setState(() {});
      startTimer();
    });
    signaling.onConnectedFail = () async {
      setState(() {
        isDisConnected = true;
      });
      widget.onHangUp();
      await showErrorDialog(
          context, "Mất kết nối", "Vui lòng kiểm tra lại kết nối internet");
      makeCallCompleted();
      hangUp();
    };
    initPermission();
    initListener();
    startTimeOut();
    super.initState();
  }

  @override
  void dispose() {
    timerTimeOutInstance?.cancel();
    timerInstance?.cancel();
    localRenderer.dispose();
    remoteRenderer.dispose();
    assetsAudioPlayer.stop();
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        isShowDialog = !isShowDialog;
        return await onWillPop();
      },
      child: Scaffold(
        body: Container(
          color: Colors.black87,
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Visibility(
                visible: isReady && !widget.isVoiceCall,
                child: buildMainRender(
                    remoteRenderer, size, remoteEnableCamera, isReady),
              ),
              if (widget.isVoiceCall)
                buildVoiceCall(size, timeCall, isReady)
              else if (isReady)
                localRender(size)
              else
                buildMainRender(
                    localRenderer, size, remoteEnableCamera, isReady),
              buildRowCall(size)
            ],
          ),
        ),
      ),
    );
  }

  Row buildRowCall(Size size) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      children: [
        IconButtonBehavior(
            Icon(
              isMute ? Icons.mic_off : Icons.mic,
              color: Colors.white,
              size: size.width * .06,
            ),
            size.width * .12,
            size.width * .12,
            () => setState(() {
                  isMute = !isMute;
                  signaling.muteAudio(isMute);
                })),
        SizedBox(
          width: 16,
        ),
        IconButtonBehavior(
            Icon(
              Icons.call_end,
              color: Colors.white,
              size: size.width / 12.0,
            ),
            size.width * .18,
            size.width * .18, () {
          {
            makeCallCompleted();
            sendMessage(null, "Kết thúc cuộc gọi");
          }
        }, backgroundColor: Colors.red.withOpacity(0.6)),
        SizedBox(
          width: 16,
        ),
        IconButtonBehavior(
            Icon(
              isSpeakerPhone
                  ? CupertinoIcons.speaker_fill
                  : CupertinoIcons.speaker,
              color: Colors.white,
              size: size.width * .06,
            ),
            size.width * .12,
            size.width * .12,
            () => setState(() {
                  isSpeakerPhone = !isSpeakerPhone;
                  signaling.enableSpeaker(isSpeakerPhone);
                })),
      ],
    );
  }

  Widget localRender(Size size) {
    return buildLocalRender(
        localRenderer, timeCall, isFrontCamera, enableCamera, size, [
      IconButtonBehavior(
          Icon(
            enableCamera ? Icons.videocam : Icons.videocam_off,
            color: Colors.white,
            size: size.width * .06,
          ),
          size.width * .12,
          size.width * .12, () {
        setState(() {
          enableCamera = !enableCamera;
          updateEnableCamera(enableCamera);
          signaling.enableCamera(enableCamera);
        });
      }),
      SizedBox(
        width: 12,
      ),
      IconButtonBehavior(
          Icon(
            Icons.switch_camera,
            color: Colors.white,
            size: size.width * .06,
          ),
          size.width * .12,
          size.width * .12, () {
        signaling.switchCamera();
      })
    ]);
  }
}
