import 'package:flutter/material.dart';
import 'package:heath_care/model/symptom.dart';
import 'package:heath_care/repository/symptom_repository.dart';

class ListAllSymtom extends StatefulWidget {
  const ListAllSymtom({Key? key}) : super(key: key);

  @override
  _ListAllSymtomState createState() => _ListAllSymtomState();
}

class _ListAllSymtomState extends State<ListAllSymtom> {
  Future<List<Symptom>?> _allSymtom = new SymptomRepository().getAllSymptom();
  @override
  Widget build(BuildContext context) {
    return new FutureBuilder<List<Symptom>?>(
          future: _allSymtom,
          builder: (context, symptomAll) {
            if (symptomAll.hasData) {
              return ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: symptomAll.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: Text(symptomAll
                            .data![index].name
                            .toString()),
                        trailing: Checkbox(
                            value:
                            symptomAll.data![index].isCheck,
                            onChanged: (bool? val) {
                              setState(() {
                                symptomAll.data![index].isCheck =
                                !symptomAll
                                    .data![index].isCheck;
                              });
                            }))
                    // Text(symptomAll.data![index].name.toString())
                        ;
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
    );
  }
}
