import 'package:flutter/material.dart';
import 'package:heath_care/model/exercise.dart';
import 'package:heath_care/model/medicine.dart';
import 'package:heath_care/model/symptom.dart';
import 'package:heath_care/repository/exercise_repository.dart';
import 'package:heath_care/repository/medicine_repository.dart';
import 'package:heath_care/repository/symptom_repository.dart';
import 'package:heath_care/ui/list_exercise.dart';
import 'package:heath_care/ui/next_report.dart';
import 'components/NavSideBar.dart';
import 'list_symtom.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  List<String> _selectedMedicine = [];
  List<Medicine> _allMedicine = [];
  List<String> _selectedSymtom = [];
  List<Symptom> _allSymtom = [];
  List<String> _selectedExercise = [];
  List<Exercise> _allExercise = [];
  _ReportScreenState() {
    ExerciseRepository().getAllExercises().then((val) => setState(() {
          _allExercise = val!;
        }));
    SymptomRepository().getAllSymptom().then((val) => setState(() {
          _allSymtom = val!;
        }));
    MedicineRepository().getAllMedicine().then((val) => setState(() {
          _allMedicine = val!;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
          title: const Text("BÁO CÁO SỨC KHOẺ HÀNG NGÀY"),
        ),
        body: ListView(
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
              child: ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _allSymtom.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                            title: Text(_allSymtom[index].name.toString()),
                            trailing: Checkbox(
                                value: _allSymtom[index].isCheck,
                                onChanged: (bool? val) {
                                  setState(() {
                                    _allSymtom[index].isCheck =
                                        !_allSymtom[index].isCheck;
                                    if (_allSymtom[index].isCheck) {
                                      _selectedSymtom.add(
                                          _allSymtom[index].name.toString());
                                    } else {
                                      _selectedSymtom.remove(
                                          _allSymtom[index].name.toString());
                                    }
                                  });
                                }))
                        // Text(symptomAll.data![index].name.toString())
                        ;
                  }),
            ),
            const Padding(
              padding: EdgeInsets.all(20.10),
              child: Text("Báo Cáo Bài Tập Hàng Ngày",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
            ),
            new Expanded(
              child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: _allExercise.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                          title: Text(_allExercise[index].name.toString()),
                          trailing: Checkbox(
                              value: _allExercise[index].isCheck,
                              onChanged: (bool? val) {
                                setState(() {
                                  _allExercise[index].isCheck =
                                      !_allExercise[index].isCheck;
                                  if (_allExercise[index].isCheck) {
                                    _selectedExercise.add(
                                        _allExercise[index].name.toString());
                                  } else {
                                    _selectedExercise.remove(
                                        _allExercise[index].name.toString());
                                  }
                                });
                              }))
                      // Text(symptomAll.data![index].name.toString())
                      ;
                },
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20.10),
              child: Text("Báo Cáo Thuốc Hàng Ngày",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600)),
            ),
            Expanded(
              child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: _allMedicine.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                          title: Text(_allMedicine[index].name.toString()),
                          trailing: Checkbox(
                              value: _allMedicine[index].isCheck,
                              onChanged: (bool? val) {
                                setState(() {
                                  _allMedicine[index].isCheck =
                                      !_allMedicine[index].isCheck;
                                  if (_allMedicine[index].isCheck) {
                                    _selectedMedicine.add(
                                        _allMedicine[index].name.toString());
                                  } else {
                                    _selectedMedicine.remove(
                                        _allMedicine[index].name.toString());
                                  }
                                });
                              }))
                      // Text(symptomAll.data![index].name.toString())
                      ;
                },
              ),
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
                'Gửi',
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
