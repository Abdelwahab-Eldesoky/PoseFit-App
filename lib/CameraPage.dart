import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:better_sound_effect/better_sound_effect.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;

late List<CameraDescription> _cameras;

/*Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _cameras = await availableCameras();

  runApp(CameraApp(cameras: _cameras));
}*/

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  final List<CameraDescription> cameras;
  final int reps;
  final int sets;

  const CameraApp({Key? key, required this.cameras, required this.reps,required this.sets})
      : super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  int repCounter = 0;
  int setCounter = 0;
  String correction = "";
  bool setFinished = false;
  late CameraController controller;
  bool startPressed = false;
  int restTimerNow = 20;

  //sound
  final soundEffect = BetterSoundEffect();
  int? soundId;
  int lastCount=0;

  String lastCorrection="";
  int repeatCorrectionCounter=0;

  FlutterTts myVoiceCaller=FlutterTts();

  BackdropFilter myBackDropFilter = BackdropFilter(
    filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
    child: Container(
      color: Colors.transparent.withOpacity(0.5),
    ),
  );

  @override
  void initState() {
    super.initState();

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

  Future<void> _sendImage(List<int> bytes) async {
    const workout = "bicepCurl";
    final base64Image = base64Encode(bytes);

    final response = await http.post(
        Uri.parse('http://192.168.0.105:3000/api/model/${workout}'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'data': base64Image}));

    final data = jsonDecode(response.body);


    repCounter = data['reps']-(setCounter*widget.reps);
    correction = data["correction"];

    if(data['reps']!=lastCount){
      if (soundId != null) {
        soundEffect.play(soundId!);
      }
      lastCount=data['reps'];
    }


    if(correction!=lastCorrection||repeatCorrectionCounter==5){
      await myVoiceCaller.speak(correction);
      lastCorrection=correction;
      repeatCorrectionCounter=1;
    } else{
      repeatCorrectionCounter++;
    }

    if (repCounter == widget.reps) {
      //controller.dispose();
      setCounter++;
      setFinished = true;
      correction="";
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
                  ),setFinished? restProcedure():Container()
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
                backgroundColor: MaterialStateProperty.all(
                    Color(0xfff7a007)),
                shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32.0),
                    ))),
            onPressed: () {
          setState(() {
            restTimerNow=20;
            setFinished=false;
            //controller.initialize();
            myBackDropFilter = BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0));

          });
        }, child: Text("Start next set",style: TextStyle(
            fontSize: 25, fontFamily: "gothic",color: Color(0xff262e57)),))
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

  startRestTimer(){
    Timer restTimer=Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if(restTimerNow<=0 || !setFinished){
          return;
        }
        restTimerNow--;
      });
    });
  }
}
