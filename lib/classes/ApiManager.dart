import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pose_fit/classes/DailyChallenge.dart';
import 'WorkoutHistoryEntry.dart';
import 'Rank.dart';
import 'User.dart';
import 'Workout.dart';

class ApiManager {
  // Hoba ethernet 192.168.1.97
//https://posefit.onrender.com
//http://192.168.1.97:3000

 static final String domain="http://192.168.0.107:3000";
  static Future<List<Workout>> getPlan(String email) async {
    final response = await http.post(
        Uri.parse('${domain}/api/user/plan'),
            headers: {"Content-Type": "application/json"},
            body: json.encode({'email': email}));
        final data = jsonDecode(response.body);
    List<Workout> workoutList = [];
    var extractWorkout;
    for (var details in data) {
      extractWorkout = details["plan"]["workouts"];
    }
    print("hahahah3333333333"+data.toString());
    for (var workout in extractWorkout) {
      print(workout["workout"]['duration']);
      Workout work = new Workout(workout["rep"], workout["sets"],
          workout["workout"]['workoutName'], workout["workout"]['gif'],workout["workout"]['_id'],workout['status'],workout["workout"]['duration']);
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
        Uri.parse('${domain}/api/workout/search'),
            headers: {"Content-Type": "application/json"},
            body: json.encode({'name': keyword}));
        final data = jsonDecode(response.body);
        print(data.toString());
    List<Workout> workoutList = [];
    for (var workout in data) {
      Workout work =
      new Workout.fromWorkout(workout['workoutName'], workout['gif'],workout['_id'],workout["duration"]);
      workoutList.add(work);
    }
    workoutList.forEach((element) {print(element.name);});
    return workoutList;
  }
  static Future<List<Workout>> fetchAllWorkouts() async {
    print("Welcomeeee");
    final response = await http.get(Uri.parse('${domain}/api/workout/allWorkouts'));
    final data = jsonDecode(response.body);
    List<Workout> workoutList = [];
    for (var workout in data) {
      Workout work =
      new Workout.fromWorkout(workout['workoutName'], workout['gif'],workout['_id'],workout["duration"]);
      workoutList.add(work);
    }
    workoutList.forEach((element) {print(element.name);});
    return workoutList;
  }
 static Future<bool> signup(User user) async {
   print("helloooooo");
   final response = await http.post(
       Uri.parse('${domain}/api/auth/signup'),
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
        Uri.parse('${domain}/api/auth/login'),
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
 static Future<User> getUserInfo(String email) async {
   final response = await http.post(
       Uri.parse('${domain}/api/user/getInfo'),
       headers: {"Content-Type": "application/json"},
       body: json.encode({'email': email}));
   print("respond "+response.body.toString());
   final data = jsonDecode(response.body);
   String name=data[0]['name'];

   User user=new User(data[0]['name'],data[0]['email'],data[0]['password'],data[0]['gender'],data[0]['activityLevel'],data[0]['plan'],data[0]['weight'].toDouble(),data[0]['height'].toDouble(),data[0]['age']);

   print(user.email);

   return user;
 }
  static Future<String> getPersonName(String email) async {
    final response = await http.post(
        Uri.parse('${domain}/api/user/getName'),
            headers: {"Content-Type": "application/json"},
            body: json.encode({'email': email}));
        print("respond "+response.body.toString());
    final data = jsonDecode(response.body);
    String name=data[0]['name'];

    print(name);

    return name;
  }

 static Future<List<WorkoutHistoryEntry>> getHistory(String email) async {
   final response = await http.post(
       Uri.parse('${domain}/api/user/getHistory'),
       headers: {"Content-Type": "application/json"},
       body: json.encode({'email': email}));
   print("respond "+response.body.toString());
   final data = jsonDecode(response.body);

   var historyHolder=data[0]['history'];

   List<WorkoutHistoryEntry> historyList = [];
   for (var historyEntry in historyHolder.reversed) {
     WorkoutHistoryEntry work =
     new WorkoutHistoryEntry(historyEntry['workoutName'], historyEntry['date'],historyEntry['reps'],historyEntry['duration'],historyEntry['performance']);
     historyList.add(work);
   }

   historyList.forEach((element) {print(element.date);});

   return historyList;
 }
 static Future<DailyChallenge> getChallenge() async {
    print("ya 3m msh hn2olk");
   final response = await http.get(Uri.parse('${domain}/api/challenge/dailyChallenge'));
   final data = jsonDecode(response.body);
   print("test challenge "+data.toString());
   Workout workout=new Workout.fromWorkout(data[0]['workout']['workoutName'], data[0]['workout']['gif'], data[0]['workout']['_id'],data[0]['workout']["duration"]);
   print(workout.name);
   DailyChallenge challenge=new DailyChallenge(workout, data[0]['Description'], data[0]['reps'], data[0]['targetMuscele']);
  print(challenge.description);
 return challenge;
 }

 static Future<void> addToHistory(String email,WorkoutHistoryEntry h) async {
   final response = await http.put(Uri.parse('${domain}/api/user/addhistory'),
       headers: {"Content-Type": "application/json"},
       body: json.encode({'email': email , 'record': {'workoutName':h.workoutName , 'reps':h.reps , 'date':h.date,'duration':h.duration,'performance':h.performance}}));

    print(response.body.toString());
  }
 static Future<void> addRank(String email,Rank r) async {
   final response = await http.post(Uri.parse('${domain}/api/user/addRank'),
       headers: {"Content-Type": "application/json"},
       body: json.encode({'email': email , 'reps':r.reps , 'duration':r.duration , 'progress':r.progress}));

   print(response.body.toString());
 }
 static Future<List<Rank>> fetchAllRanks() async {
   print("Welcomeeee");
   final response = await http.get(Uri.parse('${domain}/api/user/getRank'));
   final data = jsonDecode(response.body);
   print(data.toString());
   List<Rank> rankList = [];
   for (var r in data)
   {
     print(r['user']['name']);
     Rank rank =
     new Rank(r['user']['name'], r['duration'],r['reps'],r['progress']);
     print(rank.userName);
     rankList.add(rank);
   }
   return rankList;
 }
 static Future<void> updateWorkoutStatus(String email,String workoutId) async {
   final response = await http.put(Uri.parse('${domain}/api/user/workoutStatus'),
       headers: {"Content-Type": "application/json"},
       body: json.encode({'email': email , 'workoutId':workoutId}));

   print(response.body.toString());
 }

 static Future<void> AssignPlan(String email,String plan) async {
   final response = await http.post(Uri.parse('${domain}/api/user/assignPlan'),
       headers: {"Content-Type": "application/json"},
       body: json.encode({'email': email , 'name': plan }));

   print(response.body.toString());
 }
 static Future<List<Workout>> getPlanDetails(String PlanName) async {
   final response = await http.post(
       Uri.parse('${domain}/api/user/PlanDetail'),
       headers: {"Content-Type": "application/json"},
       body: json.encode({'planName': PlanName}));
   final data = jsonDecode(response.body);
   print(data.toString());
   List<Workout> workoutList = [];
   var extractWorkout;
   for (var details in data) {
     extractWorkout = details["workouts"];
   }
   for (var workout in extractWorkout) {
     print("here is the fokin duration"+workout['workout']['duration'].toString());
     Workout work = new Workout(workout["rep"], workout["sets"],
         workout["workout"]['workoutName'], workout["workout"]['gif'],workout["workout"]['_id'],workout['status'],workout['workout']['duration']);
     workoutList.add(work);
   }
   workoutList.forEach((element) {print(element.name);});

   return workoutList;
 }
 static Future<void> UpdateInfo(User u) async {
   final response = await http.put(Uri.parse('${domain}/api/user/update-user'),
       headers: {"Content-Type": "application/json"},
       body: json.encode({'email': u.email , 'updatedData': {'password':u.password , 'name':u.username , 'age':u.age,'height':u.height,'weight':u.weight}}));

   print(response.body.toString());
 }

 static Future<bool> PasswordConfirm(String email,String password) async {
   final response = await http.post(
       Uri.parse('${domain}/api/user/PassConfirm'),
       headers: {"Content-Type": "application/json"},
       body: json.encode({'email': email , 'password':password}));
   final data = jsonDecode(response.body);
   print(data.toString());
   if(data.toString()=="false"){
     print("false ahee");
     return false;
   }
   return true;
 }
}
