import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'components/Bottom_Navigator.dart';
import 'components/NavSideBar.dart';

// ignore: camel_case_types
class homeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Trang Chủ"),
          backgroundColor: Color.fromRGBO(78, 159, 193, 1),
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("TÌNH HÌNH DỊCH TẠI VIỆT NAM",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Column(children: [
                        Container(
                          height: 70,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color.fromRGBO(243, 231, 189, 1),
                          ),
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text("667.023",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: Color.fromRGBO(192, 150, 0, 1))),
                            ),
                            Text("Ca Nhiễm",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 10),
                                textAlign: TextAlign.center),
                          ]),
                        ),
                        Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Color.fromRGBO(232, 200, 89, 1)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                "+9.373",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 10),
                                textAlign: TextAlign.center,
                              ),
                            ))
                      ]),
                    ),
                  ),
                  //One Column
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Column(children: [
                        Container(
                          height: 70,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color.fromRGBO(243, 189, 189, 1),
                          ),
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text("667.023",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: Color.fromRGBO(232, 89, 89, 1))),
                            ),
                            Text("Ca Nhiễm",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 10),
                                textAlign: TextAlign.center),
                          ]),
                        ),
                        Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Color.fromRGBO(232, 89, 89, 1)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                "+9.373",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 10),
                                textAlign: TextAlign.center,
                              ),
                            ))
                      ]),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Column(children: [
                        Container(
                          height: 70,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Color.fromRGBO(189, 243, 194, 1),
                          ),
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text("667.023",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: Color.fromRGBO(0, 192, 8, 1))),
                            ),
                            Text("Ca Nhiễm",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 10),
                                textAlign: TextAlign.center),
                          ]),
                        ),
                        Container(
                            height: 40,
                            width: 100,
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Color.fromRGBO(0, 192, 8, 1)),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                "+9.373",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 10),
                                textAlign: TextAlign.center,
                              ),
                            ))
                      ]),
                    ),
                  ),
                ]),
          ),
          const Divider(
            height: 20,
            thickness: 5,
            indent: 20,
            endIndent: 20,
          ),
          Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Padding(
                   padding: const EdgeInsets.all(18.0),
                   child: SizedBox(
                    width: 130.0,
                    height: 40.0,
                    // ignore: deprecated_member_use
                    child: new RaisedButton(
                      color: Color.fromRGBO(78, 159, 193, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      onPressed: () {},
                      child: new Text(
                        'Khai báo y tế',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                ),
                 ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: SizedBox(
                    width: 130.0,
                    height: 40.0,
                    // ignore: deprecated_member_use
                    child: new RaisedButton(
                      color: Color.fromRGBO(78, 159, 193, 1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      onPressed: () {},
                      child: new Text(
                        'Tập phục hồi',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 20,
            thickness: 5,
            indent: 20,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("HƯỚNG DẪN SỬ DỤNG PHẦN MỀM",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
            child: Container(
              height: 200,
              width: 100,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(78, 159, 193, 0.3),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(" Sử dụng phần mềm bằng cách"),
              ),
            ),
          ),
        ]),
        drawer: NavDrawer());
  }
}
