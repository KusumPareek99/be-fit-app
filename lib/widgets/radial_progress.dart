import 'package:be_fit_app/controller/step_controller.dart';
import 'package:be_fit_app/service/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:vector_math/vector_math_64.dart' as math;

import '../constants/const.dart';
import '../model/counter.dart';

class RadialProgress extends StatefulWidget {
    
  final double mySteps,target;
  
  const RadialProgress({Key? key, required this.mySteps,required this.target}) : super(key: key);
 

  @override
  _RadialProgressState createState() => _RadialProgressState();
}

class _RadialProgressState extends State<RadialProgress> with SingleTickerProviderStateMixin {

  late AnimationController _radialProgressAnimationController;
  late Animation<double> _progressAnimation;
  final Duration fadeInDuration = const Duration(milliseconds: 500);
  final Duration fillDuration = const Duration(seconds: 2);

  double progressDegrees = 0;
  var count = 0;

 AuthController authController = Get.find<AuthController>();

  @override
  void initState()  {
    print("Radial init");
    super.initState();
     authController.getUserInfo();
    _radialProgressAnimationController =
        AnimationController(vsync: this, duration: fillDuration);
    _progressAnimation = Tween(begin: 0.0, end: 360.0).animate(CurvedAnimation(
        parent: _radialProgressAnimationController, curve: Curves.easeIn))
      ..addListener(() {
        
        setState(() {
         double i =  authController.myUser.value.daily_target == null ? 1000 : authController.myUser.value.daily_target!.toDouble() ;
          // Set progress bar according to target
        
        progressDegrees = (widget.mySteps / i) * _progressAnimation.value;
        //  print("PRogress DEgrees$progressDegrees");
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
   // print("RADAL PROG PG "+ widget.target.toString());
    return Obx( () => authController.myUser.value.daily_target == null 
    ?  CustomPaint(
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
                decoration:  BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.all(Radius.circular(4.0))),
              ),
              const SizedBox(
                height: 10.0,
              ),
           const  Text("Your set target will be displayed here."),
            ],
          ),
        ),
      ),
    )

    : CustomPaint(
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
                decoration:  BoxDecoration(
                    color: Color(0xFF379634),
                    borderRadius: BorderRadius.all(Radius.circular(4.0))),
              ),
              const SizedBox(
                height: 10.0,
              ),
            Text(authController.myUser.value.daily_target.toString()),
            ],
          ),
        ),
      ),
    )
 
    
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
      ..shader =  LinearGradient(
              colors: [Color(0xFF79D076), Color(0xFF4DC149), Color(0xFF379634)])
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