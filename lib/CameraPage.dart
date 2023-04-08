import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final _cameras = await availableCameras();

  runApp(CameraApp(cameras: _cameras));
}

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  /// Default Constructor
  final List<CameraDescription> cameras;

  const CameraApp({Key? key, required this.cameras}) : super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  int counter = 0;
  String correction = "";

  late CameraController controller;
  BackdropFilter myBackDropFilter = BackdropFilter(
    filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
    child: Container(
      color: Colors.transparent.withOpacity(0.5),
    ),
  );
  bool startPressed = false;

  @override
  void initState() {
    super.initState();

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

    print("boody gad bta3 el fool : "+base64Image);
    final response = await http.post(
        Uri.parse('http://192.168.1.97:3000/api/model/${workout}'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({'data': base64Image}));

    final data = jsonDecode(response.body);

    print("Hossam Gaded : "+ data.toString());

    counter = data['reps'];
    correction = data["correction"];
    setState(() {});
  }

  @override
  void dispose() {
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
                      children: [
                        const Text(
                          "Counter : ",
                          style: TextStyle(
                              fontSize: 45,
                              color: Color(0xff262e57),
                              fontFamily: "gothic"),
                        ),
                        Text(
                          "${counter}",
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
                        child: CameraPreview(controller)),
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
                        Timer.periodic(const Duration(milliseconds: 5),
                                (_) async {
                              if (controller.value.isTakingPicture) {
                                return;
                              }

                              final image = await controller.takePicture();
                              final bytes = await image.readAsBytes();

                              _sendImage(bytes);
                            });

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
                )
              ],
            )));
  }
}
