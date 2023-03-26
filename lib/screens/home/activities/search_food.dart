import 'package:be_fit_app/constants/const.dart';
import 'package:be_fit_app/screens/home/activities/CustomSearchDelegate.dart';
import 'package:flutter/material.dart';


class SearchFood extends StatefulWidget {
  const SearchFood({super.key});

  @override
  State<SearchFood> createState() => _SearchFoodState();
}

class _SearchFoodState extends State<SearchFood> {
  @override
  Widget build(BuildContext context) {
     double h = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: primary,
        iconTheme: IconThemeData(color: white),
        title: const Text(
          "Search Nutrients",
          style: TextStyle(color: white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // method to show the search bar
              showSearch(
                context: context,
                // delegate to customize the search bar
                delegate: CustomSearchDelegate()
              );
            },
            icon: const Icon(Icons.search),
          )
        ],  
      ),
      body: Column
      (
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
         Text("Your can search your nutrition intake here",style: TextStyle(fontSize: 30,color:primary),textAlign: TextAlign.center,)
         ])
      
    );
   }
}