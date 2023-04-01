import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/staffs.dart';
import '../worker/fetchstaffs.dart';

class StaffSlider extends StatefulWidget {
  const StaffSlider({super.key});

  @override
  State<StaffSlider> createState() => _StaffSliderState();
}

class _StaffSliderState extends State<StaffSlider> {
  List<Staff> staff = [];
  var isStaffLoaded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStaffs();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isStaffLoaded,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(3),
          child: Container(
            child: Column(
              children: [
                Text('कर्मचारी'),
                SizedBox(height: 2),
                CarouselSlider(
                  options: CarouselOptions(
                    height: 235.0,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 60),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                  ),
                  items: staff.map((i) {
                    /***
                     * 
                     * Last slider logic
                     */
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          // ignore: prefer_const_constructors
                          margin: EdgeInsets.symmetric(
                              vertical: 1.0, horizontal: 2.0),
                          child: Card(
                            margin: const EdgeInsets.all(2),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: 45,
                                  backgroundColor: Colors.deepOrangeAccent,
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: stripUrl(staff.indexOf(i)),
                                      fit: BoxFit.cover,
                                      width: 80,
                                      height: 80,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 140,
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.user,
                                          size: 15,
                                          color: Colors.blueGrey,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(i.title)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 7,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.caretRight,
                                          size: 20,
                                          color: Colors.blueGrey,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Flexible(
                                          child: Text(
                                            "${i.designation}, ${i.dept ?? '-'}",
                                            overflow: TextOverflow.visible,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.building,
                                          size: 15,
                                          color: Colors.blueGrey,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(i.office)
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.phone,
                                          size: 15,
                                          color: Colors.blueGrey,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(i.phone!)
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(
                                          FontAwesomeIcons.envelope,
                                          size: 15,
                                          color: Colors.blueGrey,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(i.email!)
                                      ],
                                    )
                                  ]),
                                ),
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

  getStaffs() async {
    staff = (await FetchStaffs().getStaffs())!;
    if (staff != null) {
      setState(() {
        isStaffLoaded = true;
      });
    }
  }

  stripUrl(i) {
    RegExp exp =
        new RegExp(r'(?:(?:https?|ftp):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
    var url = exp.firstMatch(staff[i].image);
    var txt = url?.group(0);
    if (txt == null) {
      txt =
          'https://lekbeshimun.gov.np/sites/lekbeshimun.gov.np/files/default.png';
    }
    return txt;
  }

  stripText(i) {
    const start = '">';
    const end = '</a>';
    var str = i;

    final startIndex = str.indexOf(start);
    final endIndex = str.indexOf(end);
    final result = str.substring(startIndex + start.length, endIndex).trim();
    return result;
  }
}
