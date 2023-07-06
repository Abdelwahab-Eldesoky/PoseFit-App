import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pose_fit/Home.dart';

import 'classes/ApiManager.dart';
import 'classes/Workout.dart';

void main() {
  runApp(ChoosenPlanDetails("Hoba2001@gmail.com", "Beginner"));
}

// ignore: must_be_immutable
class ChoosenPlanDetails extends StatefulWidget {
  String email;
  String planName;

  ChoosenPlanDetails(this.email, this.planName);

  @override
  State<ChoosenPlanDetails> createState() => _ChoosenPlanDetailsState();
}

class _ChoosenPlanDetailsState extends State<ChoosenPlanDetails> {
  bool isLoaded = false;
  List<Workout> planWorkouts = [];

  Future<void> getData() async {
    List<Workout> tmp =
        await ApiManager.getPlanDetails(widget.planName).whenComplete(() {
      isLoaded = true;
    });

    tmp.forEach((element) {
      planWorkouts.add(element);
      print(element.name);
    });

    setState(() {});
  }

  void successfullyAssigned() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          icon: Icon(
            Icons.check_circle_outline_outlined,
            size: 30,
            color: Color(0xfff7a007),
          ),
          title: Center(
            child: Text(
              "New plan assigned",
              style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
            ),
          ),
          content:
              Text("You can find it now and start workout at today's plan",textAlign: TextAlign.center,style: TextStyle(fontSize: 25,fontFamily: "gothic"),),
          elevation: 30,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(widget.email),
                      ));
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
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/plan_back-01.jpg"),
                  fit: BoxFit.fill)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                title: Container(
                  margin: EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Color(0xff262e57),
                            size: 37,
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Plan",
                            style: TextStyle(
                                fontSize: 37,
                                color: Color(0xff262e57),
                                fontFamily: "power"),
                          ),
                          SizedBox(
                            width: 11,
                          ),
                          Text(
                            "Details",
                            style: TextStyle(
                                fontSize: 37,
                                color: Color(0xff262e57),
                                fontFamily: "power"),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: SizedBox(
                        height: 120,
                        child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: planWorkouts.length,
                      itemBuilder: (context, index) {
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
                                  child:
                                      Image.asset(planWorkouts[index].gifPath),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 13, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18, right: 25),
                                          child: Text(
                                            planWorkouts[index].name,
                                            style: TextStyle(
                                                fontFamily: "gothic",
                                                fontSize: 31),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 70, right: 5),
                                        child: Text(
                                            planWorkouts[index]
                                                    .sets
                                                    .toString() +
                                                " X " +
                                                planWorkouts[index]
                                                    .reps
                                                    .toString(),
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
                    ))),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 30),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(
                            220,
                            60,
                          )),
                          backgroundColor: MaterialStateProperty.all(
                              planWorkouts.length > 0
                                  ? Color(0xff262e57)
                                  : Colors.black12.withOpacity(0.3)),
                          shape:
                              MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ))),
                      onPressed: planWorkouts.length > 0
                          ? () {
                              if (planWorkouts.isNotEmpty) {
                                ApiManager.AssignPlan(
                                    widget.email, widget.planName);
                              }
                              successfullyAssigned();
                            }
                          : () {},
                      child: Text(
                        "Assign it",
                        style: TextStyle(fontSize: 25, fontFamily: "gothic"),
                      )),
                ),
              ],
            ),
          )),
    );
  }
}
