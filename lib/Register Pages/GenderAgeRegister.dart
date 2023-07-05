import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pose_fit/classes/User.dart';

import 'WorkoutDetailsRegister.dart';

// ignore: must_be_immutable
class GenderAgeRegister extends StatefulWidget {
  User activeUser;

  GenderAgeRegister(this.activeUser);

  @override
  State<GenderAgeRegister> createState() => _GenderAgeRegisterState();
}

class _GenderAgeRegisterState extends State<GenderAgeRegister> {
  int isGenderChecked = -1;
  int age = 18;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Register 3",
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
            SizedBox(height: 60),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Please Choose Your Gender",
                style: TextStyle(
                    fontFamily: "gothic",
                    fontSize: 22,
                    color: Color(0xff262e57)),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () => setState(() => isGenderChecked = 0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: isGenderChecked == 0
                            ? Color(0xfff7a007).withOpacity(0.7)
                            : Colors.transparent,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(55),
                            bottomLeft: Radius.circular(55),
                            bottomRight: Radius.circular(55))),
                    height: 150,
                    width: 150,
                    child: Image.asset("assets/MaleSign-01.png"),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: () => setState(() => isGenderChecked = 1),
                  child: Container(
                    decoration: BoxDecoration(
                        color: isGenderChecked == 1
                            ? Color(0xfff7a007).withOpacity(0.7)
                            : Colors.transparent,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(55),
                            topLeft: Radius.circular(55),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(55))),
                    height: 150,
                    width: 150,
                    child: Image.asset("assets/FemaleSign-01.png"),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 65,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                "Please Choose Your Age Range",
                style: TextStyle(
                    fontFamily: "gothic",
                    fontSize: 22,
                    color: Color(0xff262e57)),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            NumberPicker(
                minValue: 12,
                maxValue: 70,
                value: age,
                itemCount: 3,
                haptics: true,
                axis: Axis.horizontal,
                textStyle: TextStyle(
                    fontSize: 20,
                    color: Color(0xff262e57),
                    fontFamily: "gothic"),
                selectedTextStyle: TextStyle(
                    fontSize: 40,
                    color: Color(0xfff7a007),
                    fontFamily: "gothic",
                    fontWeight: FontWeight.bold),
                onChanged: (value) {
                  age = value;
                  setState(() {});
                }),
            SizedBox(
              height: 75,
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
                  if (isGenderChecked == -1) {
                    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                        backgroundColor: Color(0xff262e57),
                        content: new Text("Please choose your gender")));
                    return;
                  }
                  if (isGenderChecked == 0) {
                    widget.activeUser.setGender = "male";
                  } else {
                    widget.activeUser.setGender = "female";
                  }
                  widget.activeUser.setAge = age;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            WorkoutDetailsRegister(widget.activeUser)),
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
      )),
    );
  }
}
