
import 'package:flutter/material.dart';
import 'GenderAgeRegister.dart';
import 'package:pose_fit/classes/User.dart';
import 'dart:ui';


class WeightHeightRegister extends StatelessWidget {
  User activeUser;
  WeightHeightRegister(this.activeUser);

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Register 2",
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(top: 75, left: 10, right: 10, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(width: double.infinity),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'About',
                    style: TextStyle(
                      color: Color(0xfff7a007),
                      fontSize: 52.5,
                      fontFamily: "power",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'You',
                    style: TextStyle(
                      color: Color(0xfff7a007),
                      fontSize: 52.5,
                      fontFamily: "power",
                    ),
                  ),
                ],
              ),
              SizedBox(height: 110),
              Expanded(child: SizedBox(
                height: 100,
                child: ListView(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Please Insert Your Weight",
                        style: TextStyle(
                            fontFamily: "gothic",
                            fontSize: 22,
                            color: Color(0xff262e57)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                          color: Colors.white38.withOpacity(0.98),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xff262e57),
                                offset: Offset(0.3, 3.0),
                                blurStyle: BlurStyle.outer,
                                blurRadius: 2,
                                spreadRadius: 2)
                          ]),
                      child: TextField(
                        style: TextStyle(fontFamily: "gothic", fontSize: 21),
                        controller: weightController,
                        keyboardType: TextInputType.numberWithOptions(signed: false),
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_circle,
                                color: Color(0xff262e57), size: 28),
                            hintText: 'Weight',
                            hintStyle: TextStyle(fontFamily: "gothic", fontSize: 20),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none
                          /*border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)),*/
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Please Insert Your Height",
                        style: TextStyle(
                            fontFamily: "gothic",
                            fontSize: 22,
                            color: Color(0xff262e57)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                          color: Colors.white38.withOpacity(0.98),
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xff262e57),
                                offset: Offset(0.3, 3.0),
                                blurStyle: BlurStyle.outer,
                                blurRadius: 2,
                                spreadRadius: 2)
                          ]),
                      child: TextField(
                        style: TextStyle(fontFamily: "gothic", fontSize: 21),
                        controller: heightController,
                        keyboardType: TextInputType.numberWithOptions(signed: false),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Color(0xff262e57),
                              size: 28,
                            ),
                            hintText: 'Height',
                            hintStyle: TextStyle(fontFamily: "gothic", fontSize: 20),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none
                          /*border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)),*/
                        ),
                      ),
                    ),
                    SizedBox(height: 100,),
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
                        onPressed: () {
                          activeUser.setWeight=50;
                          activeUser.setHeight=150;

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GenderAgeRegister(activeUser)),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Next",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontFamily: "gothic"),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Icon(Icons.arrow_forward_ios_rounded)
                          ],
                        )),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
