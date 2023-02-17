import 'package:be_fit_app/constants/const.dart';
import 'package:be_fit_app/screens/fitness/components/all_yogaPoses.dart';

import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:youtube_api/youtube_api.dart';

class DiffStyles extends StatefulWidget {
  @override
  State<DiffStyles> createState() => _DiffStylesState();
}

class _DiffStylesState extends State<DiffStyles> {
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
          "yoga poses for daily exercise 10 minute"); //searching for videos related to 10 minute daily yoga
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

  _buildStyles(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: appPadding / 2),
          child: GestureDetector(
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
            child: Container(
              margin: const EdgeInsets.only(
                  top: appPadding * 3, bottom: appPadding * 2),
              width: size.width * 0.4,
              height: size.height * 0.2,
              decoration: BoxDecoration(
                  color: white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)),
                  boxShadow: [
                    BoxShadow(
                        color: black.withOpacity(0.2),
                        blurRadius: 10.0,
                        offset: const Offset(5, 15))
                  ]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: appPadding / 2,
                        right: appPadding * 3,
                        top: appPadding * 3),
                    child: Text(
                      videoResult[index].title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: appPadding / 2,
                        right: appPadding / 2,
                        bottom: appPadding),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: black.withOpacity(0.3)),
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            child: CircleAvatar(
              //borderRadius: BorderRadius.circular(70.0),
              backgroundImage: NetworkImage(
                videoResult[index].thumbnail.medium.url ?? '',

                //fit: BoxFit.cover,
              ),
              radius: 50,
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: appPadding, vertical: appPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Yoga Poses',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Material(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AllYogaPoses()));
                  },
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
            ? Padding(
                padding: const EdgeInsets.only(left: appPadding / 2),
                child: Container(
                  height: size.height * 0.33,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: videoResult.length,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildStyles(context, index);
                      }),
                ),
              )
            : Center(
                child: SleekCircularSlider(
                  appearance: CircularSliderAppearance(
                    customColors: CustomSliderColors(progressBarColor: primary),
                    spinnerMode: true,
                    size: 40,
                  ),
                ),
              )
      ],
    );
  }
}
