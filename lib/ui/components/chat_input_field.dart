import 'package:flutter/material.dart';
import 'package:heath_care/repository/file_repository.dart';
import 'package:image_picker/image_picker.dart';

class ChatInputField extends StatefulWidget {
  final Function(String?) onSendMessage;
  final Function? onProgress;
  final Function? onErrorImage;
  final Function? onDone;

  ChatInputField(this.onSendMessage,
      {this.onProgress, this.onErrorImage, this.onDone});

  @override
  State<StatefulWidget> createState() {
    return _ChatInputFieldState();
  }
}

class _ChatInputFieldState extends State<ChatInputField> {
  TextEditingController textEditingController = new TextEditingController();
  final ImagePicker _picker = ImagePicker();
  XFile? image;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: Offset(0, 4),
              blurRadius: 32,
              color: Color(0xFF087949).withOpacity(0.08))
        ]),
        child: SafeArea(
            child: Row(children: [
              IconButton(
                  onPressed: () async {
                    try {
                      image = await _picker.pickImage(
                          source: ImageSource.camera, imageQuality: 70);
                      await progressImage();
                      widget.onDone!();
                    } catch (e) {
                      widget.onErrorImage!();
                      print(e);
                    }
                  },
                  icon: Icon(Icons.camera_alt_outlined, color: Colors.blue)),
              IconButton(
                  onPressed: () async {
                    try {
                      image = await _picker.pickImage(
                          source: ImageSource.gallery, imageQuality: 70);
                      await progressImage();
                      widget.onDone!();
                    } catch (e) {
                      widget.onErrorImage!();
                      print(e);
                    }
                  },
                  icon: Icon(Icons.image, color: Colors.blue)),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20 * 0.75),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Row(children: [
                        Icon(Icons.sentiment_satisfied_alt_outlined,
                            color: Colors.blue.withOpacity(0.64)),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: TextField(
                              onChanged: (_) {
                                setState(() {});
                              },
                              controller: textEditingController,
                              enabled: image == null,
                              decoration: InputDecoration(
                                hintText: "Type message",
                                border: InputBorder.none,
                              )),
                        ),
                        IconButton(
                            onPressed: () {
                              if (textEditingController.text.isNotEmpty) {
                                widget.onSendMessage(textEditingController.text);
                              }
                              FocusScope.of(context).requestFocus(FocusNode());
                              textEditingController.text = '';
                              setState(() {});
                            },
                            icon: Icon(Icons.send,
                                color: textEditingController.text.isEmpty &&
                                    image == null
                                    ? Colors.grey.shade400
                                    : Colors.blue.withOpacity(0.64))),
                      ])))
            ])));
  }

  Future<void> progressImage() async {
    widget.onProgress!();
    String? path = await FileRepository().uploadImage(image?.path);
    if (path == null) {
      widget.onErrorImage!();
      return;
    }
    widget.onSendMessage('data:image;$path');
    setState(() {
      image = null;
    });
  }
}