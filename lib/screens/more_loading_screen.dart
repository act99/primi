import 'dart:async';
import 'package:primi/admob/admob_manager.dart';
import 'package:primi/screens/more_result_screen.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:primi/screens/two_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

class MoreLoadingScreen extends StatefulWidget {
  final List<File> fileImageArray;
  final List<List> outputsList;
  final bool gender;
  MoreLoadingScreen({this.gender, this.fileImageArray, this.outputsList});
  @override
  _MoreLoadingScreenState createState() => _MoreLoadingScreenState();
}

class _MoreLoadingScreenState extends State<MoreLoadingScreen> {
  AdmobManager adMob = AdmobManager();

  startTimer() async {
    var duration = Duration(milliseconds: 800 * widget.fileImageArray.length);
    return Timer(duration, route);
  }

  @override
  void initState() {
    super.initState();
    adMob.init();
    adMob.showBannerAd();

    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  route() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MoreResultScreen(
          adMob: adMob,
          fileImageArray: widget.fileImageArray,
          outputsList: widget.outputsList,
          gender: widget.gender,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: widget.gender ? Color(0xfffde8ef) : Color(0xffeef2f3),
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: height * 0.15,
                ),
                widget.gender
                    ? Image.asset(
                        'assets/loading_woman.gif',
                        width: width * 0.6,
                        height: width * 0.6,
                      )
                    : Image.asset(
                        'assets/loading_man.gif',
                        width: width * 0.6,
                        height: width * 0.6,
                      ),
                Text(
                  '사진 분석 중 입니다.',
                  style: GoogleFonts.jua(
                    textStyle: TextStyle(
                      fontSize: width * 0.056,
                      color: widget.gender
                          ? Colors.pink.withOpacity(0.3)
                          : Colors.blueGrey.withOpacity(0.7),
                    ),
                  ),
                ),
                Text(
                  '잠시만 기다려주세요.',
                  style: GoogleFonts.jua(
                    textStyle: TextStyle(
                      fontSize: width * 0.056,
                      color: widget.gender
                          ? Colors.pink.withOpacity(0.3)
                          : Colors.blueGrey.withOpacity(0.7),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.1,
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: new LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 50,
                    animation: true,
                    lineHeight: width * 0.06,
                    animationDuration: 800 * widget.fileImageArray.length,
                    percent: 1,
                    center: Text(
                      '로딩중...',
                      style: GoogleFonts.jua(
                        textStyle: TextStyle(
                          fontSize: width * 0.048,
                          color: widget.gender
                              ? Colors.pink.withOpacity(0.3)
                              : Colors.blueGrey.withOpacity(0.7),
                        ),
                      ),
                    ),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor:
                        widget.gender ? Colors.pink[100] : Colors.blueGrey[100],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
