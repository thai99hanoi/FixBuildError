import 'package:flutter/material.dart';
import 'package:heath_care/model/patient_dto.dart';
import 'package:heath_care/model/user.dart';
import 'package:heath_care/repository/user_repository.dart';
import 'package:heath_care/ui/components/item_pattients.dart';

class ListAllPattients extends StatefulWidget {
  const ListAllPattients({Key? key}) : super(key: key);

  @override
  _ListAllPattientsState createState() => _ListAllPattientsState();
}

class _ListAllPattientsState extends State<ListAllPattients> {
  User _currentUser = new User();
  Future<List<User>?> _listPattients = new UserRepository().getPatientByDoctor();
  _ListAllPattientsState() {
    UserRepository().getCurrentUser().then((val) => setState(() {
          _currentUser = val;
        }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(78, 159, 193, 1),
          title: Text('DANH SÁCH BỆNH NHÂN'),
        ),
        body: Column(children: [
          FutureBuilder<List<User>?>(
              future: _listPattients,
              builder: (context, listDoctotSnapshot) {
                if (listDoctotSnapshot.hasData) {
                  return Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: listDoctotSnapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ItemPatttients(
                                listDoctotSnapshot.data![index],
                                _currentUser.username!);
                          }));
                } else {
                  return Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "Bạn chưa có bệnh nhân chỉ định, vui lòng gửi yêu cầu để được hỗ trợ",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  );
                }
              })
        ]));
  }
}
