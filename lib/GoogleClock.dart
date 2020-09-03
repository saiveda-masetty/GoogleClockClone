import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart';


class GoogleClock extends StatefulWidget {
  @override
  _GoogleClockState createState() => _GoogleClockState();
}

class _GoogleClockState extends State<GoogleClock> {
  getTime(String country, continent) async {
    Response response =
    await get('http://worldtimeapi.org/api/timezone/$continent/$country');
    Map data = jsonDecode(response.body);
    String dateTime = data['datetime'];
    String offset = data['utc_offset'].substring(1, 3);
    DateTime time = DateTime.parse(dateTime);
    time = time.add(Duration(hours: int.parse(offset)));
    final timeStr = DateFormat('hh : mm a').format(time);
    return timeStr.substring(0, 10);
  }

  Timer timer;

  @override
  void initState() {
    super.initState();
    setState(() {
      Timer(
        Duration(seconds: 1) - Duration(milliseconds: _localDateTime.second),
        _updateTime,
      );
    });
  }

  DateTime _localDateTime = DateTime.now();

  void _updateTime() {
    setState(() {
      _localDateTime = DateTime.now();

      Timer(
        Duration(seconds: 1) - Duration(milliseconds: _localDateTime.second),
        _updateTime,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final localTime = DateFormat('hh : mm a').format(_localDateTime);
    final localDayDate = DateFormat('EE, d MMM').format(_localDateTime);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF202125),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color(0xFF202125),
          title: Text(
            'Clock',
            style: TextStyle(color: Colors.grey[300]),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_vert,
                color: Colors.grey[300],
              ),
            )
          ],
        ),
        body: Center(
          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${localTime.substring(1, 7)}",
                          style: TextStyle(
                            fontSize: 48,
//                      fontFamily: 'Kumbh_sans-Bold',
                            color: Color(0xFF89b2f4),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            "${localTime.substring(7, 10).toLowerCase()}",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xFF89b2f4),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$localDayDate',
                          style:
                          TextStyle(color: Colors.grey[300], fontSize: 22),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Divider(
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Sydney',
                              style: TextStyle(
                                  color: Colors.grey[300], fontSize: 22),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '4 hr 30 min ahead',
                              style: TextStyle(color: Colors.grey[500]),
                            )
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: FutureBuilder(
                        future: getTime('Sydney', 'Australia'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              "${snapshot.data}",
                              style: TextStyle(
                                  color: Colors.grey[200], fontSize: 32),
                            );
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error);
                          } else {
                            return Text(
                              'Loading',
                              style: TextStyle(color: Colors.white),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Dubai',
                              style: TextStyle(
                                  color: Colors.grey[300], fontSize: 22),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '1 hr 30 min behind',
                              style: TextStyle(color: Colors.grey[500]),
                            )
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: FutureBuilder(
                        future: getTime('Dubai', 'Asia'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              "${snapshot.data}",
                              style: TextStyle(
                                  color: Colors.grey[200], fontSize: 32),
                            );
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error);
                          } else {
                            return Text(
                              'Loading',
                              style: TextStyle(color: Colors.white),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Singapore',
                              style: TextStyle(
                                  color: Colors.grey[300], fontSize: 22),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '2 hr 30 min ahead',
                              style: TextStyle(color: Colors.grey[500]),
                            )
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: FutureBuilder(
                        future: getTime('Singapore', 'Asia'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              "${snapshot.data}",
                              style: TextStyle(
                                  color: Colors.grey[200], fontSize: 32),
                            );
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error);
                          } else {
                            return Text(
                              'Loading',
                              style: TextStyle(color: Colors.white),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Moscow',
                              style: TextStyle(
                                  color: Colors.grey[300], fontSize: 22),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '4 hr 30 min ahead',
                              style: TextStyle(color: Colors.grey[500]),
                            )
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: FutureBuilder(
                        future: getTime('Moscow', 'Europe'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              "${snapshot.data}",
                              style: TextStyle(
                                  color: Colors.grey[200], fontSize: 32),
                            );
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error);
                          } else {
                            return Text(
                              'Loading',
                              style: TextStyle(color: Colors.white),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bangkok',
                              style: TextStyle(
                                  color: Colors.grey[300], fontSize: 22),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '1 hr 30 min ahead',
                              style: TextStyle(color: Colors.grey[500]),
                            )
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: FutureBuilder(
                        future: getTime('Bangkok', 'Asia'),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Text(
                              "${snapshot.data}",
                              style: TextStyle(
                                  color: Colors.grey[200], fontSize: 32),
                            );
                          } else if (snapshot.hasError) {
                            return Text(snapshot.error);
                          } else {
                            return Text(
                              'Loading',
                              style: TextStyle(color: Colors.white),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

