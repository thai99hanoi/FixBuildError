import 'package:flutter/material.dart';
import 'package:heath_care/repository/exercise_repository.dart';
import 'package:heath_care/repository/medicine_repository.dart';
import 'components/NavSideBar.dart';

class NextScreenReport extends StatefulWidget {
  const NextScreenReport({Key? key}) : super(key: key);

  @override
  State<NextScreenReport> createState() => _NextScreenReportState();
}

class _NextScreenReportState extends State<NextScreenReport> {
  Widget createExListView(BuildContext context, AsyncSnapshot snapshot) {
    var values = snapshot.data;
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return values.isNotEmpty
            ? Column(
                children: <Widget>[
                  ListTile(
                      title: Text(values[index].name.toString()),
                      trailing: Checkbox(
                          value: values[index].isCheck,
                          onChanged: (bool? val) {
                            setState(() {
                              values[index].isCheck = !values[index].isCheck;
                            });
                          }))
                ],
              )
            : CircularProgressIndicator();
      },
    );
  }

  Widget createMedicineListView(BuildContext context, AsyncSnapshot snapshot) {
    var values = snapshot.data;
    return ListView.builder(
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return values.isNotEmpty
            ? Column(
                children: <Widget>[
                  ListTile(
                      title: Text(values[index].name.toString()),
                      trailing: Checkbox(
                          value: values[index].isCheck,
                          onChanged: (bool? val) {
                            setState(() {
                              values[index].isCheck = !values[index].isCheck;
                            });
                          }))
                ],
              )
            : CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
          title: const Text("BÁO CÁO SỨC KHOẺ HÀNG NGÀY"),
        ),
        body: Column(children: [
          const Padding(
            padding: EdgeInsets.all(20.20),
            child: Text("Báo cáo bài tập hàng ngày",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: FutureBuilder(
                future: ExerciseRepository().getAllExercises(),
                initialData: [],
                builder: (context, snapshot) {
                  return createExListView(context, snapshot);
                }),
          ),
          const Padding(
            padding: EdgeInsets.all(20.20),
            child: Text("Báo cáo thuốc hàng ngày",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: FutureBuilder(
                future: MedicineRepository().getAllMedicine(),
                initialData: [],
                builder: (context, snapshot) {
                  return createMedicineListView(context, snapshot);
                }),
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
}
