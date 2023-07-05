import 'package:flutter/material.dart';
import 'package:pose_fit/classes/ApiManager.dart';
import '../Home.dart';
import 'package:pose_fit/classes/User.dart';

// ignore: must_be_immutable
class WorkoutDetailsRegister extends StatefulWidget {
  User activeUser;
  WorkoutDetailsRegister(this.activeUser);

  @override
  State<WorkoutDetailsRegister> createState() => _WorkoutDetailsRegisterState();
}

class _WorkoutDetailsRegisterState extends State<WorkoutDetailsRegister> {
  final List<String> labelValues = ["Not active","Lightly active","Medium active","Athlete"];
  double sliderIndex = 0;
  double bmi=0;
  String Plan="";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Register 4",
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 60, left: 15, right: 15, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: double.infinity),
              Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  'Workout',
                  style: TextStyle(
                    color: Color(0xfff7a007),
                    fontSize: 47,
                    fontFamily: "power",
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomRight,
                margin: EdgeInsets.only(right: 10),
                child: Text(
                  'Details',
                  style: TextStyle(
                    color: Color(0xfff7a007),
                    fontSize: 47,
                    fontFamily: "power",
                  ),
                ),
              ),
              SizedBox(
                height: 180,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "What's Your Activiy Level ?",
                  style: TextStyle(
                      fontFamily: "gothic",
                      fontSize: 22,
                      color: Color(0xff262e57)),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                    valueIndicatorColor: Colors.amber.shade500,
                    valueIndicatorTextStyle: TextStyle(
                        color: Color(0xff262e57),
                        fontFamily: "gothic",
                        fontWeight: FontWeight.w600)),
                child: Slider(
                  label: labelValues[sliderIndex.toInt()],
                  value: sliderIndex,
                  onChanged: (value) {
                    sliderIndex = value;
                    setState(() {});
                  },
                  min: 0,
                  max: 3,
                  thumbColor: Color(0xfff7a007),
                  divisions: 3,
                  activeColor: Color(0xff262e57),
                  inactiveColor: Colors.amber.shade400,
                ),
              ),
              /*SizedBox(height: 50,),
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Please Choose Your Workout Days",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: "gothic",
                      fontSize: 21,
                      color: Color(0xff262e57)),
                ),
              ),
              SizedBox(height: 30,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[

                    SizedBox(
                        height: 40,
                        width: 100,
                        child:ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  side:const BorderSide(
                                      width: 1.5,
                                      color: Color(0xff262e57)
                                  ),
                                  borderRadius: BorderRadius.circular(32.0),
                                ))
                            ),
                            onPressed: (){
                              print('teen 13-19');
                            }, child: Text("Sat",
                          style: TextStyle(fontSize: 23,color: Color(0xff262e57)),
                        ))
                    ),

                    SizedBox(
                        height: 40,
                        width: 100,
                        child:ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  side:const BorderSide(
                                      width: 1.5,
                                      color: Color(0xff262e57)
                                  ),
                                  borderRadius: BorderRadius.circular(32.0),
                                ))
                            ),
                            onPressed: (){
                              print('adult 20-30');
                            }, child: Text("Sun",
                          style: TextStyle(fontSize: 23,color: Color(0xff262e57)),
                        ))
                    ),

                    SizedBox(
                        height: 40,
                        width: 100,
                        child:ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  side:const BorderSide(
                                      width: 1.5,
                                      color: Color(0xff262e57)
                                  ),
                                  borderRadius: BorderRadius.circular(32.0),
                                ))
                            ),
                            onPressed: (){
                              print('adult 31-40');
                            }, child: Text("Mon",
                          style: TextStyle(fontSize: 23,color: Color(0xff262e57)),
                        ))
                    ),

                  ]
              ),
              SizedBox(height: 30,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[

                    SizedBox(
                        height: 40,
                        width: 100,
                        child:ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  side:const BorderSide(
                                      width: 1.5,
                                      color: Color(0xff262e57)
                                  ),
                                  borderRadius: BorderRadius.circular(32.0),
                                ))
                            ),
                            onPressed: (){
                              print('teen 13-19');
                            }, child: Text("Tue",
                          style: TextStyle(fontSize: 23,color: Color(0xff262e57)),
                        ))
                    ),

                    SizedBox(
                        height: 40,
                        width: 100,
                        child:ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  side:const BorderSide(
                                      width: 1.5,
                                      color: Color(0xff262e57)
                                  ),
                                  borderRadius: BorderRadius.circular(32.0),
                                ))
                            ),
                            onPressed: (){
                              print('adult 20-30');
                            }, child: Text("Wed",
                          style: TextStyle(fontSize: 23,color: Color(0xff262e57)),
                        ))
                    ),

                    SizedBox(
                        height: 40,
                        width: 100,
                        child:ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  side:const BorderSide(
                                      width: 1.5,
                                      color: Color(0xff262e57)
                                  ),
                                  borderRadius: BorderRadius.circular(32.0),
                                ))
                            ),
                            onPressed: (){
                              print('adult 31-40');
                            }, child: Text("Thu",
                          style: TextStyle(fontSize: 23,color: Color(0xff262e57)),
                        ))
                    ),

                  ]
              ),

              SizedBox(height: 30,),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[

                    SizedBox(
                        height: 40,
                        width: 100,
                        child:ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  side:const BorderSide(
                                      width: 1.5,
                                      color: Color(0xff262e57)
                                  ),
                                  borderRadius: BorderRadius.circular(32.0),
                                ))
                            ),
                            onPressed: (){
                              print('adult 41-50');
                            }, child: Text("Fri",
                          style: TextStyle(fontSize: 23,color: Color(0xff262e57)),
                        ))
                    ),
                  ]
              ),*/
              SizedBox(height: 40,),
              ElevatedButton(
                  style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(Size(
                        220,
                        60,
                      )),
                      backgroundColor: MaterialStateProperty.all(
                          Color(0xff262e57)),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ))),
                  onPressed: () async{
                    widget.activeUser.setActivityLevel=labelValues[sliderIndex.toInt()];
                    double newHieght=widget.activeUser.height/100;
                    bmi = widget.activeUser.weight / (newHieght * newHieght);

                    if (bmi < 18.5) {
                      Plan ="Beginner";
                    }
                    else if (bmi >= 18.5 && bmi <= 24.9) {
                      if (widget.activeUser.activityLevel == 'not active') {
                        Plan ="Beginner";
                      } else if (widget.activeUser.activityLevel == 'Lightly active') {
                        Plan="Intermediate";
                      } else if (widget.activeUser.activityLevel == 'Medium active' ||
                          widget.activeUser.activityLevel == 'Athlete') {
                        Plan="Advanced";
                      }
                    }
                    else if (bmi >= 25 && bmi <= 29.9) {
                      if (widget.activeUser.activityLevel == 'not active') {
                        Plan ="Beginner";
                      } else if (widget.activeUser.activityLevel == 'Lightly active'||widget.activeUser.activityLevel == 'Medium active') {
                        Plan="Intermediate";
                      } else if (widget.activeUser.activityLevel == 'Athlete') {
                        Plan="Advanced";
                      }
                    }
                    else if (bmi >= 30) {
                      if (widget.activeUser.activityLevel == 'not active' || widget.activeUser.activityLevel == 'Lightly active') {
                        Plan ="Beginner";
                      }  else if (widget.activeUser.activityLevel == 'Medium active') {
                        Plan="Intermediate";
                      } else if (widget.activeUser.activityLevel == 'Athlete') {
                        Plan="Advanced";
                      }
                    }
                    else{
                      Plan ="Beginner";
                    }
                    if(await ApiManager.signup(widget.activeUser)){
                      await ApiManager.AssignPlan(widget.activeUser.email, Plan);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage(widget.activeUser.getEmail)),
                    );}
                    else{
                      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                        backgroundColor: Color(0xff262e57),
                            content: new Text("Sorry, Your email is already in use")));
                        return;
                    }
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontFamily: "gothic"),
                  )),

            ],
          ),
        ),
      ),
    );
  }
}
