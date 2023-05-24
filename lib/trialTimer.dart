import 'package:flutter/material.dart';


void main() {
  runApp(trialTimer());
}


class trialTimer extends StatefulWidget {
  const trialTimer({Key? key}) : super(key: key);

  @override
  State<trialTimer> createState() => _trialTimerState();
}

class _trialTimerState extends State<trialTimer> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(child: SizedBox(
          height: 200,
          width: 200,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                value: 59/60,
                strokeWidth: 8,
                color: Color(0xfff7a007),
              )
              ,Center(child: Text("20",style: TextStyle(fontFamily: "gothic",fontSize: 80,color: Color(0xff262e57)),textAlign: TextAlign.center,))
            ],
          ),
        )),
      ),
    );
  }
}
