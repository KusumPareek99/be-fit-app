import 'package:be_fit_app/controller/step_controller.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vector_math/vector_math_64.dart' as math;

import '../constants/const.dart';
import '../model/counter.dart';

class RadialProgress extends StatefulWidget {
    
  final double mySteps,target;
  
  const RadialProgress({Key? key, required this.mySteps,required this.target}) : super(key: key);
 

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _radialProgressAnimationController;
  late Animation<double> _progressAnimation;
  final Duration fadeInDuration = const Duration(milliseconds: 500);
  final Duration fillDuration = const Duration(seconds: 2);

  double progressDegrees = 0;
  var count = 0;

// getDailyTarget() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   //Return String
//   String? stringValue = prefs.getString('target');
  
//   return stringValue;
// }

  @override
  void initState()  {
    super.initState();
    _radialProgressAnimationController =
        AnimationController(vsync: this, duration: fillDuration);
    _progressAnimation = Tween(begin: 0.0, end: 360.0).animate(CurvedAnimation(
        parent: _radialProgressAnimationController, curve: Curves.easeIn))
      ..addListener(() {
        
        setState(() {
          // Set progress bar according to target
          progressDegrees = (widget.mySteps/widget.target) * _progressAnimation.value;
         
        });
      });

    _radialProgressAnimationController.forward();


  }

  @override
  void dispose() {
    _radialProgressAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final StepCounter c = stepCounterController;
    return CustomPaint(
      painter: RadialPainter(progressDegrees),
      child: Container(
        height: 200.0,
        width: 200.0,
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: AnimatedOpacity(
          opacity: progressDegrees > 30 ? 1.0 : 0.0,
          duration: fadeInDuration,
          child: Column(
            children: <Widget>[
              const Text(
                'STEPS',
                style: TextStyle(fontSize: 24.0, letterSpacing: 1.5),
              ),
              const SizedBox(
                height: 4.0,
              ),
              Container(
                height: 5.0,
                width: 80.0,
                decoration: const BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.all(Radius.circular(4.0))),
              ),
              const SizedBox(
                height: 10.0,
              ),
              // Obx(() => Text("${c.steps.value}",style: const TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold))),
              Text("${widget.mySteps.toInt()}/${widget.target.toInt()}",style: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

class RadialPainter extends CustomPainter {
  double progressInDegrees;

  RadialPainter(this.progressInDegrees);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black12
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8.0;

    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawCircle(center, size.width / 2, paint);

    Paint progressPaint = Paint()
      ..shader = const LinearGradient(
              colors: [primary, secondary, Color.fromARGB(255, 210, 59, 112)])
          .createShader(Rect.fromCircle(center: center, radius: size.width / 2))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10.0;

    canvas.drawArc(
        Rect.fromCircle(center: center, radius: size.width / 2),
        math.radians(-90),
        math.radians(progressInDegrees),
        false,
        progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}