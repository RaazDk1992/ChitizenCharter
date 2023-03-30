import 'dart:async';

import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:noticeboard/main.dart';
import 'package:noticeboard/models/services.dart';
import 'package:noticeboard/screens/home.dart';
import 'package:noticeboard/worker/fetchservices.dart';

class CustomTable extends StatefulWidget {
  const CustomTable({super.key});

  @override
  State<CustomTable> createState() => _TableState();
}

class _TableState extends State<CustomTable> {
  List<Service> serviceList = [];
  var is_service_loaded = false;
  final _key = new GlobalKey<PaginatedDataTableState>();

/**
 * 
 * Settings for Table
 * 
 */

  int t = 0;

  /**
   * 
   * Navigate for Last item.
   */

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getServices();
    Timer.periodic(Duration(seconds: 20), (timer) {
      //doflip();
    });
  }

  get loading => SpinKitCubeGrid(
        color: Colors.blue,
        size: 30,
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Visibility(
        visible: is_service_loaded,
        replacement: Center(
          child: loading,
        ),
        child: Column(
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                height: 585.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 100),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                onPageChanged: (index, reason) {
                  t++;
                  if (t == serviceList.length) {
                    flipPage();
                  }
                },
              ),
              items: serviceList.map((i) {
                /***
                     * 
                     * Last slider logic
                     */

                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        // ignore: prefer_const_constructors
                        margin: EdgeInsets.symmetric(
                            vertical: 1.0, horizontal: 2.0),
                        child: Card(
                          elevation: 2,
                          child: ClipPath(
                            child: Container(
                              height: 100,
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color:
                                              Color.fromARGB(255, 30, 110, 231),
                                          width: 5))),
                              child: Container(
                                child: Column(
                                  children: [
                                    ColoredBox(
                                      color: Color.fromARGB(255, 30, 110, 231),
                                      child: SizedBox(
                                        height: 30,
                                        width: double.infinity,
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            i.title,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(children: <Widget>[
                                      Expanded(
                                          child: Divider(
                                        color:
                                            Color.fromARGB(255, 30, 110, 231),
                                      )),
                                      Text(
                                        'सम्बन्धित कार्यालय',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 30, 110, 231)),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Icon(
                                        Icons.home_outlined,
                                        size: 15,
                                        color:
                                            Color.fromARGB(255, 30, 110, 231),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Expanded(
                                          child: Divider(
                                        color:
                                            Color.fromARGB(255, 30, 110, 231),
                                      )),
                                    ]),
                                    Html(data: i.resoffice),
                                    Row(children: <Widget>[
                                      Expanded(
                                          child: Divider(
                                        color:
                                            Color.fromARGB(255, 30, 110, 231),
                                      )),
                                      Text(
                                        'सम्बन्धित कर्मचारी',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 30, 110, 231)),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Icon(
                                        FontAwesomeIcons.userCheck,
                                        size: 15,
                                        color:
                                            Color.fromARGB(255, 30, 110, 231),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Expanded(
                                          child: Divider(
                                        color:
                                            Color.fromARGB(255, 30, 110, 231),
                                      )),
                                    ]),
                                    Html(data: i.resofficer),
                                    Row(children: <Widget>[
                                      Expanded(
                                          child: Divider(
                                        color:
                                            Color.fromARGB(255, 30, 110, 231),
                                      )),
                                      Text(
                                        'आवश्यक कागजात',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 30, 110, 231)),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Icon(
                                        FontAwesomeIcons.file,
                                        size: 15,
                                        color:
                                            Color.fromARGB(255, 30, 110, 231),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Expanded(
                                          child: Divider(
                                        color:
                                            Color.fromARGB(255, 30, 110, 231),
                                      )),
                                    ]),
                                    Html(data: i.requireddocs),
                                    Row(children: <Widget>[
                                      Expanded(
                                          child: Divider(
                                        color:
                                            Color.fromARGB(255, 30, 110, 231),
                                      )),
                                      Text('प्रक्रिया'),
                                      Expanded(
                                          child: Divider(
                                        color:
                                            Color.fromARGB(255, 30, 110, 231),
                                      )),
                                    ]),
                                    Row(
                                      children: [Html(data: i.process)],
                                    ),
                                    Row(children: <Widget>[
                                      Expanded(
                                          child: Divider(
                                        color:
                                            Color.fromARGB(255, 30, 110, 231),
                                      )),
                                      Text(
                                        'लाग्ने समय',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 30, 110, 231)),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Icon(
                                        FontAwesomeIcons.clock,
                                        size: 15,
                                        color:
                                            Color.fromARGB(255, 30, 110, 231),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Expanded(
                                          child: Divider(
                                        color:
                                            Color.fromARGB(255, 30, 110, 231),
                                      )),
                                    ]),
                                    Html(data: i.time),
                                    Row(children: <Widget>[
                                      Expanded(
                                          child: Divider(
                                        color:
                                            Color.fromARGB(255, 30, 110, 231),
                                      )),
                                      Text(
                                        'लाग्ने शुल्क',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 30, 110, 231)),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Icon(
                                        FontAwesomeIcons.coins,
                                        size: 15,
                                        color:
                                            Color.fromARGB(255, 30, 110, 231),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Expanded(
                                          child: Divider(
                                        color:
                                            Color.fromARGB(255, 30, 110, 231),
                                      )),
                                    ]),
                                    Html(data: i.servicecharge)
                                  ],
                                ),
                              ),
                            ),
                            clipper: ShapeBorderClipper(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3))),
                          ),
                        ));
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  flipPage() {
    HomeScreen.of(context)?.setState(() {
      HomeScreen.of(context)?.table_done = true;
      print(HomeScreen.of(context)?.table_done);
    });
  }

  getServices() async {
    serviceList = (await FetchServices().fetchServices())!;
    if (serviceList != null) {
      setState(() {
        is_service_loaded = true;
      });
    }
  }
}
