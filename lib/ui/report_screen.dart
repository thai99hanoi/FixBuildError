import 'package:flutter/material.dart';
import 'package:heath_care/model/report.dart';
import 'package:heath_care/model/report_dto.dart';
import 'package:heath_care/model/symptom.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/repository/report_dto_repository.dart';
import 'package:heath_care/repository/symptom_repository.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/main_screen.dart';
import 'package:heath_care/ui/next_report.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:intl/intl.dart';

import 'components/NavSideBar.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  ReportDTO reportDTO = new ReportDTO();

  List<int?>? _selectedSymptom = [];
  List<Symptom> _allSymptom = [];


  _ReportScreenState() {
    SymptomRepository().getAllSymptom().then((val) => setState(() {
          _allSymptom = val!;
        }));

  }
  GlobalKey<FormState> keyForm = new GlobalKey<FormState>();
  TextEditingController _textOxygenController = TextEditingController();
  TextEditingController _textTemperatureController = TextEditingController();
  TextEditingController _textCommentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
          title: const Text("BÁO CÁO SỨC KHOẺ HÀNG NGÀY"),
        ),
        body: Form(
          autovalidateMode: AutovalidateMode.disabled,
          key: keyForm,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(children: [
                  Text("Nồng độ Oxy",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: SizedBox(
                        width: 160,
                        height: 40,
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Vui lòng nhập nồng độ oxi"),
                              RangeValidator(
                                  min: 0,
                                  max: 100,
                                  errorText: "Vui lòng nhập nồng đọ oxi hợp lệ")
                            ]),
                            controller: TextEditingController(
                                text: _textOxygenController.text),
                            onChanged: (val) {
                              _textOxygenController.text = val;
                              reportDTO.oxygen = val;
                            },
                            style:
                                TextStyle(fontSize: 14, color: Colors.black))),
                  )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(children: [
                  Text("Nhiệt độ",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: SizedBox(
                        width: 200,
                        height: 40,
                        child: TextFormField(
                            keyboardType: TextInputType.number,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: "Vui lòng nhập nhiệt độ"),
                              RangeValidator(
                                  min: 30,
                                  max: 50,
                                  errorText: "Vui lòng nhập nhiệt độ hợp lệ")
                            ]),

                            // text: _textOxygenController(text: reportDTO.temperate),
                            controller: TextEditingController(
                                text: _textTemperatureController.text),
                            onChanged: (val) {
                              _textTemperatureController.text = val;
                              reportDTO.temperate = val;
                            },
                            style:
                                TextStyle(fontSize: 14, color: Colors.black))),
                  )
                ]),
              ),
              const Padding(
                padding: EdgeInsets.all(20.10),
                child: Text("Tình trạng sức khoẻ",
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
              ),
              ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _allSymptom.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                            title: Text(_allSymptom[index].name.toString()),
                            trailing: Checkbox(
                                value: _allSymptom[index].isCheck,
                                onChanged: (bool? val) {
                                  setState(() {
                                    _allSymptom[index].isCheck =
                                        !_allSymptom[index].isCheck;
                                    if (_allSymptom[index].isCheck) {
                                      _selectedSymptom!
                                          .add(_allSymptom[index].symptomId);
                                      reportDTO.symptomId = _selectedSymptom;
                                    } else {
                                      _selectedSymptom!
                                          .remove(_allSymptom[index].symptomId);
                                    }
                                  });
                                }))
                        // Text(symptomAll.data![index].name.toString())
                        ;
                  }),
              const Padding(
                padding: EdgeInsets.all(28.0),
                child: Text("Ghi chú khác",
                    style:
                        TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
              ),
              Center(
                child: Card(
                    child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextField(
                          controller: TextEditingController(
                              text: _textCommentController.text),
                          onChanged: (val) {
                            _textCommentController.text = val;
                            reportDTO.comment = val;
                          },
                          maxLines: 8,
                          decoration: InputDecoration.collapsed(
                              hintText: "Nhập Ghi Chú"),
                        ))),
              ),
              Center(
                  child: RaisedButton(
                color: Color.fromRGBO(78, 159, 193, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                onPressed: () {
                  if (keyForm.currentState == null) {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text(
                          'Lỗi',
                          style: TextStyle(color: Colors.blue),
                        ),
                        content: Text("Vui Lòng Kiểm Tra Lại"),
                        actions: <Widget>[
                          // ignore: deprecated_member_use
                          FlatButton(
                            child: Text('Okay'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      ),
                    );
                  } else if (keyForm.currentState!.validate()) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NextScreenReport(
                                reportDTO: reportDTO,
                              )),
                    );
                  }
                },
                child: Text(
                  'Tiếp Theo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              )),
            ],
          ),
        ),
        drawer: NavDrawer());
  }

  void _showerrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'An Error Occurs',
          style: TextStyle(color: Colors.blue),
        ),
        content: Text(message),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    },
  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Thành Công"),
    content: Text("Báo cáo đã được gửi thành công, quay lại trang chủ."),
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
