import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:pose_fit/Home.dart';

class UpdateProfile extends StatefulWidget {
  String email;

  UpdateProfile(this.email);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController height = TextEditingController(text: '171');
  TextEditingController weight = TextEditingController(text: '60');

  TextEditingController password = TextEditingController();
  TextEditingController rest = TextEditingController(text: '40 seconds');
  TextEditingController username = TextEditingController(text: 'Omar Othman');

  TextEditingController gender = TextEditingController(text: 'Male');
  TextEditingController email =
      TextEditingController(text: 'omarothamn@gmail.com');
  TextEditingController activityLevel = TextEditingController(text: 'Medium');

  bool isUsernameEmpty=false;
  bool isEmailEmpty=false;
  bool isHeightEmpty=false;
  bool isWeightEmpty=false;

  bool isBtnSaveEnabled=false;

  int secondsToRest=20;

  String currentActivityLevel="Lightly Active";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/update_back-01.jpg"),
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
                    Column(
                      children: [
                        IconButton(
                            onPressed: () {},
                            iconSize: 34,
                            icon: Icon(
                              color: Colors.white,
                              Icons.account_circle_outlined,
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
                    )
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
                    Text(
                      "Your",
                      style: TextStyle(
                          fontSize: 40,
                          color: Color(0xff262e57),
                          fontFamily: "power"),
                    ),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      "Profile",
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
          body: Container(
            child: ListView(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "Personal Information",
                    style: TextStyle(
                        fontFamily: "gothic",
                        fontSize: 27,
                        color: Color(0xff262e57)
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 30,bottom: 10),
                      child: Text(
                        "Username :",
                        style: TextStyle(
                            fontFamily: "gothic",
                            fontSize: 23,
                            color: Color(0xff262e57)
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
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
                        controller: username,
                        onChanged: (value) {
                          setState(() {
                            username.text.isEmpty
                                ? isUsernameEmpty = true
                                : isUsernameEmpty = false;
                          });
                        },
                        decoration: InputDecoration(
                            errorText:
                            isUsernameEmpty ? 'Username Can\'t Be Empty' : null,
                            prefixIcon: Icon(
                              Icons.account_circle,
                              color: Color(0xff262e57),
                              size: 28,
                            ),
                            hintText: 'Enter Username',
                            hintStyle:
                            TextStyle(fontFamily: "gothic", fontSize: 20),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none
                          /*border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25)),*/
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 30,bottom: 10),
                      child: Text(
                        "Email :",
                        style: TextStyle(
                            fontFamily: "gothic",
                            fontSize: 23,
                            color: Color(0xff262e57)
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
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
                        controller: email,
                        onChanged: (value) {
                          setState(() {
                            email.text.isEmpty
                                ? isEmailEmpty = true
                                : isEmailEmpty = false;
                          });
                        },
                        decoration: InputDecoration(
                            errorText:
                            isEmailEmpty ? 'Email Can\'t Be Empty' : null,
                            prefixIcon: Icon(
                              Icons.mail_outline_rounded,
                              color: Color(0xff262e57),
                              size: 28,
                            ),
                            hintText: 'Enter your Email',
                            hintStyle:
                            TextStyle(fontFamily: "gothic", fontSize: 20),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none
                          /*border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25)),*/
                        ),
                      ),
                    ),
                  ],
                )
                ,SizedBox(height: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 30,bottom: 10),
                      child: Text(
                        "Password :",
                        style: TextStyle(
                            fontFamily: "gothic",
                            fontSize: 23,
                            color: Color(0xff262e57)
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
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
                        obscureText: true,
                        style: TextStyle(fontFamily: "gothic", fontSize: 21),
                        controller: password,
                        onChanged: (value) {
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outline_rounded,
                              color: Color(0xff262e57),
                              size: 28,
                            ),
                            hintText: 'Enter a new password',
                            hintStyle:
                            TextStyle(fontFamily: "gothic", fontSize: 20),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none
                          /*border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25)),*/
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 30,bottom: 10),
                      child: Text(
                        "Weight :",
                        style: TextStyle(
                            fontFamily: "gothic",
                            fontSize: 23,
                            color: Color(0xff262e57)
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
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
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontFamily: "gothic", fontSize: 21),
                        controller: weight,
                        onChanged: (value) {
                          setState(() {
                            weight.text.isEmpty
                                ? isWeightEmpty = true
                                : isWeightEmpty = false;
                          });
                        },
                        decoration: InputDecoration(
                            errorText:
                            isWeightEmpty ? 'Weight Can\'t Be Empty' : null,
                            prefixIcon: Icon(
                              Icons.monitor_weight_outlined,
                              color: Color(0xff262e57),
                              size: 28,
                            ),
                            hintText: 'Weight',
                            hintStyle:
                            TextStyle(fontFamily: "gothic", fontSize: 20),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none
                          /*border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25)),*/
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height:20 ,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 30,bottom: 10),
                      child: Text(
                        "Height :",
                        style: TextStyle(
                            fontFamily: "gothic",
                            fontSize: 23,
                            color: Color(0xff262e57)
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
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
                        keyboardType: TextInputType.number,
                        style: TextStyle(fontFamily: "gothic", fontSize: 21),
                        controller: height,
                        onChanged: (value) {
                          setState(() {
                            height.text.isEmpty
                                ? isHeightEmpty = true
                                : isHeightEmpty = false;
                          });
                        },
                        decoration: InputDecoration(
                            errorText:
                            isHeightEmpty ? 'Height Can\'t Be Empty' : null,
                            prefixIcon: Icon(
                              Icons.account_circle,
                              color: Color(0xff262e57),
                              size: 28,
                            ),
                            hintText: 'Enter your Height',
                            hintStyle:
                            TextStyle(fontFamily: "gothic", fontSize: 20),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none
                          /*border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25)),*/
                        ),
                      ),
                    ),
                  ],
                ),
            SizedBox(height: 30,)
                ,Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "Training Information",
                    style: TextStyle(
                        fontFamily: "gothic",
                        fontSize: 27,
                        color: Color(0xff262e57)
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 30,bottom: 10),
                      child: Text(
                        "Rest Duration :",
                        style: TextStyle(
                            fontFamily: "gothic",
                            fontSize: 23,
                            color: Color(0xff262e57)
                        ),
                      ),
                    ),
                    Center(
                      child: NumberPicker(
                          minValue: 10,
                          maxValue: 60,
                          axis: Axis.horizontal,
                          value: secondsToRest,
                          haptics: true,
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: Color(0xff262e57),
                              fontFamily: "gothic"),
                          selectedTextStyle: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Color(0xfff7a007),
                              fontFamily: "gothic"),
                          onChanged: (value) {
                            setState(() {
                              secondsToRest = value;
                            });
                          }),
                    ),Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10),
                      child: Text(
                        "Seconds",
                        style: TextStyle(
                            fontFamily: "gothic",
                            fontSize: 23,
                            color: Color(0xff262e57)
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 30,bottom: 10),
                      child: Text(
                        "Activity Level :",
                        style: TextStyle(
                            fontFamily: "gothic",
                            fontSize: 23,
                            color: Color(0xff262e57)
                        ),
                      ),
                    ),Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        currentActivityLevel,
                        style: TextStyle(
                            fontFamily: "gothic",
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff262e57)
                        ),
                      ),
                    ),
                    SizedBox(height: 30,),
                    ElevatedButton(
                        style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(Size(
                              220,
                              60,
                            )),
                            backgroundColor: MaterialStateProperty.all(
                                isBtnSaveEnabled? Color(0xff262e57):Colors.black54),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ))),
                        onPressed: isBtnSaveEnabled? () {
                        }: null ,
                        child: Container(
                          margin:EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:<Widget>[
                              Text(
                                "Save",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: "gothic"),
                              ),
                              SizedBox(width: 50,),
                              Icon(Icons.save_alt,color: Colors.white,size: 27,)
                            ],
                          ),
                        )),
                  ],
                ),
                SizedBox(height: 30,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
