import 'package:flutter/material.dart';
import 'package:heath_care/model/symptom.dart';
import 'package:heath_care/repository/symptom_repository.dart';
import 'package:heath_care/ui/next_report.dart';
import 'components/NavSideBar.dart';
import 'list_symtom.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  Future<List<Symptom>?> _allSymtom = new SymptomRepository().getAllSymptom();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
          title: const Text("BÁO CÁO SỨC KHOẺ HÀNG NGÀY"),
        ),
        body: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
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
              padding: const EdgeInsets.all(10.0),
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
                          style: TextStyle(fontSize: 14, color: Colors.black))),
                )
              ]),
            ),
            const Padding(
              padding: EdgeInsets.all(20.10),
              child: Text("Tình trạng sức khoẻ",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
            ),
            new Expanded(
              child: ListAllSymtom(),
            ),
            const Padding(
              padding: EdgeInsets.all(28.0),
              child: Text("Ghi chú khác",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
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
            Center(
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
            )),
          ],
        ),
        drawer: NavDrawer());
  }
}
