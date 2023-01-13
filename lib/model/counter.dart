import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepCounter extends GetxController{
  var steps = 0.obs;
  
  StepCounter(){
    initialize();
  }

  initialize() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
    
    int todaySteps = prefs.getInt('todaySteps') ?? 0;

    steps.value = todaySteps;
  }

  void updateSteps(int value){
    steps.value = value;
  }
}
