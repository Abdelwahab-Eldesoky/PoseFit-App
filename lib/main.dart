import 'package:flutter/material.dart';

/*void main() {
  runApp(const MyApp());
}*/

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/backLauncher-01.jpg"),
                  fit: BoxFit.cover)),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/logo-01.png',
                      width: 280,
                      height: 280,
                    ),
                    SizedBox(
                      height: 110,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Let",
                                style: TextStyle(
                                    fontFamily: "power",
                                    fontSize: 25,
                                    color: Color(0xfff7a007))),
                            Text(
                              "'",
                              style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xfff7a007)),
                            ),
                            Text("S",
                                style: TextStyle(
                                    fontFamily: "power",
                                    fontSize: 25,
                                    color: Color(0xfff7a007))),
                            SizedBox(
                              width: 5,
                            ),
                            Text("Start",
                                style: TextStyle(
                                    fontFamily: "power",
                                    fontSize: 25,
                                    color: Color(0xfff7a007))),
                          ]),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff262e57).withOpacity(0.85),
                          fixedSize: Size(180, 90),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(55),
                                  bottomRight: Radius.circular(55)))),
                    ),
                    SizedBox(
                      height: 70,
                    )
                  ],
                ),
              )),
        ));
  }
}
