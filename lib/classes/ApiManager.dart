import 'dart:convert';

import 'package:http/http.dart' as http;

import 'Workout.dart';

class ApiManager {

  static Future<List<Workout>> getPlan() async {
    print("hahahah");
    final response = await http.post(
        Uri.parse('http://192.168.0.103:3000/api/user/plan'),
            headers: {"Content-Type": "application/json"},
            body: json.encode({'email': "mai@gmail.com"}));
        final data = jsonDecode(response.body);
    print("hahahah222222");
    List<Workout> workoutList = [];
    var extractWorkout;
    for (var details in data) {
      extractWorkout = details["plan"]["workouts"];
    }
    print("hahahah3333333333");
    for (var workout in extractWorkout) {
      Workout work = new Workout(workout["rep"], workout["sets"],
          workout["workout"]['workoutName'], workout["workout"]['gif']);
      workoutList.add(work);
    }

    workoutList.forEach((element) {print(element.name);});
    print("Slam");
    return workoutList;

}

  static Future<List<Workout>> workoutSearch(String keyword) async {
    print(keyword);
    print("Welcomeeee");
    final response = await http.post(
        Uri.parse('http://192.168.0.103:3000/api/workout/search'),
            headers: {"Content-Type": "application/json"},
            body: json.encode({'name': keyword}));
        final data = jsonDecode(response.body);
    List<Workout> workoutList = [];
    for (var workout in data) {
      Workout work =
      new Workout.fromWorkout(workout['workoutName'], workout['gif']);
      workoutList.add(work);
    }
    workoutList.forEach((element) {print(element.name);});
    return workoutList;
  }
  static Future<List<Workout>> fetchAllWorkouts() async {

    print("Welcomeeee");
    final response = await http.get(Uri.parse('http://192.168.1.7:3000/api/workout/allWorkouts'));
    final data = jsonDecode(response.body);
    List<Workout> workoutList = [];
    for (var workout in data) {
      Workout work =
      new Workout.fromWorkout(workout['workoutName'], workout['gif']);
      workoutList.add(work);
    }
    workoutList.forEach((element) {print(element.name);});
    return workoutList;
  }

  static Future<bool> validateUser(String email,String password) async {
      print("helloooooo");
    final response = await http.post(
        Uri.parse('http://192.168.1.7:3000/api/user/login'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'email': email , 'password':password}));
      print("response   "+response.body.toString());

        if(response.body.toString()=="Invalid email or password"){
          print("false ahee");
          return false;
        }
    return true;

  }

}
