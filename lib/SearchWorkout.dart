import 'package:flutter/material.dart';
import 'classes/Workout.dart';
import 'Home.dart';

class SearchWorkout extends StatefulWidget {
  const SearchWorkout({Key? key}) : super(key: key);

  @override
  State<SearchWorkout> createState() => _SearchWorkoutState();
}

class _SearchWorkoutState extends State<SearchWorkout> {
  final searchController = TextEditingController();
  List<Workout> searchResults = [
    Workout(15, 3, "Bicep Curls", "assets/bicep_curls.gif"),
    Workout(20, 4, "Jumping Jacks", "assets/jumping_jacks.gif"),
    Workout(10, 5, "Lateral Raise", "assets/lateral_raise.gif"),
    Workout(15, 3, "Mountain Climpers", "assets/mountain_climbers.gif")
  ];

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Search Page",
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/search_back-01.jpg"),fit: BoxFit.cover )),
          child: Scaffold(
            backgroundColor: Colors.transparent,
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
                          onPressed: () {},
                          iconSize: 34,
                          icon: Icon(
                            color: Colors.white,
                            Icons.stacked_line_chart,
                          )),
                      SizedBox(
                        width: 70,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);
                          },
                          iconSize: 34,
                          icon: Icon(
                            color: Colors.white,
                            Icons.home_rounded,
                          )),
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
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(left: 30, right: 30, top: 45),
                    child: TextField(
                      controller: searchController,
                      autofocus: false,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xff262e57), width: 1.5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(45))),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xfff7a007), width: 2),
                            borderRadius:
                                BorderRadius.all(Radius.circular(45))),
                        hintText: "Search",
                        hintStyle: TextStyle(
                            fontFamily: "gothic",
                            fontSize: 20,
                            color: Colors.grey),
                        prefixIcon: Icon(
                          Icons.search,
                          size: 30,
                          color: Color(0xff262e57),
                        ),
                        suffixIcon: searchController.text.isEmpty
                            ? Container(width: 0)
                            : IconButton(
                                icon: Icon(
                                  Icons.close_rounded,
                                  color: Color(0xff262e57),
                                  size: 35,
                                ),
                                onPressed: () => searchController.clear(),
                              ),
                      ),
                    )),
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (ctx, index) {
                        return Container(
                          height: 400,
                          margin: EdgeInsets.fromLTRB(5, 5, 5, 25),
                          child: Card(
                            elevation: 15,
                            color: Colors.white70,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Column(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      topRight: Radius.circular(30)),
                                  child:
                                      Image.asset(searchResults[index].gifPath),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 13, 0, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 18, right: 25),
                                          child: Text(
                                            searchResults[index].name,
                                            style: TextStyle(
                                                fontFamily: "gothic",
                                                fontSize: 31),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 70, right: 5),
                                        child: Text(
                                            searchResults[index]
                                                    .sets
                                                    .toString() +
                                                " X " +
                                                searchResults[index]
                                                    .reps
                                                    .toString(),
                                            style: TextStyle(
                                                fontFamily: "gothic",
                                                fontSize: 32,
                                                fontWeight: FontWeight.bold)),
                                      ))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: searchResults.length,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
