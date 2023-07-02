import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:pose_fit/CameraPage.dart';
import 'package:pose_fit/ChoosePlan.dart';
import 'package:pose_fit/UpdateProfile.dart';
import 'package:pose_fit/WorkoutHistory.dart';
import 'package:pose_fit/classes/ApiManager.dart';
import 'package:pose_fit/classes/DailyChallenge.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'RankingBoard.dart';
import 'TodayPlan.dart';
import 'SearchWorkout.dart';
import 'classes/Workout.dart';

void main() {
  runApp(HomePage("Hoba2001@gmail.com"));
}

class HomePage extends StatefulWidget {
  final String email;

  HomePage(this.email);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = "";
  DailyChallenge todayChallenge=DailyChallenge(new Workout.fromWorkout("Not Loaded Yet","",""), "", 0, "");
  List<CameraDescription> cameras = [];

  Future<void> getName() async {
    name = await ApiManager.getPersonName(widget.email);
    setState(() {});
  }

  Future<void> setCameras() async {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  }

  Future<void> getTodayChallenge() async {
    print("ana t3baaaaaaaaaaaaaaan");
    todayChallenge = await ApiManager.getChallenge();
    setState(() {
      print(todayChallenge.reps);
    });
  }

  List<ProgressData> _chartData = [
    ProgressData("15.02", 30),
    ProgressData("16.02", 45),
    ProgressData("17.02", 50),
    ProgressData("18.02", 20),
    ProgressData("19.02", 70),
  ];

