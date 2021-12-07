import 'package:flutter/material.dart';
import 'package:heath_care/repository/medicine_repository.dart';
import 'package:heath_care/ui/detail_medicine.dart';
import 'package:heath_care/utils/api.dart';

class MedicineScreen extends StatefulWidget {
  const MedicineScreen({Key? key}) : super(key: key);

  @override
  _MedicineScreenState createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {
  Widget createMedicineListView(BuildContext context, AsyncSnapshot snapshot) {
    var values = snapshot.data;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          childAspectRatio: 2,
          mainAxisExtent: 150,
          crossAxisSpacing: 20,
          mainAxisSpacing: 30),
      itemCount: values.length,
      itemBuilder: (BuildContext context, int index) {
        return values.isNotEmpty
            ? InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailScreenMedicine(MedicineId: values[index].id),
                    ),
                  );
                },
                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: values[index].thumbnail.isNotEmpty
                              ? Image.network(
                                  Api.imageUrl + values[index].thumbnail,
                                  height: 100,
                                  width: 200,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  "assets/images/ex.jpeg",
                                  fit: BoxFit.cover,
                                )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          values[index].name.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
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
        title: const Text("DANH SÁCH THUỐC"),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(20.20),
            child: Text("THUỐC ĐIỀU TRỊ",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder(
                  future: MedicineRepository().getAllMedicine(),
                  initialData: [],
                  builder: (context, snapshot) {
                    return createMedicineListView(context, snapshot);
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
