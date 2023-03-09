import 'package:flutter/material.dart';
import 'classes/Workout.dart';
import 'Home.dart';

/*void main() {
  runApp(WorkoutPage());
}*/

class TodayPlan extends StatelessWidget {
  List<Workout> todayWorkouts = [
    Workout(15, 3, "Bicep Curls", "assets/bicep_curls.gif"),
    Workout(20, 4, "Jumping Jacks", "assets/jumping_jacks.gif"),
    Workout(10, 5, "Lateral Raise", "assets/lateral_raise.gif"),
    Workout(15, 3, "Mountain Climpers", "assets/mountain_climbers.gif")
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/plan_back-01.jpg"),
                fit: BoxFit.cover)),
        child: Scaffold(
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
                        onPressed: () {},
                        iconSize: 34,
                        icon: Icon(
                          color: Colors.white,
                          Icons.stacked_line_chart,
                        )),
                    SizedBox(
                      width: 70,
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);
                        },
                        iconSize: 36,
                        icon: Icon(
                          color: Colors.white,
                          Icons.home_rounded,
                        )),
                    SizedBox(
                      width: 70,
                    ),
                    IconButton(
                        onPressed: () {},
                        iconSize: 34,
                        icon: Icon(
                          color: Colors.white,
                          Icons.account_circle_outlined,
                        ))
                  ]),
            ),
          ),
          backgroundColor: Colors.transparent,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Container(
                margin: EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Today",
                        style: TextStyle(
                            fontSize: 40,
                            color: Color(0xff262e57),
                            fontFamily: "power")),
                    Text(
                      "'",
                      style: TextStyle(
                          fontSize: 40,
                          color: Color(0xff262e57),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "s",
                      style: TextStyle(
                          fontSize: 40,
                          color: Color(0xff262e57),
                          fontFamily: "power"),
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "Plan",
                      style: TextStyle(
                          fontSize: 40,
                          color: Color(0xff262e57),
                          fontFamily: "power"),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: ListView.builder(
            scrollDirection: Axis.vertical,
            itemBuilder: (ctx, index) {
              return Container(
                height: 400,
                margin: EdgeInsets.fromLTRB(5, 5, 5, 25),
                child: Card(
                  elevation: 15,
                  color: Colors.white70,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        child: Image.asset(todayWorkouts[index].gifPath),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 13, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 18, right: 25),
                                child: Text(
                                  todayWorkouts[index].name,
                                  style: TextStyle(
                                      fontFamily: "gothic", fontSize: 31),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 70, right: 5),
                              child: Text(
                                  todayWorkouts[index].sets.toString() +
                                      " X " +
                                      todayWorkouts[index].reps.toString(),
                                  style: TextStyle(
                                      fontFamily: "gothic",
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold)),
                            ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: todayWorkouts.length,
          ),
        ),
      ),

      // ),
    );
  }
}
