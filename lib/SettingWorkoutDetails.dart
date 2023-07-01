import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pose_fit/CameraPage.dart';
import 'package:pose_fit/UpdateProfile.dart';
import 'package:pose_fit/WorkoutHistory.dart';

import 'Home.dart';
import 'classes/Workout.dart';

void main() {
  //runApp(SettingWorkoutDetails("Hoba2001@gmail.com"));
}

class SettingWorkoutDetails extends StatefulWidget {
  String email;
  Workout choosenWorkout;

  SettingWorkoutDetails(this.email, this.choosenWorkout);

  @override
  State<SettingWorkoutDetails> createState() => _SettingWorkoutDetailsState();
}

class _SettingWorkoutDetailsState extends State<SettingWorkoutDetails> {
  int sets = 3;
  int reps = 5;

  List<CameraDescription> cameras = [];

  Future<void> setCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  }

  @override
  void initState() {
    setCameras();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Set reps",
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            padding: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                color: Color(0xff262e57),
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(150),
                    bottomLeft: Radius.circular(150))),
            height: 80,
            alignment: Alignment.center,
            child: Text(
              "Set your workout details",
              style: TextStyle(
                  color: Color(0xffffffff),
                  fontFamily: "gothic",
                  fontSize: 24,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            height: 63,
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xff262e57),
                    blurStyle: BlurStyle.outer,
                    spreadRadius: 0.1,
                    blurRadius: 3,
                  )
                ],
                color: const Color(0xff262e57).withOpacity(0.95),
                borderRadius: const BorderRadius.all(Radius.circular(35))),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  WorkoutHistory(widget.email)),
                        );
                      },
                      iconSize: 34,
                      icon: const Icon(
                        color: Colors.white,
                        Icons.history_rounded,
                      )),
                  const SizedBox(
                    width: 70,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(widget.email)),
                        );
                      },
                      iconSize: 34,
                      icon: const Icon(
                        color: Colors.white,
                        Icons.home_rounded,
                      )),
                  const SizedBox(
                    width: 70,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  UpdateProfile(widget.email)),
                        );
                      },
                      iconSize: 34,
                      icon: const Icon(
                        color: Colors.white,
                        Icons.account_circle_outlined,
                      ))
                ]),
          ),
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(20.0),
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        "Sets",
                        style: TextStyle(
                            fontSize: 30,
                            color: Color(0xff262e57),
                            fontFamily: "gothic"),
                      ),
                      NumberPicker(
                          minValue: 1,
                          maxValue: 10,
                          value: sets,
                          itemCount: 5,
                          haptics: true,
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: Color(0xff262e57),
                              fontFamily: "gothic"),
                          selectedTextStyle: TextStyle(
                              fontSize: 40,
                              color: Color(0xfff7a007),
                              fontFamily: "gothic"),
                          onChanged: (value) {
                            sets = value;
                            setState(() {});
                          }),
                      Text(
                        "X",
                        style: TextStyle(
                            fontSize: 35,
                            color: Color(0xff262e57),
                            fontFamily: "gothic"),
                      ),
                      NumberPicker(
                          minValue: 1,
                          maxValue: 20,
                          value: reps,
                          itemCount: 5,
                          haptics: true,
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: Color(0xff262e57),
                              fontFamily: "gothic"),
                          selectedTextStyle: TextStyle(
                              fontSize: 40,
                              color: Color(0xfff7a007),
                              fontFamily: "gothic"),
                          onChanged: (value) {
                            reps = value;
                            setState(() {});
                          }),
                      Text(
                        "Reps",
                        style: TextStyle(
                            fontSize: 30,
                            color: Color(0xff262e57),
                            fontFamily: "gothic"),
                      ),
                    ]),
              ),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(
                        220,
                        60,
                      )),
                      backgroundColor:
                          MaterialStateProperty.all(Color(0xff262e57)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CameraApp(
                                email: widget.email,
                                cameras: cameras,
                                runningWorkout: widget.choosenWorkout,
                                workoutSource: 2.1)));
                  },
                  child: Text(
                    "Start Training",
                    style: TextStyle(fontSize: 25, fontFamily: "gothic"),
                  )),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(
                        220,
                        60,
                      )),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                        side:
                            const BorderSide(width: 1.5, color: Colors.indigo),
                      ))),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CameraApp(
                                email: widget.email,
                                cameras: cameras,
                                runningWorkout: widget.choosenWorkout,
                                workoutSource: 2.2)));
                  },
                  child: Text(
                    "Free Training",
                    style: TextStyle(
                        fontSize: 25,
                        color: Color(0xff262e57),
                        fontFamily: "gothic"),
                  )),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    size: 15,
                    color: Color(0xff262e57),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Free Training: train without reps or sets",
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff262e57),
                        fontFamily: "gothic"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
