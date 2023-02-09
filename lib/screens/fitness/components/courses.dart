import 'package:be_fit_app/constants/const.dart';
import 'package:be_fit_app/screens/fitness/components/all_courses.dart';

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_api/youtube_api.dart';

class Courses extends StatefulWidget {
  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  static String api_key = "AIzaSyDty54-kp8ifP6Z8x-Huw16RUUhRDdFmXA";
  List<YouTubeVideo> videoResult = [];
  YoutubeAPI yt = YoutubeAPI(api_key,
      maxResults: 6,
      type:
          "video"); //instantiating object to call api with maximum videos as 6 and type as video
  bool isLoaded =
      false; //this variable lets us to know whether content is loaded or not

  callApi() async {
    try {
      videoResult = await yt.search(
          "10 minute daily yoga "); //searching for videos related to 10 minute daily yoga
      print(videoResult); //logging results in console
      setState(() {
        isLoaded = true; //setting content as loaded
      });
    } catch (e) {
      print(
          e); //in case of any exception like no internet or problem with API log it to console
    }
  }

  @override
  void initState() {
    super.initState();
    callApi(); //calling async api function to get the  data from API
  }

//mainAxisSize to MainAxisSize.min and using FlexFit.loose fits
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: appPadding,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [
                const Text(
                  'Courses',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Material(
                  child: InkWell(
                    onTap: (() {
                      
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AllCourses()),
                );
                    }),
                    child: const Text(
                      'See All',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: primary),
                    ),
                  ),
                ),
              ],
            ),
          ),
          isLoaded
              ? Flexible(
                  fit: FlexFit.loose,
                  child: ListView.builder(
                    itemCount: videoResult.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          //launch url
                          String url = videoResult[index].url;
                           if (await launchUrlString(url)) {
                        await launchUrlString(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                          print("Launching URL ...");
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(appPadding*0.7),
                          child: Container(
                            height: size.height * 0.28,
                  
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(30.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: black.withOpacity(0.3),
                                      blurRadius: 30.0,
                                      offset: const Offset(10, 15))
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: appPadding,
                                     ),
                                  child: Container(
                                    width: size.width * 0.3,
                                    height: size.height * 0.5,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(28),
                                          topRight: Radius.circular(28)),
                                      child: Image.network(
                                        videoResult[index]
                                                .thumbnail
                                                .medium
                                                .url ??
                                            '',
                                        
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: size.width * 0.4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        videoResult[index].channelTitle,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                        maxLines: 2,
                                      ),
                                     SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Text(
                                        videoResult[index].title,
                                        style: TextStyle(
                                          color: black.withOpacity(0.3),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.access_time_outlined,
                                            color: black.withOpacity(0.3),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.01,
                                          ),
                                          Text(
                                            '${videoResult[index]
                                                    .duration} min',
                                            style: TextStyle(
                                              color: black.withOpacity(0.3),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : const Center(
                  child: SleekCircularSlider(
                    appearance: CircularSliderAppearance(
                      spinnerMode: true,
                      size: 40,
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
