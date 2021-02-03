import 'dart:async';
import 'package:primi/admob/admob_manager.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:primi/screens/two_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:io';

class TwoLoadingScreen extends StatefulWidget {
  final bool gender;
  final File imageFile1;
  final File imageFile2;
  final List output1;
  final List output2;
  final bool loading1;
  final bool loading2;
  TwoLoadingScreen(
      {this.gender,
      this.imageFile1,
      this.imageFile2,
      this.output1,
      this.output2,
      this.loading1,
      this.loading2});
  @override
  _TwoLoadingScreenState createState() => _TwoLoadingScreenState();
}

class _TwoLoadingScreenState extends State<TwoLoadingScreen> {
  AdmobManager adMob = AdmobManager();

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

  startTimer() async {
    var duration = Duration(seconds: 4);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => TwoResultScreen(
                  gender: widget.gender,
                  imageFile1: widget.imageFile1,
                  imageFile2: widget.imageFile2,
                  output1: widget.output1,
                  output2: widget.output2,
                  loading1: widget.loading1,
                  loading2: widget.loading2,
                  adMob: adMob,
                )));
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
                    animationDuration: 4000,
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
