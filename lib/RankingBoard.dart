import 'package:flutter/material.dart';
import 'package:pose_fit/classes/ApiManager.dart';

import 'Home.dart';
import 'UpdateProfile.dart';
import 'WorkoutHistory.dart';
import 'classes/Rank.dart';

void main() {
  runApp(RankingBoard("Hoba2001@gmail.com"));
}

// ignore: must_be_immutable
class RankingBoard extends StatefulWidget {
  String email;

  RankingBoard(this.email);

  @override
  State<RankingBoard> createState() => _RankingBoardState();
}

class _RankingBoardState extends State<RankingBoard> {

  List<Rank> allRankings=[];
  bool isLoaded=false;

  void getAllRankings() async {

    List<Rank> tmp=await ApiManager.fetchAllRanks().whenComplete((){
      isLoaded=true;
    });

    tmp.forEach((element) {
      allRankings.add(element);
    });

    setState(() {

    });

  }

  @override
  void initState() {
    super.initState();
    getAllRankings();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/ranking-board-01.jpg"),
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    WorkoutHistory(widget.email)),
                          );
                        },
                        iconSize: 34,
                        icon: Icon(
                          color: Colors.white,
                          Icons.history_rounded,
                        )),
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
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UpdateProfile(widget.email)),
                          );
                        },
                        iconSize: 34,
                        icon: Icon(
                          color: Colors.white,
                          Icons.account_circle_outlined,
                        ))
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
                    Text("Ranking",
                        style: TextStyle(
                            fontSize: 40,
                            color: Color(0xff262e57),
                            fontFamily: "power")),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Board",
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
          body: isLoaded?ListView.builder(
              itemCount: allRankings.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (ctx, index) {
                return Container(
                  height: 125,
                  margin: EdgeInsets.fromLTRB(5, 5, 5, 25),
                  child: Card(
                      elevation: 15,
                      color: Colors.white70,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //SizedBox(height: double.infinity),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  child: Icon(
                                    Icons.account_circle,
                                    size: 60,
                                    color: Color(0xff262e57),
                                  ),
                                  backgroundColor: Colors.transparent,
                                ),
                                Wrap(
                                  children: [
                                    Container(
                                        height: 26,
                                        width: 26,
                                        alignment: Alignment.topLeft,
                                        decoration: BoxDecoration(
                                            color: Color(0xfff7a007),
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(13)),
                                        child: Center(
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            (index + 1).toString(),
                                            style: TextStyle(
                                                fontFamily: "gothic",
                                                fontSize: 22),
                                          ),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          ),
                          VerticalDivider(
                            width: 20,
                            thickness: 2,
                            color: Colors.grey,
                            indent: 14,
                            endIndent: 14,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                allRankings[index].userName,
                                style: TextStyle(
                                    color: Color(0xffc32b42),
                                    fontFamily: "gothic",
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Counts: " + allRankings[index].reps.toString(),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: "gothic",
                                        color: Color(0xff262e57)),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "Duration: " +
                                        ((allRankings[index].duration / 60).toInt() < 10
                                            ? "0" +
                                                (allRankings[index].duration / 60)
                                                    .toInt()
                                                    .toString()
                                            : (allRankings[index].duration / 60)
                                                .toInt()
                                                .toString()) +
                                        " : " +
                                        ((allRankings[index].duration % 60).toInt() < 10
                                            ? "0" +
                                                (allRankings[index].duration % 60)
                                                    .toInt()
                                                    .toString()
                                            : (allRankings[index].duration % 60)
                                                .toInt()
                                                .toString()),
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: "gothic",
                                        color: Color(0xff262e57)),
                                  ),
                                ],
                              ),
                              Container(
                                width: 220,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  child :
                                  LinearProgressIndicator(
                                    value: allRankings[index].progress,
                                    backgroundColor: Colors.grey,
                                    minHeight: 15,
                                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xff262e57)),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )),
                );
              }):Center(
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