  void initState() {
    super.initState();
    setCameras();
    getName();
    getTodayChallenge();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Home",
        home: Builder(builder: (context) {
          return Scaffold(
            bottomNavigationBar: SafeArea(
              child: Container(
                height: 63,
                padding: EdgeInsets.all(4),
                margin: EdgeInsets.only(right: 10, left: 10, bottom: 10),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff262e57),
                        blurStyle: BlurStyle.outer,
                        spreadRadius: 0.1,
                        blurRadius: 3,
                      )
                    ],
                    color: Color(0xff262e57).withOpacity(0.95),
                    borderRadius: BorderRadius.all(Radius.circular(35))),
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
                          icon: Icon(
                            color: Colors.white,
                            Icons.history_rounded,
                          )),
                      SizedBox(
                        width: 70,
                      ),
                      Column(
                        children: [
                          IconButton(
                              onPressed: () {},
                              iconSize: 34,
                              icon: Icon(
                                color: Colors.white,
                                Icons.home_rounded,
                              )),
                          Container(
                            width: 30,
                            height: 3,
                            decoration: BoxDecoration(
                                color: Color(0xfff7a007),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                          )
                        ],
                      ),
                      SizedBox(
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
                          icon: Icon(
                            color: Colors.white,
                            Icons.account_circle_outlined,
                          ))
                    ]),
              ),
            ),
            body: ListView(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  decoration: BoxDecoration(
                      color: Color(0xff262e57),
                      borderRadius: BorderRadius.all(Radius.circular(150))),
                  height: 100,
                  alignment: Alignment.center,
                  child: Text(
                    "Hi, $name",
                    style: TextStyle(
                        color: Color(0xffffffff),
                        fontFamily: "gothic",
                        fontSize: 29,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  height: 185,
                  margin: EdgeInsets.fromLTRB(2, 10, 2, 0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      //Daily Challenge =============================
                      Card(
                        margin: const EdgeInsets.all(5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 5,
                        child: Container(
                          height: 140,
                          width: 300,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                      Color.fromRGBO(38, 46, 87, 0.8),
                                      BlendMode.darken),
                                  image: AssetImage("assets/dailyback-01.png"),
                                  fit: BoxFit.cover)),
                          child: Stack(children: [
                            ListTile(
                              contentPadding: EdgeInsets.all(20),
                              title: Text(
                                'Daily\nChallenge',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontFamily:
                                      "gothic", /*fontWeight: FontWeight.bold*/
                                ),
                              ),
                              subtitle: Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text(
                                  todayChallenge.workout.name,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontFamily: "gothic",
                                      fontWeight: FontWeight.bold),
                                ),
                              ),

                              //isThreeLine: true,
                            ),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CameraApp(email: widget.email,cameras: cameras, runningWorkout: todayChallenge.workout, workoutSource: 3.0)
                                    ));
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        "Start The Challenge",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontFamily: "gothic",
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Color(0xfff7a007),
                                      )
                                    ],
                                  )),
                            ),
                            Container(
                              padding: EdgeInsets.all(15),
                              alignment: Alignment.topRight,
                              child: TextButton(
                                onPressed: () {
                                  print("he5aaa");
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        icon: Icon(
                                          Icons.info_outline_rounded,
                                          size: 30,
                                          color: Color(0xfff7a007),
                                        ),
                                        title: Center(
                                          child: Text(
                                            "Daily Challenge Description",
                                            style: TextStyle(
                                                fontSize: 27,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        content: RichText(
                                            textAlign: TextAlign.center,
                                            text: TextSpan(
                                                style: TextStyle(
                                                  color: Color(0xff262e57),
                                                  fontFamily: "gothic",
                                                ), //apply style to all
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          '\nDaily Challenge is challenge that changed every day to be like competition between user and rank will appear in Ranking board\n\n\n ',
                                                      style: TextStyle(
                                                          fontSize: 25)),
                                                  TextSpan(
                                                      text:
                                                          'Idea:\nTry to train max repetitions in less time',
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Color(
                                                              0xfff7a007))),
                                                ])),
                                        elevation: 30,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30))),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Center(
                                                  child: Text(
                                                "OK",
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    fontFamily: "gothic",
                                                    color: Color(0xff262e57)),
                                              )))
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.info_outline_rounded,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),

                      //Daily Challenge End =============================

                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RankingBoard(widget.email)),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 5,
                          child: Container(
                            height: 140,
                            width: 300,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                        Color.fromRGBO(38, 46, 87, 0.8),
                                        BlendMode.darken),
                                    image: AssetImage("assets/bar_chart-01.png"),
                                    fit: BoxFit.cover)),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(20),
                              title: Text(
                                'Ranking\nBoard',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontFamily: "gothic",
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text(
                    "Training",
                    style: TextStyle(
                        fontSize: 27,
                        fontFamily: "gothic",
                        fontWeight: FontWeight.bold,
                        color: Color(0xff262e57)),
                  ),
                ),
                Container(
                  height: 225,
                  margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TodayPlan(widget.email, 0)),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 5,
                          child: Container(
                            alignment: Alignment.topLeft,
                            height: 225,
                            width: 160,
                            decoration:
                                const BoxDecoration(color: Color(0xff262e57)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                                  child: Image(
                                      image: AssetImage(
                                          "assets/dumbel_icon-01.png"),
                                      width: 48,
                                      height: 48),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: Text(
                                    "Continue\non your\nplan",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: "gothic",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChoosePlan(widget.email)),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 5,
                          child: Container(
                            alignment: Alignment.topLeft,
                            height: 225,
                            width: 160,
                            decoration:
                                const BoxDecoration(color: Color(0xffab2b3e)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                                  child: Image(
                                      image: AssetImage(
                                          "assets/selection_icon.png"),
                                      width: 48,
                                      height: 48),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: Text(
                                    "Choose\nanother\nplan",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: "gothic",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SearchWorkout(widget.email)),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 5,
                          child: Container(
                            alignment: Alignment.topLeft,
                            height: 225,
                            width: 160,
                            decoration:
                                const BoxDecoration(color: Color(0xfff7a007)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                                  child: Image(
                                      image:
                                          AssetImage("assets/search_icon.png"),
                                      width: 48,
                                      height: 48),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: Text(
                                    "Search\nfor specific\nworkout",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: "gothic",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text(
                    "Activity",
                    style: TextStyle(
                        fontSize: 27,
                        fontFamily: "gothic",
                        fontWeight: FontWeight.bold,
                        color: Color(0xff262e57)),
                  ),
                ),
                Container(
                  height: 260,
                  child: SfCartesianChart(
                    title:
                        ChartTitle(text: "your activity by minutes everyday"),
                    series: <ChartSeries>[
                      LineSeries<ProgressData, double>(
                          name: 'Activity',
                          dataSource: _chartData,
                          xValueMapper: (ProgressData progress, _) =>
                              double.parse(progress.date),
                          yValueMapper: (ProgressData progress, _) =>
                              progress.minutes,
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true)
                    ],
                  ),
                )
              ],
            ),
          );
        }));
  }
}

class ProgressData {
  ProgressData(this.date, this.minutes);

  final String date;
  final double minutes;
}
