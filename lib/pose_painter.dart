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
  PosePainter(this.landmarks);
  final List landmarks;

  @override
  void paint(Canvas canvas, Size size) {

    if(landmarks.isEmpty){
      return;
    }

    Size imageSize = const Size(400, 640);
    const double x = 10;
    const double y = 120;
    final bool poseIsCorrect;

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

    poseIsCorrect = landmarks.elementAt(0);
    landmarks.removeAt(0); //To contain landmarks only (remove bool)

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

    //Draw arms -->

    //left arm= {0, 1, 2}
    paintLine(landmarks.elementAt(0), landmarks.elementAt(1),
        poseIsCorrect ? correctPoseLine : wrongPoseLine);
    paintLine(landmarks.elementAt(1), landmarks.elementAt(2),
        poseIsCorrect ? correctPoseLine : wrongPoseLine);

    //right arm= {5, 6, 7}
    paintLine(landmarks.elementAt(5), landmarks.elementAt(6),
        poseIsCorrect ? correctPoseLine : wrongPoseLine);
    paintLine(landmarks.elementAt(6), landmarks.elementAt(7),
        poseIsCorrect ? correctPoseLine : wrongPoseLine);

    //Draw Body ==> 2, 3, 4, 5

    //left_shoulder > left_hip
    paintLine(landmarks.elementAt(2), landmarks.elementAt(3),
        poseIsCorrect ? correctPoseLine : wrongPoseLine);

    //left_shoulder > right_shoulder
    paintLine(landmarks.elementAt(2), landmarks.elementAt(5),
        poseIsCorrect ? correctPoseLine : wrongPoseLine);

    //left_hip > right_hip
    paintLine(landmarks.elementAt(3), landmarks.elementAt(4),
        poseIsCorrect ? correctPoseLine : wrongPoseLine);

    //right_hip > right_shoulder
    paintLine(landmarks.elementAt(4), landmarks.elementAt(5),
        poseIsCorrect ? correctPoseLine : wrongPoseLine);

    //Draw legs
    // paintLine(PoseLandmarkType.leftHip, PoseLandmarkType.leftKnee, leftPaint);
    // paintLine(
    //     PoseLandmarkType.leftKnee, PoseLandmarkType.leftAnkle, leftPaint);
    // paintLine(
    //     PoseLandmarkType.rightHip, PoseLandmarkType.rightKnee, rightPaint);
    // paintLine(
    //     PoseLandmarkType.rightKnee, PoseLandmarkType.rightAnkle, rightPaint);

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
