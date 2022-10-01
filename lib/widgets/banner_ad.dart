import 'package:amazone_clone_app/config/barrel_config.dart';
import 'package:flutter/material.dart';

class BannerAd extends StatefulWidget {
  const BannerAd({Key? key}) : super(key: key);

  @override
  State<BannerAd> createState() => _BannerAdState();
}

class _BannerAdState extends State<BannerAd> {
  int currentAd = 0;
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    double smallAdHeight = 92;
    return GestureDetector(
      onHorizontalDragEnd: (_) {
        if (currentAd == (largeAds.length - 1)) {
          currentAd = -1;
        }
        setState(() {
          currentAd++;
        });
      },
      child: Column(
        children: [
          Stack(
            children: [
              Image.network(
                largeAds[currentAd],
                width: double.infinity,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  width: screenSize.width,
                  height: 100,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                        backgroundColor,
                        backgroundColor.withOpacity(0)
                      ])),
                ),
              )
            ],
          ),
          Container(
            color: backgroundColor,
            width: screenSize.width,
            height: smallAdHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                smallAdIndex(0, smallAdHeight),
                smallAdIndex(1, smallAdHeight),
                smallAdIndex(2, smallAdHeight),
                smallAdIndex(3, smallAdHeight),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget smallAdIndex(int index, double height) {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      height: height,
      width: height,
      decoration: ShapeDecoration(
        color: Colors.white,
        shadows: [
          BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 2),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.network(smallAds[index]),
          const SizedBox(height: 2),
          Text(adItemNames[index]),
        ],
      ),
    );
  }
}
