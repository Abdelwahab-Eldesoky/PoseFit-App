import 'package:flutter/material.dart';
import 'package:pose_fit/SettingWorkoutDetails.dart';
import 'package:pose_fit/UpdateProfile.dart';
import 'package:pose_fit/WorkoutHistory.dart';
import 'package:pose_fit/classes/ApiManager.dart';
import 'package:camera/camera.dart';

import 'Home.dart';
import 'classes/Workout.dart';

class SearchWorkout extends StatefulWidget {
  final String email;

  SearchWorkout(this.email);

  @override
  State<SearchWorkout> createState() => _SearchWorkoutState();
}

class _SearchWorkoutState extends State<SearchWorkout> {

  final searchController = TextEditingController();
  List<Workout> searchResults = [];
  List<CameraDescription> cameras=[];
  bool isLoaded=false;

  Future<void> findData(String keyword) async {
    setState(() {
      isLoaded=false;
    });
    List<Workout> tmp = [];
    searchResults.clear();
    if (keyword == "") {
      tmp = await ApiManager.fetchAllWorkouts().whenComplete((){
        isLoaded=true;
      });
    } else {
      tmp = await ApiManager.workoutSearch(keyword).whenComplete((){
        isLoaded=true;
      });
    }
    tmp.forEach((element) {
      searchResults.add(element);
      print(element.name);
    });

    setState(() {});
  }

  Future<void> setCameras()async{

    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();

  }

  @override
  void initState() {
    super.initState();
    findData("");

    setCameras();
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
                  image: AssetImage("assets/search_back-01.jpg"),
                  fit: BoxFit.cover)),
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        WorkoutHistory(widget.email)
                                ));
                          },
                          iconSize: 34,
                          icon: Icon(
                            color: Colors.white,
                            Icons.history_rounded,
                          )),
                      SizedBox(
                        width: 70,
                      ),
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
                      SizedBox(
                        width: 70,
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateProfile(widget.email)
                                ));
                          },
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
                      onChanged: (value) => {findData(value)},
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
                                onPressed: () {
                                  searchController.clear();
                                  findData("");
                                },
                              ),
                      ),
                    )),
                isLoaded?Expanded(
                  child: SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemBuilder: (ctx, index) {
                        return GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingWorkoutDetails(widget.email, searchResults[index])),
                            );
                          },
                          child: Container(
                            height: 350,
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
                                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    child: Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 18, right: 25),
                                        child: Text(
                                          searchResults[index].name,
                                          style: TextStyle(
                                              fontFamily: "gothic", fontSize: 31),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: searchResults.length,
                    ),
                  ),
                ):Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 100),
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: CircularProgressIndicator(
                        strokeWidth: 6,
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xfff7a007)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
