import 'package:flutter/material.dart';
import 'package:heath_care/model/request.dart';
import 'package:heath_care/repository/request_repository.dart';

class GetAllRequestScreen extends StatefulWidget {
  const GetAllRequestScreen({Key? key}) : super(key: key);

  @override
  _GetAllRequestScreenState createState() => _GetAllRequestScreenState();
}

class _GetAllRequestScreenState extends State<GetAllRequestScreen> {
  List<Request> _requestList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
          title: Text("DANH SÁCH YÊU CẦU"),
        ),
        body: Column(
          children: [
            Text("DANH SÁCH YÊU CẦU"),
            FutureBuilder<List<Request>?>(
                future: RequestRepository().getAllRequest(),
                builder: (context, requestAllSnapshot) {
                  if (requestAllSnapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: requestAllSnapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(requestAllSnapshot.data![index].user!
                                      .getDisplayName()),
                                  Text(requestAllSnapshot
                                      .data![index].requestType!.requestTypeName
                                      .toString()),
                                  Text(requestAllSnapshot
                                      .data![index].description!
                                      .toString()),
                                ],
                              ),
                            );
                          }),
                    );
                  } else {
                    return Center(
                      child: Text("Chưa có bệnh nhân cần theo dõi đặc biệt"),
                    );
                  }
                })
          ],
        ));
  }
}
