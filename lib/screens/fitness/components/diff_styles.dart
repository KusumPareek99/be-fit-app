
import 'package:be_fit_app/constants/const.dart';
import 'package:be_fit_app/data/data.dart';
import 'package:be_fit_app/model/style.dart';
import 'package:flutter/material.dart';


class DiffStyles extends StatelessWidget {
  _buildStyles(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;
    Style style = styles[index];

    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: appPadding / 2),
          child: Container(
            margin:
                const EdgeInsets.only(top: appPadding * 3, bottom: appPadding * 2),
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
                      top: appPadding),
                  child: Text(
                    style.name,
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
                            style.time.toString() + ' min',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: black.withOpacity(0.3)),
                            maxLines: 2,
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: primary,
                            borderRadius: BorderRadius.circular(5.0)),
                        child: const Icon(
                          Icons.add,
                          color: white,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            child: Image(
              width: size.width * 0.3,
              height: size.height * 0.2,
              image: AssetImage(style.imageUrl),
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
                'Mindfulness',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                
                ),
              ),
              const Text(
                'See All',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w600, color: primary),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: appPadding / 2),
          child: Container(
            height: size.height * 0.33,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: styles.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildStyles(context, index);
                }),
          ),
        )
      ],
    );
  }
}
