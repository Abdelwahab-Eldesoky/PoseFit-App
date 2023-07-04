class Workout {
  Workout(this.reps, this.sets, this.name, this.gifPath,this.id,this.workoutStatus,this.duration);

  Workout.fromWorkout(String name, String gifPath,id,duration) {
    this.name = name;
    this.gifPath = gifPath;
    this.id=id;
    this.duration=duration;
  }

  int reps = 0, sets = 0 , duration=0;
  String name = " ", gifPath = " ",id="";
  bool workoutStatus=false;
}