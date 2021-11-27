import 'package:flutter/material.dart';
import 'package:heath_care/model/result.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/repository/result_repository.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:intl/intl.dart';

import 'components/NavSideBar.dart';

class TestScreen extends StatefulWidget {
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<Result> _results = [];
  _TestScreenState() {
    ResultRepository().getAllResultCurrentUserId().then((val) => setState(() {
          _results = val!;
        }));
  }
  final df = new DateFormat('dd-MM-yyyy');
  Result? _selectedResult = new Result();

  @override
  Widget build(BuildContext context) {
    if (_selectedResult == null) {
      _selectedResult = _results.first;
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(78, 159, 193, 1),
          title: Text("KẾT QUẢ XÉT NGHIỆM"),
        ),
        body: _results.length >= 1
            ?
            // Column(
            //   children: [
            //     Card(
            //         elevation: 1,
            //         margin: EdgeInsets.only(bottom: 3),
            //         child: ListTile(
            //             title: Text("Lần xét nghiệm: "),
            //             contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            //             trailing: DropdownButtonHideUnderline(
            //                 child: DropdownButton(
            //               isExpanded: false,
            //               items: _results.map((Result value) {
            //                 return DropdownMenuItem<Result>(
            //                   value: value,
            //                   child: Text(
            //                       (_results.indexOf(value) + 1).toString()),
            //                 );
            //               }).toList(),
            //               onChanged: (Result? value) {
            //                 setState(() {
            //                   _selectedResult = value!;
            //                 });
            //               },
            //               hint: Align(
            //                 alignment: Alignment.centerRight,
            //                 child: Text(
            //                   "Chọn lần xét nghiệm",
            //                   style: TextStyle(color: Colors.grey),
            //                 ),
            //               ),
            //               style: TextStyle(
            //                   color: Colors.black,
            //                   decorationColor: Colors.red),
            //             )))),
            //     _selectedResult != null
            //         ? Padding(
            //             padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
            //             child: Container(
            //               height: 300,
            //               width: 0,
            //               decoration: BoxDecoration(
            //                   color: Color.fromRGBO(208, 146, 149, 0.5),
            //                   borderRadius:
            //                       BorderRadius.all(Radius.circular(10.0))),
            //               child: Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Column(
            //                   mainAxisAlignment: MainAxisAlignment.start,
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: <Widget>[

            //                     RichText(
            //                       text: TextSpan(
            //                         style: DefaultTextStyle.of(context).style,
            //                         children: <TextSpan>[
            //                           TextSpan(
            //                               text: 'Đơn vị gửi mẫu (nếu có): ',
            //                               style: TextStyle(
            //                                   fontWeight: FontWeight.bold)),
            //                           TextSpan(
            //                               text: _selectedResult!.unit!.name
            //                                   .toString()),
            //                         ],
            //                       ),
            //                     ),
            //                     SizedBox(height: 15),
            //                     RichText(
            //                       text: TextSpan(
            //                         style: DefaultTextStyle.of(context).style,
            //                         children: <TextSpan>[
            //                           TextSpan(
            //                               text: 'Ngày lấy mẫu: ',
            //                               style: TextStyle(
            //                                   fontWeight: FontWeight.bold)),
            //                           TextSpan(
            //                               text: df.format(
            //                                   _selectedResult!.collectDate!)),
            //                         ],
            //                       ),
            //                     ),
            //                     SizedBox(height: 15),
            //                     RichText(
            //                       text: TextSpan(
            //                         style: DefaultTextStyle.of(context).style,
            //                         children: <TextSpan>[
            //                           TextSpan(
            //                               text: 'Ngày xét nghiệm: ',
            //                               style: TextStyle(
            //                                   fontWeight: FontWeight.bold)),
            //                           TextSpan(
            //                               text: df.format(
            //                                   _selectedResult!.testDate!)),
            //                         ],
            //                       ),
            //                     ),
            //                     SizedBox(height: 15),
            //                     RichText(
            //                       text: TextSpan(
            //                         style: DefaultTextStyle.of(context).style,
            //                         children: <TextSpan>[
            //                           TextSpan(
            //                               text: 'Loại bệnh phẩm: ',
            //                               style: TextStyle(
            //                                   fontWeight: FontWeight.bold)),
            //                           TextSpan(
            //                               text: _selectedResult!
            //                                   .sampleType!.name
            //                                   .toString()),
            //                         ],
            //                       ),
            //                     ),
            //                     SizedBox(height: 15),
            //                     RichText(
            //                       text: TextSpan(
            //                         style: DefaultTextStyle.of(context).style,
            //                         children: <TextSpan>[
            //                           TextSpan(
            //                               text: 'Tình trạng mẫu: ',
            //                               style: TextStyle(
            //                                   fontWeight: FontWeight.bold)),
            //                           if (_selectedResult!.status == 1)
            //                             TextSpan(text: 'Đạt')
            //                           else
            //                             TextSpan(text: 'Không Đạt')
            //                         ],
            //                       ),
            //                     ),
            //                     SizedBox(height: 15),
            //                     RichText(
            //                       text: TextSpan(
            //                         style: DefaultTextStyle.of(context).style,
            //                         children: <TextSpan>[
            //                           TextSpan(
            //                               text: 'Kết quả xét nghiệm: ',
            //                               style: TextStyle(
            //                                   fontWeight: FontWeight.bold)),
            //                           if (_selectedResult!.testResult == 1)
            //                             TextSpan(text: 'Dương tính')
            //                           else if (_selectedResult!.testResult ==
            //                               0)
            //                             TextSpan(text: 'Âm tính')
            //                         ],
            //                       ),
            //                     ),
            //                     SizedBox(height: 15),
            //                     RichText(
            //                       text: TextSpan(
            //                         style: DefaultTextStyle.of(context).style,
            //                         children: <TextSpan>[
            //                           TextSpan(
            //                               text: 'Ghi chú: ',
            //                               style: TextStyle(
            //                                   fontWeight: FontWeight.bold)),
            //                           TextSpan(
            //                               text: _selectedResult!.comment),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ),
            //           )
            //         : Text("Chọn Lần xét nghiệm")
            //   ],
            // )
            ListView.builder(
                itemCount: _results.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                    child: Container(
                      height: 300,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(208, 146, 149, 0.5),
                          borderRadius:
                              BorderRadius.all(Radius.circular(10.0))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Kết Quả xét nghiệm lần: " +
                                  (index + 1).toString(),
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(height: 20),
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Đơn vị gửi mẫu (nếu có): ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: _results[index]
                                          .unit!
                                          .name
                                          .toString()),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Ngày lấy mẫu: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: df.format(
                                          _results[index].collectDate!)),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Ngày xét nghiệm: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text:
                                          df.format(_results[index].testDate!)),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Loại bệnh phẩm: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: _results[index]
                                          .sampleType!
                                          .name
                                          .toString()),
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Tình trạng mẫu: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  if (_results[index].status == 1)
                                    TextSpan(text: 'Đạt')
                                  else
                                    TextSpan(text: 'Không Đạt')
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Kết quả xét nghiệm: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  if (_results[index].testResult == 1)
                                    TextSpan(text: 'Dương tính')
                                  else if (_results[index].testResult == 0)
                                    TextSpan(text: 'Âm tính')
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                            RichText(
                              text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Ghi chú: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: _results[index].comment),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                  // Text(_results[index].testResult.toString());
                })
            : Center(child: Text("Bạn chưa có kết quả xét nghiệm nào")),
        drawer: NavDrawer());
  }
}
