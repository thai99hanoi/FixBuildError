import 'package:flutter/material.dart';
import 'package:heath_care/model/medicine.dart';
import 'package:heath_care/repository/medicine_repository.dart';
import 'package:heath_care/utils/api.dart';

class DetailScreenMedicine extends StatefulWidget {
  const DetailScreenMedicine({Key? key, required this.MedicineId})
      : super(key: key);
  final int MedicineId;

  @override
  _DetailMedicineState createState() => _DetailMedicineState(MedicineId);
}

class _DetailMedicineState extends State<DetailScreenMedicine> {
  Medicine medicine = new Medicine();
  final int MedicineId;

  _DetailMedicineState(this.MedicineId) {
    MedicineRepository().getMedicineById(MedicineId).then((val) => setState(() {
          medicine = val;
        }));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
        title: Text("Chi Tiết Thuốc"),
      ),
      body: ListView(
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(20.10),
            child: Text(medicine.name.toString(),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 25,
                )),
          )),
          Padding(
            padding: const EdgeInsets.all(10.10),
            child: Container(
              alignment: AlignmentDirectional.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: medicine.thumbnail != null
                    ? Image.network(
                        Api.imageUrl + medicine.thumbnail.toString(),
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        "assets/images/ex.jpeg",
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("HƯỚNG DẪN SỬ DỤNG",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(medicine.detail.toString(),
                  style: TextStyle(
                    fontSize: 16,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
