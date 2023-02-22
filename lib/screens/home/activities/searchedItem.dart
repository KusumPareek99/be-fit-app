
import 'package:be_fit_app/constants/const.dart';
import 'package:be_fit_app/model/food_model.dart';

import 'package:flutter/material.dart';



import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SearchedItem extends StatefulWidget {
  final String foodItem;
  const SearchedItem({super.key, required this.foodItem});
  
  @override
  State<SearchedItem> createState() => _SearchedItemState();
}

class _SearchedItemState extends State<SearchedItem> {
   late SearchFood item;
  bool loading = true;

   @override
  void initState() {
    searchData();
    super.initState();
  }

  Future<void> searchData() async {
   // if(widget.foodItem == ''){ return;}
    var url = Uri.parse("https://api.nal.usda.gov/fdc/v1/foods/search?api_key=DEMO_KEY&query=${widget.foodItem}");
      var response = await http.get(url);
    if (response.statusCode == 200) {
      var decodedResponse = convert.jsonDecode(response.body);
     // print('===================$decodedResponse');
      item = SearchFood.fromMap(decodedResponse);
     // print('===================$item');
      setState(() {
        loading = false;
      });
    } else {
      throw Exception('Failed to load data');
      
    }
  }
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        iconTheme: IconThemeData(color:white),
        title: loading
            ? const SizedBox.shrink()
            : FittedBox(
                child: Text(
                  widget.foodItem,
                  style: const TextStyle(fontSize: 28,color:white)
                ),
              ),
      ),
      body: Container(
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(15.0),
                    
                    child: Text(
                      textAlign:TextAlign.center,
                      "Portion: per 100g",
                      style: TextStyle(fontSize: 25,backgroundColor: Colors.green,color:white),
                      
                    ),
                  ),
                  Container(
                    child: Expanded(
                      child: ListView.builder(
                          itemCount: item == null
                              ? 0
                              : item.foods![1].foodNutrients!.length,
                          itemBuilder: (context, index) {
                            var nutrient =
                                item.foods![1].foodNutrients![index];
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: FittedBox(
                                    alignment: Alignment.topLeft,
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      item.foods![1].foodNutrients![index].value ==
                                              null
                                          ? " ${nutrient.nutrientName}: "
                                          : "${nutrient.nutrientName}:   ${item.foods![1].foodNutrients![index].value} ${item.foods![1].foodNutrients![index].value == null ? "" : nutrient.unitName}",
                                      style: item.foods![1].foodNutrients![index]
                                                  .value ==
                                              null
                                          ? const TextStyle(
                                              backgroundColor: Colors.green,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 23,
                                            )
                                          : const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                            ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  color: Colors.black54,
                                ),
                              ],
                            );
                          }),
                    ),
                  )
                ],
              ),    
      ),
      
    );
  }
}