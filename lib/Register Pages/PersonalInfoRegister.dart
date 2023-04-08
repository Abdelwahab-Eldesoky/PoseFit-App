import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';

import '../classes/User.dart';
import 'WeightHeightRegister.dart';

class PersonalInfoRegister extends StatefulWidget {
  @override
  State<PersonalInfoRegister> createState() => _PersonalInfoRegisterState();
}

class _PersonalInfoRegisterState extends State<PersonalInfoRegister> {
  bool isUsernameEmpty = false;

  bool isEmailEmpty = false;

  bool isEmailValid = false;

  bool isPasswordValid = false;

  bool isMatched = true;

  TextEditingController email = TextEditingController();

  TextEditingController username = TextEditingController();

  TextEditingController password = TextEditingController();

  TextEditingController confirm_password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Register 1",
        home: Builder(builder: (context) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/Register1Back-01.jpg",
                  ),
                  fit: BoxFit.cover),
            ),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Container(
                  padding: const EdgeInsets.all(30),
                  margin: EdgeInsets.only(top: 90, left: 5, right: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Create',
                          style: TextStyle(
                            color: Color(0xffB00B25),
                            fontSize: 52.5,
                            fontFamily: "power",
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Account',
                          style: TextStyle(
                            color: Color(0xffB00B25),
                            fontSize: 52.5,
                            fontFamily: "power",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      Expanded(
                          child: SizedBox(
                        height: 100,
                        child: ListView(
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
                                controller: username,
                                onChanged: (value) {
                                  setState(() {
                                    username.text.isEmpty
                                        ? isUsernameEmpty = true
                                        : isUsernameEmpty = false;
                                  });
                                },
                                decoration: InputDecoration(
                                    errorText: isUsernameEmpty
                                        ? 'Value Can\'t Be Empty'
                                        : null,
                                    prefixIcon: Icon(
                                      Icons.account_circle,
                                      color: Color(0xff262e57),
                                      size: 28,
                                    ),
                                    hintText: 'Username',
                                    hintStyle: TextStyle(
                                        fontFamily: "gothic", fontSize: 20),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none
                                    /*border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25)),*/
                                    ),
                              ),
                            ),
                            SizedBox(height: 35),
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
                                controller: email,
                                onChanged: (value) {
                                  setState(() {
                                    email.text.isEmpty
                                        ? isEmailEmpty = true
                                        : isEmailEmpty = false;
                                  });
                                },
                                decoration: InputDecoration(
                                    errorText: isEmailEmpty
                                        ? 'Value Can\'t Be Empty'
                                        : null,
                                    prefixIcon: Icon(
                                      Icons.email_outlined,
                                      color: Color(0xff262e57),
                                      size: 28,
                                    ),
                                    hintText: 'Email',
                                    hintStyle: TextStyle(
                                        fontFamily: "gothic", fontSize: 20),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none
                                    /*border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25)),*/
                                    ),
                              ),
                            ),
                            SizedBox(height: 35),
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
                                controller: password,
                                onChanged: (value) {},
                                obscureText: true,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Color(0xff262e57),
                                      size: 28,
                                    ),
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                        fontFamily: "gothic", fontSize: 20),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none
                                    /*border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25)),*/
                                    ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FlutterPwValidator(
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
                            SizedBox(height: 19),
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
                                controller: confirm_password,
                                obscureText: true,
                                onChanged: (value) {
                                  setState(() {
                                    if (password.text ==
                                        confirm_password.text) {
                                      isMatched = true;
                                    } else {
                                      isMatched = false;
                                    }
                                  });
                                },
                                decoration: InputDecoration(
                                    errorText: isMatched
                                        ? null
                                        : '    Password Not matched',
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Color(0xff262e57),
                                      size: 28,
                                    ),
                                    hintText: 'Confirm Password',
                                    hintStyle: TextStyle(
                                        fontFamily: "gothic", fontSize: 20),
                                    enabledBorder: InputBorder.none,
                                    focusedBorder: InputBorder.none
                                    /*border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25)),*/
                                    ),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
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
                                  if (!EmailValidator.validate(email.text)) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        new SnackBar(
                                            backgroundColor: Color(0xff262e57),
                                            content:
                                                new Text("Email not Valid")));
                                    return;
                                  }
                                  if (username.text.isEmpty ||
                                      email.text.isEmpty ||
                                      password.text.isEmpty ||
                                      confirm_password.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        new SnackBar(
                                            backgroundColor: Color(0xff262e57),
                                            content: new Text(
                                                "Please fill all data")));
                                    return;
                                  }
                                  if (isPasswordValid && !isMatched) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            backgroundColor: Color(0xff262e57),
                                            content: Text(
                                                "Please check password and confirm it")));
                                    return;
                                  }

                                  User activeUser = new User();
                                  activeUser.setUsername = username.text;
                                  activeUser.setEmail = email.text;
                                  activeUser.setPassword = password.text;
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            WeightHeightRegister(activeUser)),
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
                                      width: 5,
                                    ),
                                    Icon(Icons.arrow_forward_ios_rounded)
                                  ],
                                )),
                          ],
                        ),
                      )),
                    ],
                  ),
                )),
          );
        }));
  }
}
