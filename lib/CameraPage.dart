import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:better_sound_effect/better_sound_effect.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'package:pose_fit/classes/ApiManager.dart';
import 'package:pose_fit/classes/Rank.dart';

import 'Home.dart';
import 'TodayPlan.dart';
import 'classes/Workout.dart';
import 'classes/WorkoutHistoryEntry.dart';



/*Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _cameras = await availableCameras();

  runApp(CameraApp(cameras: _cameras));
}*/

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  final List<CameraDescription> cameras;
  final Workout runningWorkout;
  final String email;
  final double workoutSource;

  // 1.0 -> planBased // 2.1 -> searchBased(withSetsAndReps) // 2.2 -> searchBased(till Failure) // 3.0 -> ChallengeBased

  const CameraApp(
      {Key? key,
      required this.email,
      required this.cameras,
      required this.runningWorkout,
      required this.workoutSource})
      : super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  String userName="Not Loaded Yet";
  int repCounter = 0;
  int setCounter = 0;
  String correction = "";
  bool setFinished = false;
  late CameraController controller;
  bool startPressed = false;
  int restTimerNow = 20;

  int setTotalSeconds = 0;

  //sound
  final soundEffect = BetterSoundEffect();
  int? soundId;
  int lastCount = 0;

  String lastCorrection = "";
  int repeatCorrectionCounter = 0;

  FlutterTts myVoiceCaller = FlutterTts();

  @override
  void setState(fn) {
    if (mounted) {
      print("i entereeeeed");
      super.setState(fn);
    }
  }

  void getUserName()async{
    userName=await ApiManager.getPersonName(widget.email);
  }
  BackdropFilter myBackDropFilter = BackdropFilter(
    filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
    child: Container(
      color: Colors.transparent.withOpacity(0.5),
    ),
  );

  @override
  void initState() {
    super.initState();

    getUserName();

    Future.microtask(() async {
      soundId = await soundEffect.loadAssetAudioFile("assets/counted.wav");
    });

    controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.cameras[0],
      // Define the resolution to use.
      ResolutionPreset.medium,
    );
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  void setFinishedMessage(){
    showDialog(
      context: context,
      builder: (context) {
        {
          return AlertDialog(
            icon: Icon(
              Icons.check_circle_outline_outlined,
              size: 70,
              color: Color(0xfff7a007),
            ),
            title: Center(
              child: Text(
                "Good Work!",
                style: TextStyle(
                    fontSize: 27,
                    color: Color(0xff262e57),
                    fontWeight: FontWeight.bold),
              ),
            ),
            content: Text("You have finished the whole set",textAlign: TextAlign.center,style: TextStyle(fontSize: 23,fontFamily: "gothic",color: Color(0xff262e57)),),
            elevation: 30,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))),
            actions: [
              TextButton(
                  onPressed: () {

                    ApiManager.updateWorkoutStatus(widget.email, widget.runningWorkout.id);

                    setFinished = true;
                    restTimerNow = 0;
                    controller.dispose();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TodayPlan(widget.email, 0)),
                    );
                  },
                  child: Center(
                      child: Text(
                        "OK",
                        style: TextStyle(
                            fontSize: 27,
                            fontFamily: "gothic",
                            color: Color(0xff262e57)),
                      )))
            ],
          );
        }
      },
    );
  }
  void stopTrainingMessage() {
    showDialog(
      context: context,
      builder: (context) {
        {
          return AlertDialog(
            icon: Icon(
              Icons.info_outline_rounded,
              size: 30,
              color: Color(0xfff7a007),
            ),
            title: Center(
              child: Text(
                "Do you want to stop training?",
                style: TextStyle(
                    fontSize: 27,
                    color: Color(0xff262e57),
                    fontWeight: FontWeight.bold),
              ),
            ),
            content: Text(
              "By stopping training you won't be able to continue on the same progress again",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xfff7a007), fontFamily: "gothic", fontSize: 20),
            ),
            elevation: 30,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Center(
                          child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "gothic",
                            color: Color(0xff262e57)),
                      ))),
                  TextButton(
                      onPressed: () {
                        addToHistory(repCounter);
                        setFinished = true;
                        restTimerNow = 0;
                        controller.dispose();
                       if(widget.workoutSource==3){
                         double progress=repCounter/setTotalSeconds;
                         Rank tmp=new Rank(userName,setTotalSeconds,repCounter,progress);

                         ApiManager.addRank(widget.email, tmp);
                       }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(widget.email)),
                        );
                      },
                      child: Center(
                          child: Text(
                        "OK",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "gothic",
                            color: Color(0xff262e57)),
                      ))),
                ],
              )
            ],
          );
        }
      },
    );
  }

  Future<void> _sendImage(List<int> bytes) async {
    const workout = "bicepCurl";
    final base64Image = base64Encode(bytes);

    final response = await http.post(
        Uri.parse('http://192.168.1.6:3000/api/model/${workout}'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'data': base64Image}));

    final data = jsonDecode(response.body);

    repCounter = data['reps'] - (setCounter * widget.runningWorkout.reps);
    correction = data["correction"];

    if (data['reps'] != lastCount) {
      if (soundId != null) {
        soundEffect.play(soundId!);
      }
      lastCount = data['reps'];
    }

    if (correction != lastCorrection || repeatCorrectionCounter == 5) {
      await myVoiceCaller.speak(correction);
      lastCorrection = correction;
      repeatCorrectionCounter = 1;
    } else {
      repeatCorrectionCounter++;
    }

    if (repCounter == widget.runningWorkout.reps &&
        (widget.workoutSource == 1 || widget.workoutSource == 2.2)) {

      if(setCounter+1==widget.runningWorkout.sets){ // if all sets finished close page

        setFinishedMessage();

      }

      setCounter++;
      setFinished = true;
      setTotalSeconds = 0;
      correction = "";
      addToHistory(widget.runningWorkout.reps);
      startRestTimer();
    }
    setState(() {});
  }

  @override
  void dispose() {
    if (soundId != null) {
      soundEffect.release(soundId!);
    }
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Counter : ",
                      style: TextStyle(
                        fontSize: 45,
                        color: Color(0xff262e57),
                        fontFamily: "gothic",
                      ),
                    ),
                    Text(
                      "${repCounter}",
                      style: const TextStyle(
                          fontSize: 45,
                          color: Color(0xfff7a007),
                          fontFamily: "gothic"),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment:
                      widget.workoutSource == 2.2 || widget.workoutSource == 3
                          ? MainAxisAlignment.spaceEvenly
                          : MainAxisAlignment.center,
                  children: [
                    Text(
                      ((setTotalSeconds / 60).toInt() < 10
                              ? "0" + (setTotalSeconds / 60).toInt().toString()
                              : (setTotalSeconds / 60).toInt().toString()) +
                          " : " +
                          ((setTotalSeconds % 60).toInt() < 10
                              ? "0" + (setTotalSeconds % 60).toInt().toString()
                              : (setTotalSeconds % 60).toInt().toString()),
                      style: TextStyle(
                          fontFamily: "gothic",
                          color: Color(0xff262e57),
                          fontSize: 35),
                    ),
                    widget.workoutSource == 2.2 || widget.workoutSource == 3
                        ? ElevatedButton(
                            onPressed: () {
                              stopTrainingMessage();
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    const Color(0xffc32b42)),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32.0),
                                ))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                Text(
                                  "Stop Training",
                                  style: TextStyle(
                                      fontFamily: "gothic",
                                      fontSize: 20,
                                      color: Colors.white),
                                )
                              ],
                            ))
                        : Container()
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.only(right: 10, left: 10),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(50)),
                    child: setFinished
                        ? SizedBox(
                            height: 500,
                            child: Center(
                                child: Text(
                              "Please rest some Time",
                              style:
                                  TextStyle(fontSize: 30, fontFamily: "gothic"),
                            )))
                        : CameraPreview(controller)),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "${correction}",
                  style: const TextStyle(
                      fontSize: 40,
                      color: Color(0xfff7a007),
                      fontFamily: "gothic"),
                ),
              ],
            ),
            myBackDropFilter,
            startPressed
                ? Container()
                : Center(
                    child: ElevatedButton(
                        style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(const Size(
                              220,
                              60,
                            )),
                            backgroundColor: MaterialStateProperty.all(
                                const Color(0xff262e57)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ))),
                        onPressed: () async {
                          startPressed = true;
                          myBackDropFilter = BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0));

                          // Take the Picture in a try / catch block. If anything goes wrong,
                          // catch the error.
                          takePictureTimer();
                          workoutTimer();

                          setState(() {});
                        },
                        child: const Text(
                          "Start",
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.white,
                              fontFamily: "gothic",
                              fontWeight: FontWeight.bold),
                        )),
                  ),
            setFinished ? restProcedure() : Container()
          ],
        )));
  }

  takePictureTimer() async {
    Timer.periodic(const Duration(milliseconds: 5), (_) async {
      if (controller.value.isTakingPicture) {
        return;
      }
      if (setFinished) {
        return;
      }

      final image = await controller.takePicture();
      final bytes = await image.readAsBytes();

      _sendImage(bytes);
    });
  }

  Widget restProcedure() {
    setState(() {
      myBackDropFilter = BackdropFilter(
        filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
        child: Container(
          color: Colors.transparent.withOpacity(0.5),
        ),
      );
    });
    return Center(
        child: restTimerNow == 0
            ? ElevatedButton(
                style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(
                      220,
                      60,
                    )),
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xfff7a007)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ))),
                onPressed: () {
                  setState(() {
                    setTotalSeconds = 0;
                    restTimerNow = 20;
                    setFinished = false;
                    //controller.initialize();
                    myBackDropFilter = BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0));
                  });
                },
                child: Text(
                  "Start next set",
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: "gothic",
                      color: Color(0xff262e57)),
                ))
            : SizedBox(
                height: 200,
                width: 200,
                child: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(
                      value: restTimerNow / 20,
                      strokeWidth: 8,
                      color: Color(0xfff7a007),
                    ),
                    Center(
                        child: Text(
                      restTimerNow.toString(),
                      style: TextStyle(
                          fontFamily: "gothic",
                          fontSize: 80,
                          color: Color(0xff262e57)),
                      textAlign: TextAlign.center,
                    ))
                  ],
                ),
              ));
  }

  startRestTimer() {
    Timer restTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (restTimerNow <= 0 || !setFinished) {
          return;
        }
        restTimerNow--;
      });
    });
  }

  workoutTimer() async {
    Timer.periodic(const Duration(seconds: 1), (_) {
      if (setFinished) {
        return;
      }
      setTotalSeconds++;
      setState(() {});
    });
  }

  void addToHistory(int reps) {
    double performance=((widget.runningWorkout.duration*reps)/setTotalSeconds)*100;
    if(performance>100){
      performance=100;
    }
    WorkoutHistoryEntry tmp = new WorkoutHistoryEntry(
        widget.runningWorkout.name, DateTime.now().toIso8601String(), reps,setTotalSeconds,performance);
    ApiManager.addToHistory(widget.email, tmp);
  }
}
