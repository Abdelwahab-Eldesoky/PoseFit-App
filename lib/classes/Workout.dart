class Workout {
  Workout(this.reps, this.sets, this.name, this.gifPath);

  Workout.fromWorkout(String name, String gifPath) {
    this.name = name;
    this.gifPath = gifPath;
  }

  int reps = 0, sets = 0;
  String name = " ", gifPath = " ";
}
