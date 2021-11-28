import 'package:flutter/material.dart';

class SendRequest extends StatefulWidget {
  const SendRequest({Key? key}) : super(key: key);

  @override
  _SendRequestState createState() => _SendRequestState();
}

List<String> _requestType = ["Đưa đi cấp cứu", "Tài khoản"];

class _SendRequestState extends State<SendRequest> {
  String? _selectedRequestType;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
          title: Text("Chi tiết các báo cáo"),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(children: [
                  Text("Loại Yêu Cầu:", style: TextStyle(fontSize: 16)),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: DropdownButton<String>(
                      hint: Text(
                          _selectedRequestType ?? 'Vui Lòng Chọn Yêu Cầu',
                          style: TextStyle(fontSize: 16)),
                      items: _requestType.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (value) {
                        _selectedRequestType = value;
                        ;
                      },
                    ),
                  ),
                ]),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Nội Dung Yêu Cầu:",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500)),
                  ),
                  Center(
                    child: Card(
                        child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              controller: TextEditingController(),
                              onChanged: (val) {},
                              maxLines: 8,
                              decoration: InputDecoration.collapsed(
                                  hintText: "Ghi Chú"),
                            ))),
                  ),
                  Center(
                      child: RaisedButton(
                    color: Color.fromRGBO(78, 159, 193, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    onPressed: () {},
                    child: Text(
                      'Gửi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 13,
                      ),
                    ),
                  )),
                ],
              )
            ]));
  }
}
