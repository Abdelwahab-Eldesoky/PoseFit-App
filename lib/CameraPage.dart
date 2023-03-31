import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

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
  late CameraController controller;

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
  }Future<void> _sendImage(List<int> bytes) async {
    // Create a HttpClientRequest and set the content type to "image/jpeg".
    print('hii');
    final base64Image = base64Encode(bytes);
    final Map<String, dynamic> postData = {
      'image': base64Image,
    };
    var data=jsonEncode(postData);
    print("aaaaaaaaaaaaaaaaa + "+data);
    print("detaiiiiiiiiilssssssss"+base64Image.toString());
    final response = await http.post(
        Uri.parse('http://192.168.1.97:3000/model'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(postData));
    print(response.body);
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
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "Counter",
                style: TextStyle(
                    fontSize: 45,
                    color: Color(0xff262e57),
                    fontFamily: "gothic"),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Text(
                  "11",
                  style: TextStyle(
                      fontSize: 40,
                      color: Color(0xfff7a007),
                      fontFamily: "gothic",
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                  clipBehavior: Clip.antiAlias,
                  margin: EdgeInsets.only(right: 10, left: 10),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(50)),
                  child: CameraPreview(controller)),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  "00:25",
                  style: TextStyle(
                      fontSize: 40,
                      color: Color(0xfff7a007),
                      fontFamily: "gothic",
                      fontWeight: FontWeight.bold),
                ),
              )
              ,
              FloatingActionButton(
                // Provide an onPressed callback.
                onPressed: () async {
                  // Take the Picture in a try / catch block. If anything goes wrong,
                  // catch the error.
                  Timer.periodic(Duration(seconds: 1), (_) async {
                    print("222");
                    if (controller.value.isTakingPicture) {
                      return;
                    }
                    final image = await controller.takePicture();
                    final bytes = await image.readAsBytes();
                    _sendImage(bytes);
                  });
                },
                child: const Icon(Icons.camera_alt_rounded),
              ),
            ],
          ),
        ));
  }
}

class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
