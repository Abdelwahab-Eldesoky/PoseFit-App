import 'dart:convert';

import 'package:http/http.dart' as http;

import 'User.dart';
import 'Workout.dart';

class ApiManager {
  // Hoba ethernet 192.168.1.97

 static final String ip="192.168.1.97";

  static Future<List<Workout>> getPlan(String email) async {
    print("hahahah");
    final response = await http.post(
        Uri.parse('http://${ip}:3000/api/user/plan'),
            headers: {"Content-Type": "application/json"},
            body: json.encode({'email': email}));
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
        Uri.parse('http://${ip}:3000/api/workout/search'),
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
    final response = await http.get(Uri.parse('http://${ip}:3000/api/workout/allWorkouts'));
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
 static Future<bool> signup(User user) async {
   print("helloooooo");
   final response = await http.post(
       Uri.parse('http://${ip}:3000/api/auth/signup'),
       headers: {"Content-Type": "application/json"},
       body: json.encode({"email":user.getEmail,
         "password":user.getPassword,
         "name":user.getUsername,
         "age":user.getAge,
         "gender":user.getGender,
         "height":user.getHeight,
         "weight":user.getWeight,
         "plan":"640872f1382967cbd39f6db6",
         "activityLevel":user.getActivityLevel}));
   print("response   "+response.body.toString());
   if(response.body.toString()=="Invalid email or password"){
     print("false ahee");
     return false;
   }
   return true;

 }

  static Future<bool> validateUser(String email,String password) async {
      print("helloooooo");
    final response = await http.post(
        Uri.parse('http://${ip}:3000/api/auth/login'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'email': email , 'password':password}));
      print("response   "+response.body.toString());
      final data = jsonDecode(response.body);
        if(data["errors"]=="Invalid email or password"){
          print("false ahee");
          return false;
        }
    return true;
  }

  static Future<String> getPersonName(String email) async {
    final response = await http.post(
        Uri.parse('http://${ip}:3000/api/user/getName'),
            headers: {"Content-Type": "application/json"},
            body: json.encode({'email': email}));
        print("respond "+response.body.toString());
    final data = jsonDecode(response.body);
    String name=data[0]['name'];

    print(name);

    return name;
  }
}
