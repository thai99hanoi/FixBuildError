import 'package:flutter/material.dart';
import 'package:heath_care/model/symptom.dart';
import 'package:heath_care/repository/symptom_repository.dart';
import 'package:heath_care/ui/next_report.dart';
import 'components/NavSideBar.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}



Future<List<Symptom>?> symtomList = SymptomRepository().getAllSymptom();
List<Symptom> data = symtomList as List<Symptom>;

class _ReportScreenState extends State<ReportScreen> {
  @override
  Widget build(BuildContext context) {
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
                Text("Nhiệt độ",
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
            ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return new Card(
                      child: new Container(
                          padding: new EdgeInsets.all(10.0),
                          child: Column(children: <Widget>[
                            new CheckboxListTile(
                                activeColor: Colors.pink[300],
                                dense: true,
                                title: new Text(
                                  data[index].name.toString(),
                                ),
                                value: data[index].isCheck,
                                onChanged: (bool? val) {
                                  itemChanged(val!, index);
                                })
                          ])));
                }),
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
            Center(
              // ignore: deprecated_member_use
              child: RaisedButton(
                color: Color.fromRGBO(78, 159, 193, 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NextScreenReport()));
                },
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

  void itemChanged(bool val, int index) {
    setState(() {
      data[index].isCheck = val;
    });
  }
}
