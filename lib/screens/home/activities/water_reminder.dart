import 'package:be_fit_app/constants/const.dart';
import 'package:be_fit_app/widgets/app_bar.dart';
import 'package:flutter/material.dart';



class WaterReminder extends StatefulWidget {
  const WaterReminder({super.key});

  @override
  State<WaterReminder> createState() => _WaterReminderState();
}

class _WaterReminderState extends State<WaterReminder> {
   bool isSwitched = false;
   var textValue = 'Switch is OFF';    
   void toggleSwitch(bool value) {  
  
    if(isSwitched == false)  
    {  
      setState(() {  
        isSwitched = true;  
        textValue = 'Switch Button is ON'; 
        // code to set on water reminder .. give the user notifications 
      });  
      print('Switch Button is ON');  
    }  
    else  
    {  
      setState(() {  
        isSwitched = false;  
        textValue = 'Switch Button is OFF';  
        // code to set off water reminder .. stop the user notifications
      });  
      print('Switch Button is OFF');  
    }  
  }  
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        body:Container(
           padding: const EdgeInsets.only(top: appPadding * 1.4),
          
        child: Column(
         
          children: [
            CustomAppBar(),
            SizedBox(height: h * 0.2,),
              const Text("Set ON to recieve water reminder notifications",textAlign: TextAlign.center),
           switchWidget(),
          
          ],
        ),
        ),
    );
  }

  Transform switchWidget() {
    return Transform.scale(  
          scale: 1,  
          child: Switch(  
            onChanged: toggleSwitch,  
            value: isSwitched,  
            activeColor: Colors.redAccent,   
            activeTrackColor: Colors.orange,    
            inactiveThumbColor: Colors.grey[400],  
            inactiveTrackColor: Colors.grey[300],  
          )  
        );
  }
}