import 'package:flutter/material.dart';
import 'package:heath_care/model/report.dart';
import 'package:heath_care/repository/report_dto_repository.dart';
import 'package:intl/intl.dart';

class DetailPatientReportScreen extends StatefulWidget {
  final int? currentUserId;
  const DetailPatientReportScreen({Key? key, required this.currentUserId})
      : super(key: key);

  @override
  _DetailPatientReportScreenState createState() =>
      _DetailPatientReportScreenState(currentUserId);
}

class _DetailPatientReportScreenState extends State<DetailPatientReportScreen> {
  int? currentUserId;
  _DetailPatientReportScreenState(this.currentUserId) {
    ReportDTORepository().getReport(currentUserId!).then((val) => setState(() {
          _reportsList = val;
        }));
  }
  String _textReplace(String str) {
    str = str.replaceAll('[', ' ');
    str = str.replaceAll(']', '');
    return str;
  }

  final df = new DateFormat('dd-MM-yyyy');
  List<Report>? _reportsList;
  Report? _selectedReport = new Report();
  @override
  Widget build(BuildContext context) {
    return _reportsList != null
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(78, 159, 193, 1),
              title: Text("BÁO CÁO SỨC KHOẺ HÀNG NGÀY"),
            ),
            body: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Card(
                    elevation: 1,
                    margin: EdgeInsets.only(bottom: 3),
                    child: ListTile(
                        title: Row(
                          children: [
                            Icon(Icons.calendar_today_outlined,
                                color: Colors.black),
                            SizedBox(width: 10),
                            Text('Ngày Báo Cáo'),
                          ],
                        ),
                        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        trailing: DropdownButtonHideUnderline(
                            child: DropdownButton(
                          isExpanded: false,
                          items: _reportsList!.map((Report value) {
                            return DropdownMenuItem<Report>(
                              value: value,
                              child: Text(
                                value.date.toString() +
                                    " " +
                                    value.date.toString(),
                              ),
                            );
                          }).toList(),
                          onChanged: (Report? value) {
                            setState(() {
                              _selectedReport = value!;
                            });
                          },
                          hint: Align(
                            alignment: Alignment.centerRight,
                            child: _selectedReport!.date != null
                                ? Text(
                                    _selectedReport!.date.toString() +
                                        " " +
                                        _selectedReport!.time.toString(),
                                    style: TextStyle(color: Colors.grey),
                                  )
                                : Text(
                                    "Chọn ngày báo cáo",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                          ),
                          style: TextStyle(
                              color: Colors.black, decorationColor: Colors.red),
                        )))),
              ),
              _selectedReport!.date != null
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        height: 300,
                        width: 450,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(78, 159, 193, 0.9),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 20),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Nồng độ Oxi: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: _selectedReport!.oxygen!
                                            .toString()),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Nhiệt dộ ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: _selectedReport!.temperature!
                                            .toString()),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Ngày báo cáo: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(text: _selectedReport!.date!),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  RichText(
                                    text: TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: 'Giờ báo cáo: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(text: _selectedReport!.time!),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Bài tập: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: _textReplace(_selectedReport!
                                            .exercises!
                                            .toString())),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Thuốc đã sử dụng: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: _textReplace(_selectedReport!
                                            .medicines!
                                            .toString())),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Triệu chứng: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: _textReplace(_selectedReport!
                                            .symptoms!
                                            .toString())),
                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              RichText(
                                text: TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Ghi chú: ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(
                                        text: _selectedReport!.comment!
                                            .toString()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Center(child: Text("Chọn ngày báo cáo")),
                    )
            ]))
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(78, 159, 193, 1),
              title: Text("BÁO CÁO SỨC KHOẺ HÀNG NGÀY"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }
}
