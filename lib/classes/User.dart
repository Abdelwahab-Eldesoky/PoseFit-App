import 'dart:ffi';

class User{

  late String username,email,password,gender,activityLevel,plan;
  late double weight,height;
  late int age;


  User.fromUser();

  User(this.username,this.email, this.password, this.gender, this.activityLevel, this.plan,
      this.weight, this.height, this.age);

  String get getUsername {
    return username;
  }
  set setUsername(String username) {
    this.username = username;
  }

  String get getEmail {
    return email;
  }
  set setEmail(String email) {
    this.email = email;
  }

  String get getPassword {
    return password;
  }
  set setPassword(String password) {
    this.password = password;
  }
  String get getGender {
    return gender;
  }
  set setGender(String gender) {
    this.gender = gender;
  }
  String get getActivityLevel {
    return activityLevel;
  }
  set setActivityLevel(String activityLevel) {
    this.activityLevel = activityLevel;
  }

  double get getWeight {
    return weight;
  }
  set setWeight(double weight) {
    this.weight = weight;
  }

  double get getHeight {
    return height;
  }
  set setHeight(double height) {
    this.height = height;
  }

  int get getAge {
    return age;
  }
  set setAge(int age) {
    this.age = age;
  }
  String getPlan() {
    return plan;
  }
  set setplan(String plan) {
    this.plan = plan;
  }

}