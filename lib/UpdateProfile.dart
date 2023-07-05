import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:pose_fit/Home.dart';
import 'package:pose_fit/Login.dart';
import 'package:pose_fit/WorkoutHistory.dart';
import 'package:pose_fit/classes/ApiManager.dart';
import 'package:pose_fit/classes/User.dart';

// ignore: must_be_immutable
class UpdateProfile extends StatefulWidget {
  String email;

  UpdateProfile(this.email);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController height = TextEditingController(text: '171');
  TextEditingController weight = TextEditingController(text: '60');

  TextEditingController password = TextEditingController(text: '123456789');
  TextEditingController rest = TextEditingController(text: '40 seconds');
  TextEditingController username = TextEditingController(text: 'Omar Othman');

  TextEditingController gender = TextEditingController(text: 'Male');
  TextEditingController email =
      TextEditingController(text: 'omarothamn@gmail.com');
  TextEditingController activityLevel = TextEditingController(text: 'Medium');
  TextEditingController passwordConfirmation = TextEditingController();

  User activeUser = new User(
      "name", "email", "password", "gender", "activityLevel", "plan", 0, 0, 0);

  bool isUsernameEmpty = false;
  bool isEmailEmpty = false;
  bool isHeightEmpty = false;
  bool isWeightEmpty = false;

  bool isBtnSaveEnabled = false;

  bool isPasswordValid = false;

  bool isPassConfirmationEmpty = false;

  bool isPasswordChanged=false;

  bool isLoaded=false;

  int secondsToRest = 20;

  bool isConfirming=false;

  String confirmationMessage="Enter your password to view and edit profile";

  void setActiveUser() async{
    activeUser=await ApiManager.getUserInfo(widget.email).whenComplete((){
      isLoaded=true;
    });
    setState(() {
      username.text=activeUser.username;
      password.text=activeUser.password;
      weight.text=activeUser.weight.toString();
      height.text=activeUser.height.toString();

      startUpdatingDialog();
    });
  }

