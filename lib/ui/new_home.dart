import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'components/Bottom_Navigator.dart';
import 'components/NavSideBar.dart';

// ignore: camel_case_types
class homeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Trang Chủ")),
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
        ]),
        drawer: NavDrawer());
  }
}
