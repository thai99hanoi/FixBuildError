import 'package:flutter/material.dart';
import 'package:heath_care/model/result.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/networks/auth.dart';
import 'package:heath_care/repository/result_repository.dart';
import 'package:heath_care/repository/user_repository.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(78, 159, 193, 1),
          title: Text("KẾT QUẢ XÉT NGHIỆM"),
        ),
        body: _results.length >=0
            ? ListView.builder(
                itemCount: _results.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Text(_results[index].testResult.toString());
                })
            : Center(child: Text("Bạn chưa có kết quả xét nghiệm nào")),
        drawer: NavDrawer());
  }
}
