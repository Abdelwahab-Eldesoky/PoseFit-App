class Workout {
  Workout(this.reps, this.sets, this.name, this.gifPath,this.id,this.workoutStatus);

  Workout.fromWorkout(String name, String gifPath,id) {
    this.name = name;
    this.gifPath = gifPath;
    this.id=id;
  }

  int reps = 0, sets = 0;
  String name = " ", gifPath = " ",id="";
  bool workoutStatus=false;
}