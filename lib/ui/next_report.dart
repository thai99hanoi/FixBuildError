import 'package:flutter/material.dart';
import 'components/NavSideBar.dart';

class NextScreenReport extends StatelessWidget {
  const NextScreenReport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _checkbox = false;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
          title: const Text("BÁO CÁO SỨC KHOẺ HÀNG NGÀY"),
        ),
        body: ListView(children: [
          const Padding(
            padding: EdgeInsets.all(20.20),
            child: Text("Báo cáo bài tập hàng ngày",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          Row(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: _checkbox,
                    onChanged: (value) {
                      setState(() {
                        _checkbox = !_checkbox;
                      });
                    },
                  ),
                  const Text('Bài Tập 1'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _checkbox,
                    onChanged: (value) {
                      setState(() {
                        _checkbox = !_checkbox;
                      });
                    },
                  ),
                  const Text('Bài tập 2'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _checkbox,
                    onChanged: (value) {
                      setState(() {
                        _checkbox = !_checkbox;
                      });
                    },
                  ),
                  const Text('Bài tập 3'),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: _checkbox,
                    onChanged: (value) {
                      setState(() {
                        _checkbox = !_checkbox;
                      });
                    },
                  ),
                  const Text('Bài tập 4'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _checkbox,
                    onChanged: (value) {
                      setState(() {
                        _checkbox = !_checkbox;
                      });
                    },
                  ),
                  const Text('Bài tập 5'),
                ],
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(20.20),
            child: Text("Báo cáo bài tập hàng ngày",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          Row(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: _checkbox,
                    onChanged: (value) {
                      setState(() {
                        _checkbox = !_checkbox;
                      });
                    },
                  ),
                  const Text('Bài Tập 1'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _checkbox,
                    onChanged: (value) {
                      setState(() {
                        _checkbox = !_checkbox;
                      });
                    },
                  ),
                  const Text('Bài tập 2'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _checkbox,
                    onChanged: (value) {
                      setState(() {
                        _checkbox = !_checkbox;
                      });
                    },
                  ),
                  const Text('Bài tập 3'),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Row(
                children: [
                  Checkbox(
                    value: _checkbox,
                    onChanged: (value) {
                      setState(() {
                        _checkbox = !_checkbox;
                      });
                    },
                  ),
                  const Text('Bài tập 4'),
                ],
              ),
              Row(
                children: [
                  Checkbox(
                    value: _checkbox,
                    onChanged: (value) {
                      setState(() {
                        _checkbox = !_checkbox;
                      });
                    },
                  ),
                  const Text('Bài tập 5'),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.20),
            child: Center(
              child: RaisedButton(
                color: const Color.fromRGBO(78, 159, 193, 1),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                onPressed: () {},
                child: const Text(
                  'Gửi báo cáo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          )
        ]),
        drawer: NavDrawer());
  }

  void setState(Null Function() param0) {}
}
