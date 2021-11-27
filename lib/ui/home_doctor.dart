import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:heath_care/model/covid_analysis.dart';
import 'package:heath_care/model/daily_check_dto.dart';
import 'package:heath_care/repository/covid_analysis_repository.dart';
import 'package:heath_care/repository/report_dto_repository.dart';
import 'package:heath_care/ui/components/item_image_avatar.dart';
import 'package:heath_care/ui/excercise_screen.dart';
import 'package:heath_care/ui/medicine_screen.dart';
import 'package:heath_care/ui/patient_detail.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'components/NavSideBar.dart';

// ignore: camel_case_types
class homeScreenDoctor extends StatefulWidget {
  @override
  State<homeScreenDoctor> createState() => _homeScreenState();
}

const _url = 'http://tokhaiyte.vn';

class _homeScreenState extends State<homeScreenDoctor> {
  CovidAnalysis _currentData = new CovidAnalysis();
  CovidAnalysis _todayData = new CovidAnalysis();

  _homeScreenState() {
    CovidAnalysisRepository().getCurrentPatients().then((val) => setState(() {
          _currentData = val;
        }));
    CovidAnalysisRepository().getTodayPatients().then((val) => setState(() {
          _todayData = val;
        }));
  }
  final df = new DateFormat('dd-MM-yyyy');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Trang Chủ"),
          backgroundColor: Color.fromRGBO(78, 159, 193, 1),
        ),
        body: Column(children: [
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
                              child: Text(_currentData.cases.toString(),
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
                                child: RichText(
                                  text: TextSpan(
                                    text: '+ ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 10),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: _todayData.cases.toString(),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                )))
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
                              child: Text(_currentData.death.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: Color.fromRGBO(232, 89, 89, 1))),
                            ),
                            Text("Tử Vong",
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
                                child: RichText(
                                  text: TextSpan(
                                    text: '+ ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 10),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: _todayData.death.toString(),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                )))
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
                              child: Text(_currentData.recovered.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                      color: Color.fromRGBO(0, 192, 8, 1))),
                            ),
                            Text("Hồi Phục",
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
                                child: RichText(
                                  text: TextSpan(
                                    text: '+ ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                        fontSize: 10),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: _todayData.recovered.toString(),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                )))
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
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
                child: Text("BỆNH NHÂN CẦN THEO DÕI",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w600))),
          ),
          FutureBuilder<List<DailyCheckDTO>?>(
              future: ReportDTORepository().getTemperatureAndOxygen(),
              builder: (context, userCheckSnapshot) {
                if (userCheckSnapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: userCheckSnapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PattientDetail(
                                        userName: userCheckSnapshot
                                            .data![index].username!),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                                child: Container(
                                  color: Color.fromRGBO(78, 159, 193, 0.1),
                                  height: 60,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            13, 0, 0, 0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(userCheckSnapshot.data![index]
                                                .getDisplayName()),
                                            RichText(
                                              text: TextSpan(
                                                style:
                                                    DefaultTextStyle.of(context)
                                                        .style,
                                                children: <TextSpan>[
                                                  TextSpan(
                                                      text: 'Ngày: ',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  TextSpan(
                                                      text: df.format(
                                                          userCheckSnapshot
                                                              .data![index]
                                                              .date!)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 13, 0),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              RichText(
                                                text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: 'Nồng độ Oxy: ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    TextSpan(
                                                        text: userCheckSnapshot
                                                            .data![index].oxygen
                                                            .toString()),
                                                  ],
                                                ),
                                              ),
                                              RichText(
                                                text: TextSpan(
                                                  style: DefaultTextStyle.of(
                                                          context)
                                                      .style,
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                        text: 'Nhiệt độ: ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    TextSpan(
                                                        text: userCheckSnapshot
                                                            .data![index]
                                                            .temperature
                                                            .toString()),
                                                  ],
                                                ),
                                              ),
                                            ]),
                                      )
                                    ],
                                  ),
                                ),
                              ));
                        }),
                  );
                } else {
                  return Center(
                    child: Text("Chưa có bệnh nhân cần theo dõi đặc biệt"),
                  );
                }
              })
        ]),
        drawer: NavDrawer());
  }
}

void _launchURL() async =>
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

Future<CovidAnalysis> _getdata() async {
  CovidAnalysis curentInfo =
      await CovidAnalysisRepository().getCurrentPatients();
  return curentInfo;
}
