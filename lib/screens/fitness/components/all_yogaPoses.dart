import 'package:be_fit_app/constants/const.dart';

import 'package:flutter/material.dart';

import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_api/youtube_api.dart';

import '../../../widgets/app_bar.dart';

class AllYogaPoses extends StatefulWidget {
  const AllYogaPoses({super.key});

  @override
  State<AllYogaPoses> createState() => _AllYogaPosesState();
}

class _AllYogaPosesState extends State<AllYogaPoses> {
  static String api_key = "AIzaSyDty54-kp8ifP6Z8x-Huw16RUUhRDdFmXA";
  List<YouTubeVideo> videoResult = [];
  YoutubeAPI yt = YoutubeAPI(api_key,
      maxResults: 25,
      type:
          "video"); //instantiating object to call api with maximum videos as 6 and type as video
  bool isLoaded =
      false; //this variable lets us to know whether content is loaded or not

  callApi() async {
    try {
      videoResult = await yt.search(
          "meditation music + om chanting +  relaxing music +10 minutes"); //searching for videos related to 10 minute daily yoga
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(top: appPadding * 1.4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppBar(),
            SizedBox(height: size.height * 0.02),
             Padding(
              padding: EdgeInsets.only(left: appPadding * 2),
              child: Text(
                'Relax your Mind',
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.w600, color: Color(0xFFE18335)),
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
                            padding: const EdgeInsets.only(
                                left: appPadding * 0.7,
                                right: appPadding * 0.7,
                                bottom: appPadding * 0.7),
                            child: Container(
                              height: size.height * 0.28,
                              decoration: BoxDecoration(
                                  color: white,
                                  borderRadius: BorderRadius.circular(10.0),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              '${videoResult[index].duration} min',
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
                :  Center(
                    child: SleekCircularSlider(
                      appearance: CircularSliderAppearance(
                        customColors: CustomSliderColors(progressBarColor: primary),
                   
                        spinnerMode: true,
                        size: 40,
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
