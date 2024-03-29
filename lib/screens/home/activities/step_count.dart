import 'package:be_fit_app/constants/const.dart';
import 'package:be_fit_app/controller/step_controller.dart';
import 'package:be_fit_app/service/auth_controller.dart';
import 'package:be_fit_app/widgets/app_bar.dart';
import 'package:be_fit_app/widgets/radial_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/counter.dart';

String formatDate(DateTime d) {
  print(d.toString().substring(0, 19));
  return d.toString().substring(0, 19);
}

final StepCounter c = stepCounterController;

Future<int> getTodaySteps(int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  int todayDayNo = DateTime.now().day;
  int savedStepCount = prefs.getInt('savedStepCount') ?? 0;
  int lastDaySaved = prefs.getInt('lastDaySaved') ?? 0;
  int todaySteps = prefs.getInt('todaySteps') ?? 0;
  int lastValue = prefs.getInt('stepsLastValue') ?? 0;
  prefs.setInt('stepsLastValue', value);

  // c.steps.value = todaySteps;

  // device reboot
  if (savedStepCount > value) {
    prefs.setInt('savedStepCount', 0);
    savedStepCount = 0;
  }

  // next day
  if (todayDayNo > lastDaySaved) {
    prefs.setInt('lastDaySaved', todayDayNo);
    prefs.setInt('savedStepCount', value);
    prefs.setInt('todaySteps', 0);
    savedStepCount = value;
    todaySteps = 0;
  }

  if (savedStepCount == 0 && todaySteps > value) {
    if (value < 10) {
      prefs.setInt('todaySteps', value + todaySteps);
    } else {
      prefs.setInt('todaySteps', value - lastValue + todaySteps);
    }
  } else {
    prefs.setInt('todaySteps', value - savedStepCount);
  }

  todaySteps = prefs.getInt('todaySteps') ?? 0;
  c.updateSteps(todaySteps);

  print(
      "today day no$todayDayNo saved step count $savedStepCount last day saved $lastDaySaved last step value $lastValue");

  if (todaySteps > 0) {
    print("today steps in method $todaySteps");
    return todaySteps;
  } else {
    return 0;
  }
}

class MyStepCounter extends StatefulWidget {
  const MyStepCounter({super.key});

  @override
  State<MyStepCounter> createState() => _MyStepCounterState();
}

class _MyStepCounterState extends State<MyStepCounter> {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';

  final StepCounter c = stepCounterController;

  AuthController authController = Get.find<AuthController>();

  TextEditingController stepTargetController = TextEditingController();
  double targetval = 1;



  @override
  void initState() {
    initPlatformState();

    super.initState();
     authController.getUserInfo();
     targetval = authController.myUser.value.daily_target == null ? 1000 : authController.myUser.value.daily_target!.toDouble();
  }
  
  void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  Future<void> initPlatformState() async {
    if (await Permission.activityRecognition.request().isGranted) {
      _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
      _pedestrianStatusStream
          .listen(onPedestrianStatusChanged)
          .onError(onPedestrianStatusError);

      _stepCountStream = Pedometer.stepCountStream;
      _stepCountStream.listen(onStepCount).onError(onStepCountError);
    }
    if (!mounted) return;
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_status);

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: appPadding * 1.4),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              CustomAppBar(),
              SizedBox(
                height: h * 0.03,
              ),
              Row(
                children: [
                  Container(
                    width: w * 0.6,
                    margin: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 8,
                              spreadRadius: 5,
                              offset: const Offset(1, 1),
                              color: Colors.grey.withOpacity(0.2))
                        ]),
                    height: h * 0.07,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: stepTargetController,
                      validator: (value) {
                        if(double.parse(value!) < 1 && value.isEmpty){
                             Get.snackbar('Invalid input', 'Please enter a valid value');
                        }
                      },
                      textInputAction: TextInputAction.done,
                      onChanged: (value) {},
                      decoration: InputDecoration(
                          hintText: "Daily Target",
                          
                          prefixIcon: Icon(LineAwesomeIcons.bullseye,
                              color: Color(0xFF379634)),
                          
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7),
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 1.0)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7))),
                    ),
                  ),
                 ElevatedButton(
                
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF379634),
                
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 14,
                  ),
                ),
                child: const Text(
                  'Set',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w600, color: white),
                ),
                onPressed: ()async {
                   if (stepTargetController.text.trim().isEmpty){
                      return;
                     } 
                     
                     targetval = double.parse(stepTargetController.text.trim());  
                     targetval < 1 
                     ? targetval = 1000
                     : authController.setDailyTarget(targetval); 
                      stepTargetController.text="";
                     setState(() {
                       authController.getUserInfo();
                     });
                  hideKeyboard(context);
                },
              ),
                  // GestureDetector(
                  //   onTap: ()async {
            
                  //    if (stepTargetController.text.trim().isEmpty){
                  //     return;
                  //    } 
                     
                  //    targetval = double.parse(stepTargetController.text.trim());  
                  //    targetval < 1 
                  //    ? targetval = 1000
                  //    : authController.setDailyTarget(targetval); 
                  //     stepTargetController.text="";
                  //    setState(() {
                  //      authController.getUserInfo();
                  //    });
                   
                         
                  //   },
                  //   child: Container(
                  //     width: w * 0.32,
                  //     height: h * 0.07,
                  //     decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(12),
                  //         image: const DecorationImage(
                  //             image: AssetImage("assets/images/loginbtn.png"),
                  //             fit: BoxFit.cover)),
                  //     child: const Center(
                  //       child: Text(
                  //         "Set",
                  //         style: TextStyle(
                  //           fontSize: 20,
                  //           color: Colors.white,
                  //           fontWeight: FontWeight.w600,
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
               
                ],
              ),
        
              SizedBox(
                height: h * 0.05,
              ),
               Obx((() =>  authController.myUser.value.daily_target==null ?  const Text("Your set target will be displayed here.") : Text("Your daily target : ${authController.myUser.value.daily_target}"))),
   SizedBox(
                height: h * 0.03,
              ),
              const Text(
                'Today\'s Steps',
                style: TextStyle(fontSize: 30),
              ),
        
              //  Text(_steps, style: TextStyle(fontSize: 30),),
              _steps == '?'
                  ? const Text('WAAIT')
                  : FutureBuilder<int>(
                      future: getTodaySteps(int.parse(_steps)),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          // while data is loading:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          // datas loaded
                          final stepsUser = snapshot.data;
                          return Text(
                            stepsUser.toString(),
                            style: const TextStyle(fontSize: 60,color: Color(0xFF1D8F00)),

                          );
                        }
                      },
                    ),
              SizedBox(
                height: h * 0.03,
              ),
              const Text(
                'Your Activity',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(
                height: h * 0.03,
              ),
              _steps == '?'
                  ? const Text('WAAIT')
                  :   FutureBuilder<int>(
                      future: getTodaySteps(int.parse(_steps)),
                      builder: (context, snapshot) {
                       
                       
                        print("TARGET $targetval");
                        if (!snapshot.hasData) {
                          // while data is loading:
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          // datas loaded
                          final stepsUser = snapshot.data;
                              
                          return RadialProgress(mySteps: stepsUser!.toDouble(),target: targetval);
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
