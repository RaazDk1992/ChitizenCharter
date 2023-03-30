// ignore_for_file: avoid_unnecessary_containers

import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:noticeboard/screens/Slider.dart';

import 'package:noticeboard/screens/calendar.dart';
import 'package:noticeboard/screens/electedslider.dart';
import 'package:noticeboard/screens/staffslider.dart';

import 'package:nepali_utils/nepali_utils.dart';
import 'package:noticeboard/screens/table.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static _HomeScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<_HomeScreenState>();

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _text = '\n';
  bool table_done = false;
  bool carousel_done = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset("assets/images/new_logo.png", width: 70, height: 70),
              RichText(
                text: TextSpan(children: [
                  const TextSpan(
                      text: 'लेकवेशी नगरपालिका, नगर कार्यपालिकाको कार्यालय\n'),
                  TextSpan(
                      text: '\t\t\t\t\t\t\t\t कल्याण, सुर्खेत',
                      style: TextStyle(color: Colors.white))
                ]),
              ),
            ],
          ),
        )),
        body: SafeArea(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables

          children: <Widget>[
            if (table_done == false)
              Expanded(flex: 7, child: const CustomTable())
            else
              Expanded(flex: 7, child: CarouselSliderScreen()),
            Expanded(
                flex: 3,
                child: Column(
                  children: [
                    const ElectedSlider(),
                    const StaffSlider(),
                    //CustomCalendar(),
                    Card(
                      elevation: 4,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ClipPath(
                        clipper: ShapeBorderClipper(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Container(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 20, left: 30, right: 70),
                          decoration: const BoxDecoration(
                            border: Border(
                              left: BorderSide(color: Colors.amber, width: 8),
                            ),
                          ),
                          child: Text(
                            'तयार र ब्यवस्थापन गर्ने: सूचना प्रविधि शाखा @ २०७९,\n ' +
                                _text!,
                            style:
                                TextStyle(fontSize: 15, color: dynamicColrs()),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        )));
  }

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _text = getDateTime();
      });
    });
  }

  getDateTime() {
    var currentTime = NepaliDateTime.now();
    var date2 = NepaliDateFormat("EEE, MMMM d, ''yyyy GGG hh:mm a");
    var a = date2.format(currentTime);

    return a;
  }

  Color dynamicColrs() {
    return Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
        .withOpacity(1.0);
  }

  updateViews(bool x, bool y) {
    setState(() {
      table_done = x;
      carousel_done = y;
    });
  }
}
