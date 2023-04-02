import 'package:flutter/material.dart';
import 'WeightHeightRegister.dart';
import '../classes/User.dart';


class PersonalInfoRegister extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirm_password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Register 1",
        home: Builder(
          builder: (context) {
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
                                  style:
                                      TextStyle(fontFamily: "gothic", fontSize: 21),
                                  controller: username,
                                  decoration: InputDecoration(
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
                                  style:
                                      TextStyle(fontFamily: "gothic", fontSize: 21),
                                  controller: email,
                                  decoration: InputDecoration(
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
                                  style:
                                      TextStyle(fontFamily: "gothic", fontSize: 21),
                                  controller: password,
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
                                  style:
                                      TextStyle(fontFamily: "gothic", fontSize: 21),
                                  controller: confirm_password,
                                  obscureText: true,
                                  decoration: InputDecoration(
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
                                    User activeUser=new User();
                                    activeUser.setUsername=username.text;
                                    activeUser.setEmail=email.text;
                                    activeUser.setPassword=password.text;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => WeightHeightRegister(activeUser)),
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
          }
        ));
  }
}
