import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:noticeboard/models/slider.dart';
import 'package:noticeboard/worker/fetchslides.dart';

import '../models/staffs.dart';
import '../worker/fetchstaffs.dart';
import 'home.dart';

class CarouselSliderScreen extends StatefulWidget {
  const CarouselSliderScreen({super.key});

  @override
  State<CarouselSliderScreen> createState() => _CarouselSliderScreen();
}

class _CarouselSliderScreen extends State<CarouselSliderScreen> {
  List<Sliderx> slides = [];
  bool no_internet = false;
  int t = 0;
  var isSlideLoaded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getStaffs();
    setState(() {
      t = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isSlideLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            child: Column(
              children: [
                SizedBox(height: 10),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 550.0,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 90),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    onPageChanged: (index, reason) {
                      print(index.toString() + '----' + t.toString());
                      if (t == slides.length) {
                        flipPage();
                      }

                      setState(() {
                        t = t + 1;
                      });
                    },
                  ),
                  items: slides.map((i) {
                    /***
                     * 
                     * Last slider logic
                     */

                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          height: 580,
                          width: MediaQuery.of(context).size.width,
                          // ignore: prefer_const_constructors
                          margin: EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 2.0),
                          child: Card(
                            margin: const EdgeInsets.all(2),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CachedNetworkImage(
                                  height: 400,
                                  width: 600,
                                  imageUrl: (i.slider_image),
                                  fit: BoxFit.scaleDown,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(children: <Widget>[
                                  Expanded(
                                      child: Divider(
                                    color: Color.fromARGB(255, 30, 110, 231),
                                  )),
                                  Icon(
                                    FontAwesomeIcons.circle,
                                    color: Color.fromARGB(255, 30, 110, 231),
                                    size: 10,
                                  ),
                                  Text(
                                    i.Title,
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 30, 110, 231)),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.star,
                                    size: 15,
                                    color: Color.fromARGB(255, 30, 110, 231),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Expanded(
                                      child: Divider(
                                    color: Color.fromARGB(255, 30, 110, 231),
                                  )),
                                ]),
                                Html(data: i.description),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ));
  }

  getConnectivity() async {
    no_internet = await InternetConnectionChecker().hasConnection;
    if (!no_internet) {
      Timer.periodic(Duration(seconds: 2), (timer) {
        getConnectivity();

        if (no_internet) {
          timer.cancel();
        }
      });
      setState(() {
        no_internet = false;
      });
    } else {
      setState(() {
        no_internet = true;
      });
    }
  }

  flipPage() {
    print('-------------flip--------------');
    HomeScreen.of(context)?.setState(() {
      HomeScreen.of(context)?.table_done = false;
      HomeScreen.of(context)?.carousel_done = true;
      print(HomeScreen.of(context)?.table_done);
    });
  }

  getStaffs() async {
    slides = (await FetchSlides().fetchSlide())!;
    if (slides != null) {
      setState(() {
        isSlideLoaded = true;
      });
    }
  }

  stripUrl(i) {
    RegExp exp =
        new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    var url = exp.firstMatch(slides[i].slider_image);
    var txt = url?.group(0);
    if (txt == null) {
      txt =
          'https://lekbeshimun.gov.np/sites/lekbeshimun.gov.np/files/default.png';
    }

    print(url!.end);
    return txt;
  }

  stripText(i) {
    const start = '">';
    const end = '</a>';

    return 'result';
  }
}
