import 'package:flutter/material.dart';
import 'package:heath_care/model/exercise.dart';
import 'package:heath_care/repository/exercise_repository.dart';

class DetailScreenExcercise extends StatefulWidget {
  const DetailScreenExcercise({Key? key, required this.ExerciseId})
      : super(key: key);
  final int ExerciseId;

  @override
  _DetailScreenExcerciseState createState() =>
      _DetailScreenExcerciseState(ExerciseId);
}

class _DetailScreenExcerciseState extends State<DetailScreenExcercise> {
  Exercise ex = new Exercise();
  final int ExerciseId;

  _DetailScreenExcerciseState(this.ExerciseId) {
    ExerciseRepository().getExerciseById(ExerciseId).then((val) => setState(() {
          ex = val;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(78, 159, 193, 1),
        title: Text("Chi Tiết Bài Tập"),
      ),
      body: ListView(
        children: [
          Center(
              child: Padding(
            padding: const EdgeInsets.all(20.10),
            child: Text(ex.name.toString(),
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
                child: Image.asset(
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
              child: Text("HƯỚNG DẪN",
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
              child: Text(ex.description.toString(),
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
