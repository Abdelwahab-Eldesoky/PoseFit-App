import 'package:flutter/material.dart';
import 'package:pose_fit/classes/ApiManager.dart';

import 'Home.dart';
import 'Register Pages/PersonalInfoRegister.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isEmailEmpty = false;
  bool isPasswordEmpty = false;

  @override
  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              "assets/login_back-01.jpg",
            ),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
            padding: const EdgeInsets.all(30),
            margin: EdgeInsets.only(top: 90, left: 10, right: 10),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Welcome',
                    style: TextStyle(
                      color: Color(0xff262e57),
                      fontSize: 52.5,
                      fontFamily: "power",
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'Back',
                    style: TextStyle(
                      color: Color(0xff262e57),
                      fontSize: 52.5,
                      fontFamily: "power",
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Expanded(
                  child: SizedBox(
                    height: 100,
                    child: ListView(
                      children: [
                        Column(
                          //margin:EdgeInsets.all(20),
                          mainAxisAlignment: MainAxisAlignment.center,
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
                                        ? '    Email Can\'t Be Empty'
                                        : null,
                                    prefixIcon: Icon(Icons.mail,
                                        color: Color(0xff262e57), size: 28),
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
                            SizedBox(height: 50),
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
                                obscureText: true,
                                onChanged: (value) {
                                  setState(() {
                                    password.text.isEmpty
                                        ? isPasswordEmpty = true
                                        : isPasswordEmpty = false;
                                  });
                                },
                                decoration: InputDecoration(
                                    errorText: isPasswordEmpty
                                        ? '   Password Can\'t Be Empty'
                                        : null,
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Color(0xff262e57),
                                      size: 28,
                                    ),
                                    //labelText: 'Password',
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
                            SizedBox(height: 50),
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
                                onPressed: () async {
                                  if (email.text.isEmpty ||
                                      password.text.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        new SnackBar(
                                            content: new Text(
                                                "Please fill all data")));
                                    return;
                                  }

                                  if (await ApiManager.validateUser(
                                      email.text, password.text)) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              HomePage(email.text)),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        new SnackBar(
                                          backgroundColor: Color(0xff262e57),
                                            content: new Text(
                                                "Please fill right daat or Sign up")));
                                  }
                                  ApiManager.getPersonName(email.text);
                                },
                                child: Text(
                                  "Log In",
                                  style: TextStyle(
                                      fontSize: 25, fontFamily: "gothic"),
                                )),
                            SizedBox(height: 25),
                            Row(children: <Widget>[
                              Expanded(
                                  child: Divider(
                                thickness: 1,
                                color: Color(0xff262e57),
                                indent: 10,
                                endIndent: 10,
                              )),
                              Text("OR",
                                  style: TextStyle(
                                      color: Color(0xff262e57),
                                      fontFamily: "gothic",
                                      fontSize: 22)),
                              Expanded(
                                  child: Divider(
                                thickness: 1,
                                color: Color(0xff262e57),
                                indent: 10,
                                endIndent: 10,
                              )),
                            ]),
                            SizedBox(height: 25),
                            ElevatedButton(
                                style: ButtonStyle(
                                    fixedSize: MaterialStateProperty.all(Size(
                                      220,
                                      60,
                                    )),
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                      side: const BorderSide(
                                          width: 1.5, color: Colors.indigo),
                                    ))),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PersonalInfoRegister()),
                                  );
                                },
                                child: Text(
                                  "Sign up",
                                  style: TextStyle(
                                      fontSize: 25, color: Color(0xff262e57)),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
