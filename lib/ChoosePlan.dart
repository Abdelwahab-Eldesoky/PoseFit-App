import 'package:flutter/material.dart';
import 'package:pose_fit/ChoosenPlanDetails.dart';
import 'package:pose_fit/UpdateProfile.dart';
import 'package:pose_fit/classes/ApiManager.dart';

import 'Home.dart';
import 'classes/Level.dart';

class ChoosePlan extends StatefulWidget {
  final String email;

  ChoosePlan(this.email);

  @override
  State<ChoosePlan> createState() => _ChoosePlanState();
}

class _ChoosePlanState extends State<ChoosePlan> {
  List<Level> allPlans = [
    Level("Beginner", "assets/easy-01.jpg"),
    Level("Intermediate", "assets/medium-01.jpg"),
    Level("Advanced", "assets/hard-01.jpg")
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
                        onPressed: () {
                          ApiManager.getHistory(widget.email);
                        },
                        iconSize: 34,
                        icon: Icon(
                          color: Colors.white,
                          Icons.history_rounded,
                        )),
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
                        iconSize: 36,
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
                                builder: (context) => UpdateProfile(widget.email)),
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
                    Text("Choose",
                        style: TextStyle(
                            fontSize: 40,
                            color: Color(0xff262e57),
                            fontFamily: "power")),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "a",
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
                height: 218,
                margin: EdgeInsets.fromLTRB(5, 5, 5, 25),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChoosenPlanDetails(widget.email,allPlans[index].label)),
                    );
                  },
                  child: Card(
                    elevation: 15,
                    color: Colors.white70,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Stack(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Image.asset(allPlans[index].imagePath),
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          margin: EdgeInsets.fromLTRB(20, 0, 0, 20),
                          child: Text(
                            allPlans[index].label,
                            style: TextStyle(
                                fontFamily: "gothic",
                                fontWeight: FontWeight.bold,
                                fontSize: 34),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            itemCount: allPlans.length,
          ),
        ),
      ),

      // ),
    );
  }
}
