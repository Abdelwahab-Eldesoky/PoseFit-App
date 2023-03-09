import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'todayPlan.dart';
import 'SearchWorkout.dart';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  List<ProgressData> _chartData = [
    ProgressData("15.02", 30),
    ProgressData("16.02", 45),
    ProgressData("17.02", 50),
    ProgressData("18.02", 20),
    ProgressData("19.02", 70),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Home",
        home: Builder(
          builder: (context) {
            return Scaffold(
              bottomNavigationBar: SafeArea(
                child: Container(
                  height: 63,
                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.only(right: 10,left: 10,bottom: 10),
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
                        Column(
                          children: [
                            IconButton(
                                onPressed: () {},
                                iconSize: 34,
                                icon: Icon(
                                  color: Colors.white,
                                  Icons.home_rounded,
                                )),
                            Container(width:30 ,height: 3,
                            decoration: BoxDecoration(color: Color(0xfff7a007),borderRadius: BorderRadius.all(Radius.circular(4))),)
                          ],
                        ),
                        SizedBox(
                          width: 70,
                        ),
                        IconButton(
                            onPressed: () {},
                            iconSize: 34,
                            icon: Icon(
                              color: Colors.white,
                              Icons.account_circle_outlined,
                            ))
                      ]),
                ),
              ),
              body: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Color(0xff262e57),
                        borderRadius: BorderRadius.all(Radius.circular(150))),
                    height: 100,
                    alignment: Alignment.center,
                    child: Text(
                      "Hi, Mohamed",
                      style: TextStyle(
                          color: Color(0xfff7a007),
                          fontFamily: "gothic",
                          fontSize: 27),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: 185,
                    margin: EdgeInsets.fromLTRB(2, 10, 2, 0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        Card(
                          margin: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 5,
                          child: Container(
                            height: 140,
                            width: 300,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                        Color.fromRGBO(38, 46, 87, 0.8),
                                        BlendMode.darken),
                                    image: AssetImage("assets/dailyback-01.png"),
                                    fit: BoxFit.cover)),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(20),
                              title: Text(
                                'Daily\nChallenge',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontFamily: "gothic",
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Card(
                          margin: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 5,
                          child: Container(
                            height: 140,
                            width: 300,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                        Color.fromRGBO(38, 46, 87, 0.8),
                                        BlendMode.darken),
                                    image: AssetImage("assets/bar_chart-01.png"),
                                    fit: BoxFit.cover)),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(20),
                              title: Text(
                                'Ranking\nBoard',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontFamily: "gothic",
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Text(
                      "Training",
                      style: TextStyle(
                          fontSize: 27,
                          fontFamily: "gothic",
                          fontWeight: FontWeight.bold,
                          color: Color(0xff262e57)),
                    ),
                  ),
                  Container(
                    height: 225,
                    margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  TodayPlan()),);
                          },
                          child: Card(
                            margin: const EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 5,
                            child: Container(
                              alignment: Alignment.topLeft,
                              height: 225,
                              width: 160,
                              decoration:
                                  const BoxDecoration(color: Color(0xff262e57)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                                    child: Image(
                                        image:
                                            AssetImage("assets/dumbel_icon-01.png"),
                                        width: 48,
                                        height: 48),
                                  ),
                                  SizedBox(
                                    height: 32,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    child: Text(
                                      "Continue\non your\nplan",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: "gothic",
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Card(
                          margin: const EdgeInsets.all(5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 5,
                          child: Container(
                            alignment: Alignment.topLeft,
                            height: 225,
                            width: 160,
                            decoration:
                                const BoxDecoration(color: Color(0xffab2b3e)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                                  child: Image(
                                      image:
                                          AssetImage("assets/selection_icon.png"),
                                      width: 48,
                                      height: 48),
                                ),
                                SizedBox(
                                  height: 32,
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                  child: Text(
                                    "Choose\nanother\nplan",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: "gothic",
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) =>  SearchWorkout()),);
                          },
                          child: Card(
                            margin: const EdgeInsets.all(5),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            elevation: 5,
                            child: Container(
                              alignment: Alignment.topLeft,
                              height: 225,
                              width: 160,
                              decoration:
                                  const BoxDecoration(color: Color(0xfff7a007)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                                    child: Image(
                                        image: AssetImage("assets/search_icon.png"),
                                        width: 48,
                                        height: 48),
                                  ),
                                  SizedBox(
                                    height: 32,
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                                    child: Text(
                                      "Search\nfor specific\nworkout",
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: "gothic",
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Text(
                      "Activity",
                      style: TextStyle(
                          fontSize: 27,
                          fontFamily: "gothic",
                          fontWeight: FontWeight.bold,
                          color: Color(0xff262e57)),
                    ),
                  ),
                  Container(
                    height: 260,
                    child: SfCartesianChart(
                      title: ChartTitle(text: "your activity by minutes everyday"),
                      series: <ChartSeries>[
                        LineSeries<ProgressData, double>(
                            name: 'Activity',
                            dataSource: _chartData,
                            xValueMapper: (ProgressData progress, _) =>
                                double.parse(progress.date),
                            yValueMapper: (ProgressData progress, _) =>
                                progress.minutes,
                            dataLabelSettings: DataLabelSettings(isVisible: true),
                            enableTooltip: true)
                      ],
                    ),
                  )
                ],
              ),
            );
          }
        ));
  }

/*List<ProgressData> getChartData(){
    final List<ProgressData> chartData=[
      ProgressData("15/2", 30),
      ProgressData("16/2", 45),
      ProgressData("17/2", 50),
      ProgressData("18/2", 20),
      ProgressData("19/2", 70),
    ];
        return chartData;
  }*/
}

class ProgressData {
  ProgressData(this.date, this.minutes);

  final String date;
  final double minutes;
}
