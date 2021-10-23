import 'package:flutter/material.dart';
import 'components/NavSideBar.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _checkbox = false;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
          title: const Text("BÁO CÁO SỨC KHOẺ HÀNG NGÀY"),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(children: const [
                Text("Nồng độ Oxy",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SizedBox(
                      width: 100,
                      height: 20,
                      child: TextField(
                          style: TextStyle(fontSize: 14, color: Colors.black))),
                )
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(children: const [
                Text("Nồng độ Oxy",
                    style:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: SizedBox(
                      width: 100,
                      height: 20,
                      child: TextField(
                          style: TextStyle(fontSize: 12, color: Colors.black))),
                )
              ]),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Tình trạng sức khoẻ",
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
                    const Text('Ho'),
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
                    const Text('Đau người, mệt mỏi'),
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
                    const Text('Sức Khoẻ tốt'),
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
                    const Text('Sốt'),
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
                    const Text('Khó thở'),
                  ],
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Ghi chú khác",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ),
            const Center(
              child: Card(
                  child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        maxLines: 8,
                        decoration: InputDecoration.collapsed(
                            hintText: "Enter your text here"),
                      ))),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              // ignore: deprecated_member_use
              child: RaisedButton(
                color: Color.fromRGBO(78, 159, 193, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                onPressed: null,
                child: Text(
                  'Tiếp theo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 13,
                  ),
                ),
              ),
            )
          ],
        ),
        drawer: NavDrawer());
  }

  void setState(Null Function() param0) {}
}
