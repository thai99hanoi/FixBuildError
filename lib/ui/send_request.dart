import 'package:flutter/material.dart';
import 'package:heath_care/model/request_dto.dart';
import 'package:heath_care/model/request_type.dart';
import 'package:heath_care/repository/request_repository.dart';

class SendRequest extends StatefulWidget {
  const SendRequest({Key? key}) : super(key: key);

  @override
  _SendRequestState createState() => _SendRequestState();
}

List<RequestType> _requestType = [
  RequestType(id: 1, requestTypeName: "Chỉnh sửa thông tin cá nhân"),
  RequestType(id: 2, requestTypeName: "Hỗ trợ đặc biệt"),
  RequestType(id: 3, requestTypeName: "Cấp cứu"),
  RequestType(id: 4, requestTypeName: "Thay đổi nơi làm việc"),
  RequestType(id: 5, requestTypeName: "Cấp lại mật khẩu"),
  RequestType(id: 6, requestTypeName: "Cấp lại tài khoản khác"),
];
TextEditingController _descriptionController = new TextEditingController();

class _SendRequestState extends State<SendRequest> {
  RequestType? _selectedRequestType;
  Future save() async {
    try {
      RequestRepository().createRequest(_request);
      showAlertDialog(context);
    } catch (error) {
      print(error.toString());
    }
  }

  RequestDTO _request = new RequestDTO();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
          title: Text("GỬI YÊU CẦU"),
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
                    child: DropdownButton<RequestType>(
                      hint: _selectedRequestType != null
                          ? Text(
                              _selectedRequestType!.requestTypeName.toString())
                          : Text('Vui Lòng Chọn Yêu Cầu'),
                      items: _requestType.map((RequestType value) {
                        return new DropdownMenuItem<RequestType>(
                          value: value,
                          child: Text(value.requestTypeName.toString(),
                              style: TextStyle(fontSize: 13)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _request.requestTypeId = value!.id;
                          _selectedRequestType = value;
                        });
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
                              controller: TextEditingController(
                                  text: _descriptionController.text),
                              onChanged: (val) {
                                _descriptionController.text = val;
                                _request.description = val;
                              },
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
                    onPressed: () {
                      save();
                    },
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

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Thành Công"),
    content: Text("Yêu cầu đã được gửi thành công"),
    actions: [
      okButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
