import 'package:flutter/material.dart';
import 'package:pose_fit/Home.dart';
import 'package:pose_fit/classes/ApiManager.dart';

import 'UpdateProfile.dart';
import 'classes/WorkoutHistoryEntry.dart';

void main() {
  runApp(WorkoutHistory("asasdasdsdasd"));
}

class WorkoutHistory extends StatefulWidget {
  String email;

  WorkoutHistory(this.email);

  @override
  State<WorkoutHistory> createState() => _WorkoutHistoryState();
}

class _WorkoutHistoryState extends State<WorkoutHistory> {
  final searchController = TextEditingController();

  bool isWorkoutHistoryEmpty = true;
  bool isPlanHistoryEmpty = true;
  bool isLoaded = false;

  /*
    new History("Biceps Curl", "25-6-2023", 20, 89),
    new History("Jumping Jacks", "12-3-2021", 10, 96),
    new History("Deadlift", "1-9-2022", 8, 75),
    new History("Biceps Curl", "25-6-2023", 30, 92),
  */

  List<WorkoutHistoryEntry> myWorkoutsHistory = [];
  List<WorkoutHistoryEntry> filteredWorkoutsHistory = [];

  /////////DON'T FORGET TO CHANGE DATA_TYPE TO PLAN//////////
  List<WorkoutHistoryEntry> myPlansHistory = [];
  List<WorkoutHistoryEntry> filteredPlansHistory = [];

  //////////////////////////////////////////////////////////

  void initHistories() async {
    List<WorkoutHistoryEntry> tmp = await ApiManager.getHistory(widget.email).whenComplete(() {
      isLoaded=true;
    });

    tmp.forEach((historyEntry) {
      myWorkoutsHistory.add(historyEntry);
    });

    setState(() {
      fillFilteredByAll();
      myWorkoutsHistory.isEmpty
          ? isWorkoutHistoryEmpty = true
          : isWorkoutHistoryEmpty = false;
      myPlansHistory.isEmpty
          ? isPlanHistoryEmpty = true
          : isPlanHistoryEmpty = false;
    });
  }

  void fillFilteredByAll() {
    myWorkoutsHistory.forEach((workout) {
      filteredWorkoutsHistory.add(workout);
    });

    myPlansHistory.forEach((plan) {
      filteredPlansHistory.add(plan);
    });
  }

  void initState() {
    super.initState();

    initHistories();
    //fillFilteredByAll();

    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.white,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {},
                              iconSize: 34,
                              icon: Icon(
                                color: Colors.white,
                                Icons.history_rounded,
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
                                  builder: (context) => HomePage(widget.email)),
                            );
                          },
                          iconSize: 34,
                          icon: Icon(
                            color: Colors.white,
                            Icons.home_rounded,
                          )),
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
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(120),
              child: AppBar(
                backgroundColor: Color(0xff262e57).withOpacity(0.06),
                elevation: 0,
                title: Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Track",
                        style: TextStyle(
                            fontSize: 40,
                            color: Color(0xff262e57),
                            fontFamily: "power"),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Text(
                        "History",
                        style: TextStyle(
                            fontSize: 40,
                            color: Color(0xff262e57),
                            fontFamily: "power"),
                      ),
                    ],
                  ),
                ),
                bottom: TabBar(
                  onTap: (index) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  labelPadding: EdgeInsets.only(top: 10),
                  indicator: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          topLeft: Radius.circular(15))),
                  tabs: [
                    Text(
                      "Workouts",
                      style: TextStyle(
                          fontSize: 27,
                          fontFamily: "gothic",
                          color: Color(0xfff7a007)),
                    ),/*
                    Text(
                      "Plans",
                      style: TextStyle(
                          fontSize: 27,
                          fontFamily: "gothic",
                          color: Color(0xfff7a007)),
                    )*/
                  ],
                ),
              ),
            ),
            body: isLoaded?TabBarView(
              children: [
                isWorkoutHistoryEmpty
                    ? noHistoryMessage()
                    : WorkoutsListBuilder(),
              ],
            ):Center(
              child: SizedBox(
                height: 150,
                width: 150,
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xfff7a007)),
                ),
              ),
            )
          ),
        ),
      ),
    );
  }

  Widget noHistoryMessage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(width: double.infinity),
        Image(image: AssetImage("assets/nohistory-01.jpg")),
        SizedBox(
          height: 15,
        ),
        Text(
          "Start Training to make history",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 23,
            fontFamily: "gothic",
          ),
        )
      ],
    );
  }

  Widget WorkoutsListBuilder() {
    return Column(
      children: [
        CustomizedSearchBar("Workout"),
        Expanded(
          child: ListView.builder(
            itemCount: filteredWorkoutsHistory.length,
            itemBuilder: (context, index) {
              return Container(
                height: 190,
                margin: EdgeInsets.fromLTRB(5, 15, 5, 10),
                child: Card(
                  elevation: 0,
                  color: Colors.orange.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: [
                            Text(
                              "Workout:  ",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: "gothic",
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              filteredWorkoutsHistory[index].workoutName,
                              style:
                                  TextStyle(fontSize: 24, fontFamily: "gothic"),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Date:  ",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: "gothic",
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                            getFormattedDate(DateTime.parse(
                                filteredWorkoutsHistory[index].date)),
                              style:
                                  TextStyle(fontSize: 24, fontFamily: "gothic"),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Total Reps:  ",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: "gothic",
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              filteredWorkoutsHistory[index]
                                  .reps
                                  .toString(),
                              style:
                                  TextStyle(fontSize: 24, fontFamily: "gothic"),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              "Performance:  ",
                              style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: "gothic",
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              filteredWorkoutsHistory[index]
                                      .performance.ceil()
                                      .toString() +
                                  " %",
                              style:
                                  TextStyle(fontSize: 24, fontFamily: "gothic"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget CustomizedSearchBar(String choice) {
    return Container(
        margin: EdgeInsets.only(left: 30, right: 30, top: 45, bottom: 20),
        child: TextField(
          controller: searchController,
          autofocus: false,
          onChanged: (value) => {filterValues(value, choice)},
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xff262e57), width: 1.5),
                borderRadius: BorderRadius.all(Radius.circular(45))),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xfff7a007), width: 2),
                borderRadius: BorderRadius.all(Radius.circular(45))),
            hintText: 'Enter ${choice} Name',
            hintStyle: TextStyle(
                fontFamily: "gothic", fontSize: 20, color: Colors.grey),
            prefixIcon: Icon(
              Icons.search,
              size: 30,
              color: Color(0xff262e57),
            ),
            suffixIcon: searchController.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: Color(0xff262e57),
                      size: 35,
                    ),
                    onPressed: () {
                      searchController.clear();
                      filterValues("", choice);
                    },
                  ),
          ),
        ));
  }

  void filterValues(String value, String choice) {
    filteredWorkoutsHistory.clear();
    filteredPlansHistory.clear();
    setState(() {
      if (value == "") {
        fillFilteredByAll();
        return;
      }

      if (choice == "Workout") {
        myWorkoutsHistory.forEach((workout) {
          if (workout.workoutName.toLowerCase().contains(value.toLowerCase())) {
            filteredWorkoutsHistory.add(workout);
          }
        });
      } else {}
    });
  }

  String getFormattedDate(DateTime myDate) {
    String formatted = "";

    formatted = formatted +
        myDate.day.toString() +
        "-" +
        myDate.month.toString() +
        "-" +
        myDate.year.toString() +
        "  " +
        myDate.hour.toString() +
        ":" +
        myDate.month.toString();

    return formatted;
  }
}