  void startUpdatingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        {
          return AlertDialog(
            icon: Icon(
              Icons.question_mark_rounded,
              size: 40,
              color: Color(0xfff7a007),
            ),
            title: Center(
              child: Text(
                "Password Confirmation",
                style: TextStyle(
                    fontSize: 27,
                    color: Color(0xff262e57),
                    fontWeight: FontWeight.bold),
              ),
            ),
            content: Wrap(
              children: [
              isConfirming?SizedBox(
              height: 120,
              width: 120,
              child: CircularProgressIndicator(
                strokeWidth: 6,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xfff7a007)),
              ),
            ):Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white38.withOpacity(0.98),
                          borderRadius:
                          BorderRadius.all(Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xff262e57),
                                offset: Offset(0.3, 3.0),
                                blurStyle: BlurStyle.outer,
                                blurRadius: 2,
                                spreadRadius: 2)
                          ]),
                      child: TextField(
                        style: TextStyle(
                            fontFamily: "gothic", fontSize: 21),
                        controller: passwordConfirmation,
                        onChanged: (value) {
                          setState(() {
                            passwordConfirmation.text.isEmpty
                                ? isPassConfirmationEmpty = true
                                : isPassConfirmationEmpty = false;
                          });
                        },
                        decoration: InputDecoration(
                            errorText: isPassConfirmationEmpty
                                ? '    Can\'t Be Empty'
                                : null,
                            prefixIcon: Icon(Icons.lock_outline_rounded,
                                color: Color(0xff262e57), size: 28),
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(
                                fontFamily: "gothic", fontSize: 20),
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none
                          /*border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25)),*/
                        ),
                      ),
                    ),
                    SizedBox(height: 21,),
                    Text(confirmationMessage,textAlign: TextAlign.center,style: TextStyle(fontSize: 15,fontFamily: "gothic"),)
                  ],
                )
              ],
            ),
            elevation: 30,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(widget.email)),
                        );
                      },
                      child: Center(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "gothic",
                                color: Color(0xff262e57)),
                          ))),
                  TextButton(
                      onPressed: () async{
                        setState(() {
                          if(passwordConfirmation.text.isEmpty){
                            isPassConfirmationEmpty=true;
                          }
                          else {
                            isConfirming = true;
                          }
                        });

                        bool result=await ApiManager.PasswordConfirm(widget.email, passwordConfirmation.text).whenComplete(() {isConfirming=false;});

                        setState(() {
                          if(result){
                            Navigator.pop(context);
                          }
                          else{
                            passwordConfirmation.clear();
                            confirmationMessage="Not correct, Please try again";
                          }
                        });
                      },
                      child: Center(
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "gothic",
                                color: Color(0xff262e57)),
                          ))),
                ],
              )
            ],
          );
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    setActiveUser();
  }

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
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>
                            WorkoutHistory(widget.email)
                          ,));
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
                          "Your",
                          style: TextStyle(
                              fontSize: 37,
                              color: Color(0xff262e57),
                              fontFamily: "power"),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        Text(
                          "Profile",
                          style: TextStyle(
                              fontSize: 37,
                              color: Color(0xff262e57),
                              fontFamily: "power"),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Login(),
                              ),
                              (route) => false);
                        },
                        icon: Icon(
                          Icons.logout,
                          color: Color(0xff262e57),
                          size: 37,
                        )),
                  ],
                ),
              ),
            ),
          ),
          body: isLoaded? Container(
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
                        color: Color(0xff262e57)),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 30, bottom: 10),
                      child: Text(
                        "Username :",
                        style: TextStyle(
                            fontFamily: "gothic",
                            fontSize: 23,
                            color: Color(0xff262e57)),
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
                          isBtnSaveEnabled = true;
                          setState(() {
                            username.text.isEmpty
                                ? isUsernameEmpty = true
                                : isUsernameEmpty = false;
                          });
                        },
                        decoration: InputDecoration(
                            errorText: isUsernameEmpty
                                ? 'Username Can\'t Be Empty'
                                : null,
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
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 30, bottom: 10),
                      child: Text(
                        "Email :",
                        style: TextStyle(
                            fontFamily: "gothic",
                            fontSize: 23,
                            color: Color(0xff262e57)),
                      ),
                    ),
                    Text(
                      activeUser.email,
                      style: TextStyle(
                          fontFamily: "gothic",
                          fontSize: 23,
                          color: Color(0xff262e57)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 30, bottom: 10),
                      child: Text(
                        "Password :",
                        style: TextStyle(
                            fontFamily: "gothic",
                            fontSize: 23,
                            color: Color(0xff262e57)),
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
                          isPasswordChanged=true;
                          isBtnSaveEnabled = true;
                        },
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_outline_rounded,
                              color: Color(0xff262e57),
                              size: 28,
                            ),
                            hintText:
                                'Enter a new password, if you want change it',
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
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: FlutterPwValidator(
                      controller: password,
                      minLength: 8,
                      height: 20,
                      width: 250,
                      onSuccess: () {
                        isPasswordValid = true;
                      },
                      onFail: () {
                        isPasswordValid = false;
                      },
                      failureColor: Color(0xffc32b42),
                      successColor: Colors.green),
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 30, bottom: 10),
                      child: Text(
                        "Weight :",
                        style: TextStyle(
                            fontFamily: "gothic",
                            fontSize: 23,
                            color: Color(0xff262e57)),
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
                          isBtnSaveEnabled = true;
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
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 30, bottom: 10),
                      child: Text(
                        "Height :",
                        style: TextStyle(
                            fontFamily: "gothic",
                            fontSize: 23,
                            color: Color(0xff262e57)),
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
                          isBtnSaveEnabled = true;
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
                SizedBox(
                  height: 30,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(left: 10),
                  child: Text(
                    "Training Information",
                    style: TextStyle(
                        fontFamily: "gothic",
                        fontSize: 27,
                        color: Color(0xff262e57)),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 30, bottom: 10),
                      child: Text(
                        "Activity Level :",
                        style: TextStyle(
                            fontFamily: "gothic",
                            fontSize: 23,
                            color: Color(0xff262e57)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        activeUser.activityLevel,
                        style: TextStyle(
                            fontFamily: "gothic",
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff262e57)),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(Size(
                              220,
                              60,
                            )),
                            backgroundColor: MaterialStateProperty.all(
                                isBtnSaveEnabled
                                    ? Color(0xff262e57)
                                    : Colors.black54),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ))),
                        onPressed: isBtnSaveEnabled
                            ? () {
                                if (isPasswordValid &&
                                    !isUsernameEmpty &&
                                    !isWeightEmpty &&
                                    !isHeightEmpty) {
                                  //////////////
                                  //////////////
                                  /////////////
                                  /////////////
                                  ////////////
                                  User tmp = new User(
                                      username.text,
                                      activeUser.email,
                                      isPasswordChanged?password.text:passwordConfirmation.text,
                                      activeUser.gender,
                                      activeUser.activityLevel,
                                      activeUser.plan,
                                      double.parse(weight.text),
                                      double.parse(height.text),
                                      activeUser.age);
                                  ApiManager.UpdateInfo(tmp);

                                  Navigator.push(context,MaterialPageRoute(builder: (context) => HomePage(widget.email),));
                                }
                              }
                            : null,
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Save",
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontFamily: "gothic"),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Icon(
                                Icons.save_alt,
                                color: Colors.white,
                                size: 27,
                              )
                            ],
                          ),
                        )),
                  ],
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
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
    );
  }
}
