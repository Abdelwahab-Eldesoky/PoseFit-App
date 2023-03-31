import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(const SettingWorkoutDetails());
}

class SettingWorkoutDetails extends StatefulWidget {
  const SettingWorkoutDetails({Key? key}) : super(key: key);

  @override
  State<SettingWorkoutDetails> createState() => _SettingWorkoutDetailsState();
}

class _SettingWorkoutDetailsState extends State<SettingWorkoutDetails> {
  int sets = 3;
  int reps = 5;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Set reps",
        home: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              padding: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                  color: Color(0xff262e57),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(150),
                      bottomLeft: Radius.circular(150))),
              height: 80,
              alignment: Alignment.center,
              child: Text(
                "Set your workout details",
                style: TextStyle(
                    color: Color(0xffffffff),
                    fontFamily: "gothic",
                    fontSize: 24,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ),
          bottomNavigationBar: SafeArea(
            child: Container(
              height: 63,
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xff262e57),
                      blurStyle: BlurStyle.outer,
                      spreadRadius: 0.1,
                      blurRadius: 3,
                    )
                  ],
                  color: const Color(0xff262e57).withOpacity(0.95),
                  borderRadius: const BorderRadius.all(Radius.circular(35))),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                        onPressed: () {},
                        iconSize: 34,
                        icon: const Icon(
                          color: Colors.white,
                          Icons.stacked_line_chart,
                        )),
                    const SizedBox(
                      width: 70,
                    ),
                    IconButton(
                        onPressed: () {
                          /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(widget.email)),
                        );*/
                        },
                        iconSize: 34,
                        icon: const Icon(
                          color: Colors.white,
                          Icons.home_rounded,
                        )),
                    const SizedBox(
                      width: 70,
                    ),
                    IconButton(
                        onPressed: () {},
                        iconSize: 34,
                        icon: const Icon(
                          color: Colors.white,
                          Icons.account_circle_outlined,
                        ))
                  ]),
            ),
          ),
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              Text("Sets", style: TextStyle(
                fontSize: 30,
                color: Color(0xff262e57),
                fontFamily: "gothic"),),
            SizedBox(
              width: 5,
            ),
            NumberPicker(
                minValue: 1,
                maxValue: 10,
                value: sets,
                itemCount: 5,
                haptics: true,
                textStyle: TextStyle(
                    fontSize: 20,
                    color: Color(0xff262e57),
                    fontFamily: "gothic"),
                selectedTextStyle: TextStyle(
                    fontSize: 40,
                    color: Color(0xfff7a007),
                    fontFamily: "gothic"),
                onChanged: (value) {
                  sets = value;
                  setState(() {

                  });
                }),
            SizedBox(width: 5,),
            Text("X", style: TextStyle(
                fontSize: 35,
                color: Color(0xff262e57),
                fontFamily: "gothic"),),
            SizedBox(width: 5,),

        NumberPicker(
            minValue: 1,
            maxValue: 20,
            value: reps,
            itemCount: 5,
            haptics: true,
            textStyle: TextStyle(
                fontSize: 20,
                color: Color(0xff262e57),
                fontFamily: "gothic"),
            selectedTextStyle: TextStyle(
                fontSize: 40,
                color: Color(0xfff7a007),
                fontFamily: "gothic"),
            onChanged: (value) {
              reps = value;
              setState(() {

              });
            }),
                SizedBox(
                  width: 5,
                ),
                Text("Reps", style: TextStyle(
                    fontSize: 30,
                    color: Color(0xff262e57),
                    fontFamily: "gothic"),),
        ]),)
    ,
    )
    ,
    );
  }
}
