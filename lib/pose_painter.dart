import 'package:flutter/material.dart';

bool inRange(dynamic joint) {
  bool xValue = true;
  bool yValue = true;

  if (joint[0] < 12 || joint[0] > 410) {
    xValue = false;
  }
  if (joint[1] < 170 || joint[1] > 708) {
    yValue = false;
  }
  return (xValue && yValue);
}

class PosePainter extends CustomPainter {
  PosePainter(this.landmarks,this.poseIsCorrect);
  final List landmarks;
  final bool poseIsCorrect;

  
  @override
  void paint(Canvas canvas, Size size) {


    if(landmarks.isEmpty){
      return;
    }

    Size imageSize = const Size(400, 640);
    const double x = 10;
    const double y = 120;

    final correctPoseLine = Paint()
      ..strokeWidth = 4.0
      ..color = Colors.green.shade300;

    final correctPoseCircle = Paint()
      ..strokeWidth = 4.0
      ..color = Colors.purpleAccent;

    final wrongPoseLine = Paint()
      ..strokeWidth = 4.0
      ..color = Colors.red;

    final wrongPoseCircle = Paint()
      ..strokeWidth = 4.0
      ..color = Colors.blue.shade700;

    print("Paint Skeleton AAAAAAAAAAAAAAAAAAAAAAAAAAAA");

    for (var joint in landmarks) {
      joint[0] = x + (joint[0] * imageSize.width);
      joint[1] = y + (joint[1] * imageSize.height);
    }

    void paintLine(var joint1, var joint2, Paint paintType) {
      if (inRange(joint1) && inRange(joint2)) {
        canvas.drawLine(Offset(joint1[0], joint1[1]),
            Offset(joint2[0], joint2[1]), paintType);
      }
    }

    //Draw arms skeleton -->

    //left arm = {0, 1, 2}
    paintLine(landmarks.elementAt(0), landmarks.elementAt(1),
        poseIsCorrect ? correctPoseLine : wrongPoseLine);
    paintLine(landmarks.elementAt(1), landmarks.elementAt(2),
        poseIsCorrect ? correctPoseLine : wrongPoseLine);

    //right arm = {9, 10, 11}
    paintLine(landmarks.elementAt(9), landmarks.elementAt(10),
        poseIsCorrect ? correctPoseLine : wrongPoseLine);
    paintLine(landmarks.elementAt(10), landmarks.elementAt(11),
        poseIsCorrect ? correctPoseLine : wrongPoseLine);

    //Draw Body ==> 2, 9, 3, 8

    //left_shoulder > left_hip
    paintLine(landmarks.elementAt(2), landmarks.elementAt(3),
        poseIsCorrect ? correctPoseLine : wrongPoseLine);

    //left_shoulder > right_shoulder
    paintLine(landmarks.elementAt(2), landmarks.elementAt(9),
        poseIsCorrect ? correctPoseLine : wrongPoseLine);

    //left_hip > right_hip
    paintLine(landmarks.elementAt(3), landmarks.elementAt(8),
        poseIsCorrect ? correctPoseLine : wrongPoseLine);

    //right_hip > right_shoulder
    paintLine(landmarks.elementAt(8), landmarks.elementAt(9),
        poseIsCorrect ? correctPoseLine : wrongPoseLine);

    //Draw legs

    //left leg = {3, 4, 5}
    paintLine(landmarks.elementAt(3), landmarks.elementAt(4),
        poseIsCorrect ? correctPoseLine : wrongPoseLine);
    paintLine(landmarks.elementAt(4), landmarks.elementAt(5),
        poseIsCorrect ? correctPoseLine : wrongPoseLine);

    //right leg = {6, 7, 8}
    paintLine(landmarks.elementAt(6), landmarks.elementAt(7),
        poseIsCorrect ? correctPoseLine : wrongPoseLine);
    paintLine(landmarks.elementAt(7), landmarks.elementAt(8),
        poseIsCorrect ? correctPoseLine : wrongPoseLine);

    //Draw Joints
    for (var joint in landmarks) {
      if (inRange(joint)) {
        canvas.drawCircle(Offset(joint[0], joint[1]), 6,
            poseIsCorrect ? correctPoseCircle : wrongPoseCircle);
      }
    }
  }

  @override
  bool shouldRepaint(covariant PosePainter oldDelegate) {
    return true;
  }
}
