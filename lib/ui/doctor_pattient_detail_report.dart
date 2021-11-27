import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heath_care/model/list_report_dto.dart';
import 'package:heath_care/model/report_dto.dart';
import 'package:heath_care/model/result.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/repository/report_dto_repository.dart';
import 'package:heath_care/repository/result_repository.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:intl/intl.dart';

class DetailUserReport extends StatefulWidget {
  final int? currentUserId;
  const DetailUserReport({Key? key, required this.currentUserId})
      : super(key: key);

  @override
  _DetailUserReportState createState() => _DetailUserReportState(currentUserId);
}

class _DetailUserReportState extends State<DetailUserReport> {
  ListReportDTO _report = new ListReportDTO();
  List<Result> _results = [];
  int? currentUserId;
  bool _buildResultPage = false;
  final df = new DateFormat('dd-MM-yyyy');

  _DetailUserReportState(this.currentUserId) {
    ReportDTORepository()
        .getReportByUser(currentUserId!)
        .then((val) => setState(() {
              _report = val;
            }));
    ResultRepository()
        .getAllResultByUserId(currentUserId)
        .then((val) => setState(() {
              _results = val!;
            }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
        title: Text("Chi tiết các báo cáo"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTab(false, "TÌNH TRẠNG"),
              SizedBox(
                width: 16,
              ),
              _buildTab(true, "XÉT NGHIỆM")
            ],
          ),
          SizedBox(
            height: 8,
          ),
          // FutureBuilder<User>(
          //     future: UserRepository().getCurrentUser(),
          //     builder: (context, currentUser) {
          //       if (currentUser.hasData) {
          //         return _buildResultPage
          //             ?
          //             // _buildReportPage(currentUser)

          //             :
          //             // buildChats(currentUser);
          //       } else {
          //         return Center(child: CircularProgressIndicator());
          //       }
          //     }),
          _buildResultPage
              ? Text("Daily Report")
              : Expanded(
                  child: ListView.builder(
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
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
                                            text: df.format(
                                                _results[index].testDate!)),
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
                                        else if (_results[index].testResult ==
                                            0)
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
                      }),
                )
        ],
      ),
    );
  }

  Widget _buildTab(bool isActive, String title) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        setState(() {
          _buildResultPage = isActive;
        });
      },
      child: Container(
        // height: size.width * .12,
        width: size.width * .40,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: !(isActive ^ _buildResultPage)
                ? Color.fromRGBO(78, 159, 193, 1)
                : Color.fromRGBO(78, 159, 193, 0.4)),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
  }

  //  _buildReportPage(
  //   if (_report.hasData) {
  //           return Expanded(
  //             child: ListView.builder(
  //                 shrinkWrap: true,
  //                 itemCount: userOnlineSnapshot.data!.length,
  //                 itemBuilder: (BuildContext context, int index) {
  //                   return ItemUserOnline(userOnlineSnapshot.data![index],
  //                       currentUser.data!.username!);
  //                 }),
  //           );
  //         } else {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }

  // }
  //  StreamBuilder<QuerySnapshot<Map<String, dynamic>>> buildChats(
  //     AsyncSnapshot<User> currentUser) {
  //   return
  // }
}
