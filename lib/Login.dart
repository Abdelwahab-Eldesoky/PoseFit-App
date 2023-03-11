import 'package:flutter/material.dart';
import 'Home.dart';

class Login extends StatelessWidget {
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
            margin: EdgeInsets.only(top: 90,left: 10,right: 10),
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
                SizedBox(height: 70,),
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
                                decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.account_circle,
                                        color: Color(0xff262e57), size: 28),
                                    hintText: 'Username',
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
                                controller: password,
                                obscureText: true,
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Color(0xff262e57),
                                      size: 28,
                                    ),
                                    //labelText: 'Password',
                                    hintText: 'Password',
                                    hintStyle: TextStyle(fontFamily: "gothic", fontSize: 20),
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
                                    backgroundColor:
                                    MaterialStateProperty.all(Color(0xff262e57)),
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                    ))),
                                onPressed: () {
                                  ///////trrrrrrrrryyyyyyyyy

                                  //email.text
                                  //password.text

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => HomePage()),
                                  );
                                },
                                child: Text(
                                  "Log In",
                                  style: TextStyle(fontSize: 25,fontFamily: "gothic"),
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
                                  style: TextStyle(color: Color(0xff262e57), fontFamily: "gothic",fontSize: 22)),
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
                                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(32.0),
                                      side: const BorderSide(
                                          width: 1.5, color: Colors.indigo),
                                    ))),
                                onPressed: () {
                                  var text_email = email.toString();
                                  var text_password = password.toString();
                                  print(text_email);
                                  print(text_password);
                                },
                                child: Text(
                                  "Sign In",
                                  style: TextStyle(fontSize: 25, color: Color(0xff262e57)),
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
