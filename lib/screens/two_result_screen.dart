import 'dart:io';
import 'package:primi/admob/admob_manager.dart';
import 'package:primi/main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TwoResultScreen extends StatefulWidget {
  final AdmobManager adMob;
  final bool gender;
  final File imageFile1;
  final File imageFile2;
  final List output1;
  final List output2;
  final bool loading1;
  final bool loading2;
  TwoResultScreen(
      {this.gender,
      this.adMob,
      this.imageFile1,
      this.imageFile2,
      this.output1,
      this.output2,
      this.loading1,
      this.loading2});
  @override
  _TwoResultScreenState createState() => _TwoResultScreenState();
}

class _TwoResultScreenState extends State<TwoResultScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.adMob?.disposeBannerAd();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
        body: widget.output1 != null &&
                widget.output1.isNotEmpty &&
                widget.output2 != null &&
                widget.output2.isNotEmpty
            ? Container(
                decoration: BoxDecoration(
                  color: widget.gender
                      ? Colors.pink.withOpacity(0.1)
                      : Colors.blueGrey.withOpacity(0.3),
                ),
                child: SafeArea(
                  child: Center(
                      child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: widget.gender
                              ? Colors.pink.withOpacity(0.1)
                              : Colors.blueGrey.withOpacity(0.2),
                        ),
                        width: width * 1,
                        height: height * 0.08,
                        child: Align(
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              Spacer(),
                              Text(
                                '결과보기!',
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
                                width: width * 0.1,
                              ),
                              Container(
                                width: width * 0.3,
                                child: FlatButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MyApp()));
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.home,
                                        color: widget.gender
                                            ? Colors.pink.withOpacity(0.4)
                                            : Colors.blueGrey.withOpacity(0.7),
                                      ),
                                      Text(
                                        ' 홈으로 >',
                                        style: GoogleFonts.jua(
                                            color: widget.gender
                                                ? Colors.pink.withOpacity(0.4)
                                                : Colors.blueGrey
                                                    .withOpacity(0.7),
                                            fontSize: width * 0.036),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      _calculation(context, widget.output1, widget.output2,
                          widget.imageFile1, widget.imageFile2, widget.gender),
                    ],
                  )),
                ),
              )
            : Container(
                width: 30,
                height: 30,
                child: Center(
                    child: Column(
                  children: [
                    CircularProgressIndicator(),
                    Container(
                      width: width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: widget.gender
                            ? Colors.pink.withOpacity(0.4)
                            : Colors.blueGrey.withOpacity(0.7),
                      ),
                      child: FlatButton(
                        onPressed: () {
                          // loading1 = false;
                          // loading2 = false;

                          // widget.output1 = null;
                          // widget.output2 = null;
                          // widget.imageFile1 = null;
                          // widget.imageFile2 = null;
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) => MyApp()));
                        },
                        child: Text(
                          '홈으로',
                          style: GoogleFonts.jua(
                              color: Colors.white, fontSize: width * 0.06),
                        ),
                      ),
                    ),
                  ],
                ))));
  }
}

Widget _calculation(BuildContext context, List output1, List output2,
    File image1, File image2, bool gender) {
  Size screenSize = MediaQuery.of(context).size;
  double width = screenSize.width;
  double height = screenSize.height;
  double outputResult1;
  double outputResult2;
  if (output1.length == 1) {
    var a = output1[0]['confidence'] * 100;
    var ai = output1[0]['index'];
    var sum1 = a;
    var sumAveragea = a + a / sum1 * (100 - sum1);
    var result1 = sumAveragea * (9 - ai);
    outputResult1 = result1;
  }
  if (output1.length == 2) {
    var a = output1[0]['confidence'] * 100;
    var b = output1[1]['confidence'] * 100;
    var ai = output1[0]['index'];
    var bi = output1[1]['index'];
    var sum1 = a + b;
    var sumAveragea = a + a / sum1 * (100 - sum1);
    var sumAverageb = b + b / sum1 * (100 - sum1);
    var result1 = sumAveragea * (9 - ai) + sumAverageb * (9 - bi);
    outputResult1 = result1;
  }
  if (output1.length == 3) {
    var a = output1[0]['confidence'] * 100;
    var b = output1[1]['confidence'] * 100;
    var c = output1[2]['confidence'] * 100;

    var ai = output1[0]['index'];
    var bi = output1[1]['index'];
    var ci = output1[2]['index'];

    var sum1 = a + b + c;
    var sumAveragea = a + a / sum1 * (100 - sum1);
    var sumAverageb = b + b / sum1 * (100 - sum1);
    var sumAveragec = c + c / sum1 * (100 - sum1);

    var result1 = sumAveragea * (9 - ai) +
        sumAverageb * (9 - bi) +
        sumAveragec * (9 - ci);
    outputResult1 = result1;
  }
  if (output1.length == 4) {
    var a = output1[0]['confidence'] * 100;
    var b = output1[1]['confidence'] * 100;
    var c = output1[2]['confidence'] * 100;
    var d = output1[3]['confidence'] * 100;

    var ai = output1[0]['index'];
    var bi = output1[1]['index'];
    var ci = output1[2]['index'];
    var di = output1[3]['index'];

    var sum1 = a + b + c + d;
    var sumAveragea = a + a / sum1 * (100 - sum1);
    var sumAverageb = b + b / sum1 * (100 - sum1);
    var sumAveragec = c + c / sum1 * (100 - sum1);
    var sumAveraged = d + d / sum1 * (100 - sum1);

    var result1 = sumAveragea * (9 - ai) +
        sumAverageb * (9 - bi) +
        sumAveragec * (9 - ci) +
        sumAveraged * (9 - di);

    outputResult1 = result1;
  }
  if (output1.length == 5) {
    var a = output1[0]['confidence'] * 100;
    var b = output1[1]['confidence'] * 100;
    var c = output1[2]['confidence'] * 100;
    var d = output1[3]['confidence'] * 100;
    var e = output1[4]['confidence'] * 100;

    var ai = output1[0]['index'];
    var bi = output1[1]['index'];
    var ci = output1[2]['index'];
    var di = output1[3]['index'];
    var ei = output1[4]['index'];

    var sum1 = a + b + c + d + e;
    var sumAveragea = a + a / sum1 * (100 - sum1);
    var sumAverageb = b + b / sum1 * (100 - sum1);
    var sumAveragec = c + c / sum1 * (100 - sum1);
    var sumAveraged = d + d / sum1 * (100 - sum1);
    var sumAveragee = e + e / sum1 * (100 - sum1);

    var result1 = sumAveragea * (9 - ai) +
        sumAverageb * (9 - bi) +
        sumAveragec * (9 - ci) +
        sumAveraged * (9 - di) +
        sumAveragee * (9 - ei);

    outputResult1 = result1;
  }
  if (output1.length == 6) {
    var a = output1[0]['confidence'] * 100;
    var b = output1[1]['confidence'] * 100;
    var c = output1[2]['confidence'] * 100;
    var d = output1[3]['confidence'] * 100;
    var e = output1[4]['confidence'] * 100;
    var f = output1[5]['confidence'] * 100;

    var ai = output1[0]['index'];
    var bi = output1[1]['index'];
    var ci = output1[2]['index'];
    var di = output1[3]['index'];
    var ei = output1[4]['index'];
    var fi = output1[5]['index'];

    var sum1 = a + b + c + d + e + f;
    var sumAveragea = a + a / sum1 * (100 - sum1);
    var sumAverageb = b + b / sum1 * (100 - sum1);
    var sumAveragec = c + c / sum1 * (100 - sum1);
    var sumAveraged = d + d / sum1 * (100 - sum1);
    var sumAveragee = e + e / sum1 * (100 - sum1);
    var sumAveragef = f + f / sum1 * (100 - sum1);

    var result1 = sumAveragea * (9 - ai) +
        sumAverageb * (9 - bi) +
        sumAveragec * (9 - ci) +
        sumAveraged * (9 - di) +
        sumAveragee * (9 - ei) +
        sumAveragef * (9 - fi);

    outputResult1 = result1;
  }
  if (output1.length == 7) {
    var a = output1[0]['confidence'] * 100;
    var b = output1[1]['confidence'] * 100;
    var c = output1[2]['confidence'] * 100;
    var d = output1[3]['confidence'] * 100;
    var e = output1[4]['confidence'] * 100;
    var f = output1[5]['confidence'] * 100;
    var g = output1[6]['confidence'] * 100;

    var ai = output1[0]['index'];
    var bi = output1[1]['index'];
    var ci = output1[2]['index'];
    var di = output1[3]['index'];
    var ei = output1[4]['index'];
    var fi = output1[5]['index'];
    var gi = output1[6]['index'];

    var sum1 = a + b + c + d + e + f + g;
    var sumAveragea = a + a / sum1 * (100 - sum1);
    var sumAverageb = b + b / sum1 * (100 - sum1);
    var sumAveragec = c + c / sum1 * (100 - sum1);
    var sumAveraged = d + d / sum1 * (100 - sum1);
    var sumAveragee = e + e / sum1 * (100 - sum1);
    var sumAveragef = f + f / sum1 * (100 - sum1);
    var sumAverageg = f + f / sum1 * (100 - sum1);

    var result1 = sumAveragea * (9 - ai) +
        sumAverageb * (9 - bi) +
        sumAveragec * (9 - ci) +
        sumAveraged * (9 - di) +
        sumAveragee * (9 - ei) +
        sumAveragef * (9 - fi) +
        sumAverageg * (9 - gi);

    outputResult1 = result1;
  }
  if (output1.length == 8) {
    var a = output1[0]['confidence'] * 100;
    var b = output1[1]['confidence'] * 100;
    var c = output1[2]['confidence'] * 100;
    var d = output1[3]['confidence'] * 100;
    var e = output1[4]['confidence'] * 100;
    var f = output1[5]['confidence'] * 100;
    var g = output1[6]['confidence'] * 100;
    var h = output1[7]['confidence'] * 100;

    var ai = output1[0]['index'];
    var bi = output1[1]['index'];
    var ci = output1[2]['index'];
    var di = output1[3]['index'];
    var ei = output1[4]['index'];
    var fi = output1[5]['index'];
    var gi = output1[6]['index'];
    var hi = output1[7]['index'];

    var sum1 = a + b + c + d + e + f + g + h;
    var sumAveragea = a + a / sum1 * (100 - sum1);
    var sumAverageb = b + b / sum1 * (100 - sum1);
    var sumAveragec = c + c / sum1 * (100 - sum1);
    var sumAveraged = d + d / sum1 * (100 - sum1);
    var sumAveragee = e + e / sum1 * (100 - sum1);
    var sumAveragef = f + f / sum1 * (100 - sum1);
    var sumAverageg = g + g / sum1 * (100 - sum1);
    var sumAverageh = h + h / sum1 * (100 - sum1);

    var result1 = sumAveragea * (9 - ai) +
        sumAverageb * (9 - bi) +
        sumAveragec * (9 - ci) +
        sumAveraged * (9 - di) +
        sumAveragee * (9 - ei) +
        sumAveragef * (9 - fi) +
        sumAverageg * (9 - gi) +
        sumAverageh * (9 - hi);

    outputResult1 = result1;
  }
  if (output1.length == 9) {
    var a = output1[0]['confidence'] * 100;
    var b = output1[1]['confidence'] * 100;
    var c = output1[2]['confidence'] * 100;
    var d = output1[3]['confidence'] * 100;
    var e = output1[4]['confidence'] * 100;
    var f = output1[5]['confidence'] * 100;
    var g = output1[6]['confidence'] * 100;
    var h = output1[7]['confidence'] * 100;
    var i = output1[8]['confidence'] * 100;

    var ai = output1[0]['index'];
    var bi = output1[1]['index'];
    var ci = output1[2]['index'];
    var di = output1[3]['index'];
    var ei = output1[4]['index'];
    var fi = output1[5]['index'];
    var gi = output1[6]['index'];
    var hi = output1[7]['index'];
    var ii = output1[8]['index'];

    var sum1 = a + b + c + d + e + f + g + h;
    var sumAveragea = a + a / sum1 * (100 - sum1);
    var sumAverageb = b + b / sum1 * (100 - sum1);
    var sumAveragec = c + c / sum1 * (100 - sum1);
    var sumAveraged = d + d / sum1 * (100 - sum1);
    var sumAveragee = e + e / sum1 * (100 - sum1);
    var sumAveragef = f + f / sum1 * (100 - sum1);
    var sumAverageg = g + g / sum1 * (100 - sum1);
    var sumAverageh = h + h / sum1 * (100 - sum1);
    var sumAveragei = i + i / sum1 * (100 - sum1);

    var result1 = sumAveragea * (9 - ai) +
        sumAverageb * (9 - bi) +
        sumAveragec * (9 - ci) +
        sumAveraged * (9 - di) +
        sumAveragee * (9 - ei) +
        sumAveragef * (9 - fi) +
        sumAverageg * (9 - gi) +
        sumAverageh * (9 - hi) +
        sumAveragei * (9 - ii);

    outputResult1 = result1;
  }
  if (output2.length == 1) {
    var a = output2[0]['confidence'] * 100;
    var ai = output2[0]['index'];
    var sum1 = a;
    var sumAveragea = a + a / sum1 * (100 - sum1);
    var result1 = sumAveragea * (9 - ai);
    outputResult2 = result1;
  }
  if (output2.length == 2) {
    var a = output2[0]['confidence'] * 100;
    var b = output2[1]['confidence'] * 100;
    var ai = output2[0]['index'];
    var bi = output2[1]['index'];
    var sum1 = a + b;
    var sumAveragea = a + a / sum1 * (100 - sum1);
    var sumAverageb = b + b / sum1 * (100 - sum1);
    var result1 = sumAveragea * (9 - ai) + sumAverageb * (9 - bi);
    outputResult2 = result1;
  }
  if (output2.length == 3) {
    var a = output2[0]['confidence'] * 100;
    var b = output2[1]['confidence'] * 100;
    var c = output2[2]['confidence'] * 100;

    var ai = output2[0]['index'];
    var bi = output2[1]['index'];
    var ci = output2[2]['index'];

    var sum1 = a + b + c;
    var sumAveragea = a + a / sum1 * (100 - sum1);
    var sumAverageb = b + b / sum1 * (100 - sum1);
    var sumAveragec = c + c / sum1 * (100 - sum1);

    var result1 = sumAveragea * (9 - ai) +
        sumAverageb * (9 - bi) +
        sumAveragec * (9 - ci);
    outputResult2 = result1;
  }
  if (output2.length == 4) {
    var a = output2[0]['confidence'] * 100;
    var b = output2[1]['confidence'] * 100;
    var c = output2[2]['confidence'] * 100;
    var d = output2[3]['confidence'] * 100;

    var ai = output2[0]['index'];
    var bi = output2[1]['index'];
    var ci = output2[2]['index'];
    var di = output2[3]['index'];

    var sum1 = a + b + c + d;
    var sumAveragea = a + a / sum1 * (100 - sum1);
    var sumAverageb = b + b / sum1 * (100 - sum1);
    var sumAveragec = c + c / sum1 * (100 - sum1);
    var sumAveraged = d + d / sum1 * (100 - sum1);

    var result1 = sumAveragea * (9 - ai) +
        sumAverageb * (9 - bi) +
        sumAveragec * (9 - ci) +
        sumAveraged * (9 - di);

    outputResult2 = result1;
  }
  if (output2.length == 5) {
    var a = output2[0]['confidence'] * 100;
    var b = output2[1]['confidence'] * 100;
    var c = output2[2]['confidence'] * 100;
    var d = output2[3]['confidence'] * 100;
    var e = output2[4]['confidence'] * 100;

    var ai = output2[0]['index'];
    var bi = output2[1]['index'];
    var ci = output2[2]['index'];
    var di = output2[3]['index'];
    var ei = output2[4]['index'];

    var sum1 = a + b + c + d + e;
    var sumAveragea = a + a / sum1 * (100 - sum1);
    var sumAverageb = b + b / sum1 * (100 - sum1);
    var sumAveragec = c + c / sum1 * (100 - sum1);
    var sumAveraged = d + d / sum1 * (100 - sum1);
    var sumAveragee = e + e / sum1 * (100 - sum1);

    var result1 = sumAveragea * (9 - ai) +
        sumAverageb * (9 - bi) +
        sumAveragec * (9 - ci) +
        sumAveraged * (9 - di) +
        sumAveragee * (9 - ei);

    outputResult2 = result1;
  }
  if (output2.length == 6) {
    var a = output2[0]['confidence'] * 100;
    var b = output2[1]['confidence'] * 100;
    var c = output2[2]['confidence'] * 100;
    var d = output2[3]['confidence'] * 100;
    var e = output2[4]['confidence'] * 100;
    var f = output2[5]['confidence'] * 100;

    var ai = output2[0]['index'];
    var bi = output2[1]['index'];
    var ci = output2[2]['index'];
    var di = output2[3]['index'];
    var ei = output2[4]['index'];
    var fi = output2[5]['index'];

    var sum1 = a + b + c + d + e + f;
    var sumAveragea = a + a / sum1 * (100 - sum1);
    var sumAverageb = b + b / sum1 * (100 - sum1);
    var sumAveragec = c + c / sum1 * (100 - sum1);
    var sumAveraged = d + d / sum1 * (100 - sum1);
    var sumAveragee = e + e / sum1 * (100 - sum1);
    var sumAveragef = f + f / sum1 * (100 - sum1);

    var result1 = sumAveragea * (9 - ai) +
        sumAverageb * (9 - bi) +
        sumAveragec * (9 - ci) +
        sumAveraged * (9 - di) +
        sumAveragee * (9 - ei) +
        sumAveragef * (9 - fi);

    outputResult2 = result1;
  }
  if (output2.length == 7) {
    var a = output2[0]['confidence'] * 100;
    var b = output2[1]['confidence'] * 100;
    var c = output2[2]['confidence'] * 100;
    var d = output2[3]['confidence'] * 100;
    var e = output2[4]['confidence'] * 100;
    var f = output2[5]['confidence'] * 100;
    var g = output2[6]['confidence'] * 100;

    var ai = output2[0]['index'];
    var bi = output2[1]['index'];
    var ci = output2[2]['index'];
    var di = output2[3]['index'];
    var ei = output2[4]['index'];
    var fi = output2[5]['index'];
    var gi = output2[6]['index'];

    var sum1 = a + b + c + d + e + f + g;
    var sumAveragea = a + a / sum1 * (100 - sum1);
    var sumAverageb = b + b / sum1 * (100 - sum1);
    var sumAveragec = c + c / sum1 * (100 - sum1);
    var sumAveraged = d + d / sum1 * (100 - sum1);
    var sumAveragee = e + e / sum1 * (100 - sum1);
    var sumAveragef = f + f / sum1 * (100 - sum1);
    var sumAverageg = f + f / sum1 * (100 - sum1);

    var result1 = sumAveragea * (9 - ai) +
        sumAverageb * (9 - bi) +
        sumAveragec * (9 - ci) +
        sumAveraged * (9 - di) +
        sumAveragee * (9 - ei) +
        sumAveragef * (9 - fi) +
        sumAverageg * (9 - gi);

    outputResult2 = result1;
  }
  if (output2.length == 8) {
    var a = output2[0]['confidence'] * 100;
    var b = output2[1]['confidence'] * 100;
    var c = output2[2]['confidence'] * 100;
    var d = output2[3]['confidence'] * 100;
    var e = output2[4]['confidence'] * 100;
    var f = output2[5]['confidence'] * 100;
    var g = output2[6]['confidence'] * 100;
    var h = output2[7]['confidence'] * 100;

    var ai = output2[0]['index'];
    var bi = output2[1]['index'];
    var ci = output2[2]['index'];
    var di = output2[3]['index'];
    var ei = output2[4]['index'];
    var fi = output2[5]['index'];
    var gi = output2[6]['index'];
    var hi = output2[7]['index'];

    var sum1 = a + b + c + d + e + f + g + h;
    var sumAveragea = a + a / sum1 * (100 - sum1);
    var sumAverageb = b + b / sum1 * (100 - sum1);
    var sumAveragec = c + c / sum1 * (100 - sum1);
    var sumAveraged = d + d / sum1 * (100 - sum1);
    var sumAveragee = e + e / sum1 * (100 - sum1);
    var sumAveragef = f + f / sum1 * (100 - sum1);
    var sumAverageg = g + g / sum1 * (100 - sum1);
    var sumAverageh = h + h / sum1 * (100 - sum1);

    var result1 = sumAveragea * (9 - ai) +
        sumAverageb * (9 - bi) +
        sumAveragec * (9 - ci) +
        sumAveraged * (9 - di) +
        sumAveragee * (9 - ei) +
        sumAveragef * (9 - fi) +
        sumAverageg * (9 - gi) +
        sumAverageh * (9 - hi);

    outputResult2 = result1;
  }
  if (output2.length == 9) {
    var a = output2[0]['confidence'] * 100;
    var b = output2[1]['confidence'] * 100;
    var c = output2[2]['confidence'] * 100;
    var d = output2[3]['confidence'] * 100;
    var e = output2[4]['confidence'] * 100;
    var f = output2[5]['confidence'] * 100;
    var g = output2[6]['confidence'] * 100;
    var h = output2[7]['confidence'] * 100;
    var i = output2[8]['confidence'] * 100;

    var ai = output2[0]['index'];
    var bi = output2[1]['index'];
    var ci = output2[2]['index'];
    var di = output2[3]['index'];
    var ei = output2[4]['index'];
    var fi = output2[5]['index'];
    var gi = output2[6]['index'];
    var hi = output2[7]['index'];
    var ii = output2[8]['index'];

    var sum1 = a + b + c + d + e + f + g + h + i;
    var sumAveragea = a + a / sum1 * (100 - sum1);
    var sumAverageb = b + b / sum1 * (100 - sum1);
    var sumAveragec = c + c / sum1 * (100 - sum1);
    var sumAveraged = d + d / sum1 * (100 - sum1);
    var sumAveragee = e + e / sum1 * (100 - sum1);
    var sumAveragef = f + f / sum1 * (100 - sum1);
    var sumAverageg = g + g / sum1 * (100 - sum1);
    var sumAverageh = h + h / sum1 * (100 - sum1);
    var sumAveragei = i + i / sum1 * (100 - sum1);

    var result1 = sumAveragea * (9 - ai) +
        sumAverageb * (9 - bi) +
        sumAveragec * (9 - ci) +
        sumAveraged * (9 - di) +
        sumAveragee * (9 - ei) +
        sumAveragef * (9 - fi) +
        sumAverageg * (9 - gi) +
        sumAverageh * (9 - hi) +
        sumAveragei * (9 - ii);

    outputResult2 = result1;
  }
  if (outputResult1 > outputResult2) {
    double getNumber(double input, {int precision = 2}) => double.parse(
        '$input'.substring(0, '$input'.indexOf('.') + precision + 1));
    return Container(
      height: height * 0.85,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            Text(
              '저는 첫 번째 사진이 마음에 들어요!',
              style: GoogleFonts.hiMelody(
                  textStyle: TextStyle(
                fontSize: width * 0.06,
                color: gender ? Colors.pink.withOpacity(0.3) : Colors.blueGrey,
              )),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              margin: EdgeInsets.all(width * 0.048),
              width: width * 0.48,
              height: width * 0.72,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color:
                        gender ? Colors.pink.withOpacity(0.3) : Colors.blueGrey,
                    width: width * 0.005,
                  )),
              child: Image.file(
                  File(
                    image1.path,
                  ),
                  fit: BoxFit.cover),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: height * 0.03, bottom: height * 0.04),
              width: width * 0.8,
              height: height * 0.005,
              decoration: BoxDecoration(
                color: gender ? Colors.pink.withOpacity(0.2) : Colors.blueGrey,
              ),
            ),
            Text(
              '정밀 분석',
              style: GoogleFonts.jua(
                  textStyle: TextStyle(
                fontSize: width * 0.096,
                color: gender ? Colors.pink.withOpacity(0.5) : Colors.blueGrey,
              )),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            new CircularPercentIndicator(
              radius: width * 0.4,
              lineWidth: width * 0.01,
              percent: ((outputResult1 / 9) /
                      ((outputResult1 / 9) + (outputResult2 / 9))) -
                  ((outputResult2 / 9) /
                      ((outputResult1 / 9) + (outputResult2 / 9))),
              center: new Text(
                '${(((outputResult1 / 9) / ((outputResult1 / 9) + (outputResult2 / 9)) * 100) - ((outputResult2 / 9) / ((outputResult1 / 9) + (outputResult2 / 9)) * 100)).toStringAsFixed(2)} %',
                style: GoogleFonts.jua(
                    textStyle: TextStyle(
                  fontSize: width * 0.046,
                  color:
                      gender ? Colors.pink.withOpacity(0.5) : Colors.blueGrey,
                )),
              ),
              progressColor: Colors.red,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              '차이값 ${(((outputResult1 / 9) / ((outputResult1 / 9) + (outputResult2 / 9)) * 100) - ((outputResult2 / 9) / ((outputResult1 / 9) + (outputResult2 / 9)) * 100)).toStringAsFixed(2)} %',
              style: GoogleFonts.jua(
                  textStyle: TextStyle(
                fontSize: width * 0.046,
                color: gender ? Colors.pink.withOpacity(0.5) : Colors.blueGrey,
              )),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Text(
              '첫 번째 사진이 두 번째 사진보다',
              style: GoogleFonts.jua(
                  textStyle: TextStyle(
                fontSize: width * 0.046,
                color: gender ? Colors.pink.withOpacity(0.5) : Colors.blueGrey,
              )),
            ),
            Text(
              '${(((outputResult1 / 9) / ((outputResult1 / 9) + (outputResult2 / 9)) * 2) - ((outputResult2 / 9) / ((outputResult1 / 9) + (outputResult2 / 9)) * 2) + 1).toStringAsFixed(2)} 배 더 마음에 드네요!',
              style: GoogleFonts.jua(
                  textStyle: TextStyle(
                fontSize: width * 0.046,
                color: gender ? Colors.pink.withOpacity(0.5) : Colors.blueGrey,
              )),
            ),
            Container(
              padding: EdgeInsets.all(width * 0.096),
              child: Column(
                children: [
                  Container(
                    height: height * 0.08,
                    child: Text(
                      '1번째 사진',
                      style: GoogleFonts.jua(
                          color: gender
                              ? Colors.pink.withOpacity(0.5)
                              : Colors.blueGrey,
                          fontSize: width * 0.06),
                    ),
                  ),
                  Container(
                    height: height * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: gender
                                ? Colors.pink.withOpacity(0.5)
                                : Colors.blueGrey,
                            width: width * 0.005)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              width: width * 0.27,
                              height: width * 0.36,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: gender
                                        ? Colors.pink.withOpacity(0.3)
                                        : Colors.blueGrey,
                                    width: width * 0.005,
                                  )),
                              child: Image.file(
                                  File(
                                    image1.path,
                                  ),
                                  fit: BoxFit.cover),
                            ),
                            new CircularPercentIndicator(
                              radius: width * 0.25,
                              lineWidth: width * 0.01,
                              percent: ((outputResult1 / 9) /
                                  ((outputResult1 / 9) + (outputResult2 / 9))),
                              center: new Text(
                                  '${((outputResult1 / 9) / ((outputResult1 / 9) + (outputResult2 / 9)) * 100).toStringAsFixed(2)} %'),
                              progressColor: Colors.red,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: width * 0.03,
                        ),
                        outputResult1 / 9 >= 80.0
                            ? Text(
                                '화보 아니에요?\n 아주 잘나왔어요',
                                style: GoogleFonts.jua(
                                    color: gender
                                        ? Colors.pink.withOpacity(0.5)
                                        : Colors.blueGrey,
                                    fontSize: width * 0.036),
                              )
                            : outputResult1 / 9 >= 60
                                ? Text(
                                    '너무 잘나왔어요.',
                                    style: GoogleFonts.jua(
                                        color: gender
                                            ? Colors.pink.withOpacity(0.5)
                                            : Colors.blueGrey,
                                        fontSize: width * 0.048),
                                  )
                                : outputResult1 / 9 >= 40
                                    ? Text(
                                        '평범한 사진이에요.',
                                        style: GoogleFonts.jua(
                                            color: gender
                                                ? Colors.pink.withOpacity(0.5)
                                                : Colors.blueGrey,
                                            fontSize: width * 0.048),
                                      )
                                    : outputResult1 / 9 >= 20
                                        ? Text(
                                            '약간 아쉬운데요?',
                                            style: GoogleFonts.jua(
                                                color: gender
                                                    ? Colors.pink
                                                        .withOpacity(0.5)
                                                    : Colors.blueGrey,
                                                fontSize: width * 0.048),
                                          )
                                        : outputResult1 / 9 >= 10
                                            ? Text(
                                                '다른 사진 어떠세요?',
                                                style: GoogleFonts.jua(
                                                    color: gender
                                                        ? Colors.pink
                                                            .withOpacity(0.5)
                                                        : Colors.blueGrey,
                                                    fontSize: width * 0.048),
                                              )
                                            : outputResult1 / 9 < 10
                                                ? Text(
                                                    '다시 찍어보세요.',
                                                    style: GoogleFonts.jua(
                                                        color: gender
                                                            ? Colors.pink
                                                                .withOpacity(
                                                                    0.5)
                                                            : Colors.blueGrey,
                                                        fontSize:
                                                            width * 0.048),
                                                  )
                                                : CircularProgressIndicator(),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: width * 0.14),
                    height: height * 0.08,
                    child: Text(
                      '2번째 사진',
                      style: GoogleFonts.jua(
                          color: gender
                              ? Colors.pink.withOpacity(0.5)
                              : Colors.blueGrey,
                          fontSize: width * 0.06),
                    ),
                  ),
                  Container(
                    height: height * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: gender
                                ? Colors.pink.withOpacity(0.5)
                                : Colors.blueGrey,
                            width: width * 0.005)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              width: width * 0.27,
                              height: width * 0.36,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: gender
                                        ? Colors.pink.withOpacity(0.3)
                                        : Colors.blueGrey,
                                    width: width * 0.005,
                                  )),
                              child: Image.file(
                                  File(
                                    image2.path,
                                  ),
                                  fit: BoxFit.cover),
                            ),
                            new CircularPercentIndicator(
                              radius: width * 0.25,
                              lineWidth: width * 0.01,
                              percent: ((outputResult2 / 9) /
                                  ((outputResult1 / 9) + (outputResult2 / 9))),
                              center: new Text(
                                  '${((outputResult2 / 9) / ((outputResult1 / 9) + (outputResult2 / 9)) * 100).toStringAsFixed(2)} %'),
                              progressColor: Colors.red,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: width * 0.03,
                        ),
                        outputResult2 / 9 >= 80.0
                            ? Text(
                                '화보 아니에요?\n 아주 잘나왔어요',
                                style: GoogleFonts.jua(
                                    color: gender
                                        ? Colors.pink.withOpacity(0.5)
                                        : Colors.blueGrey,
                                    fontSize: width * 0.036),
                              )
                            : outputResult2 / 9 >= 60
                                ? Text(
                                    '너무 잘나왔어요.',
                                    style: GoogleFonts.jua(
                                        color: gender
                                            ? Colors.pink.withOpacity(0.5)
                                            : Colors.blueGrey,
                                        fontSize: width * 0.048),
                                  )
                                : outputResult2 / 9 >= 40
                                    ? Text(
                                        '평범한 사진이에요.',
                                        style: GoogleFonts.jua(
                                            color: gender
                                                ? Colors.pink.withOpacity(0.5)
                                                : Colors.blueGrey,
                                            fontSize: width * 0.048),
                                      )
                                    : outputResult2 / 9 >= 20
                                        ? Text(
                                            '약간 아쉬운데요?',
                                            style: GoogleFonts.jua(
                                                color: gender
                                                    ? Colors.pink
                                                        .withOpacity(0.5)
                                                    : Colors.blueGrey,
                                                fontSize: width * 0.048),
                                          )
                                        : outputResult2 / 9 >= 10
                                            ? Text(
                                                '다른 사진 어떠세요?',
                                                style: GoogleFonts.jua(
                                                    color: gender
                                                        ? Colors.pink
                                                            .withOpacity(0.5)
                                                        : Colors.blueGrey,
                                                    fontSize: width * 0.048),
                                              )
                                            : outputResult2 / 9 < 10
                                                ? Text(
                                                    '다시 찍어보세요.',
                                                    style: GoogleFonts.jua(
                                                        color: gender
                                                            ? Colors.pink
                                                                .withOpacity(
                                                                    0.5)
                                                            : Colors.blueGrey,
                                                        fontSize:
                                                            width * 0.048),
                                                  )
                                                : CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } else if (outputResult1 < outputResult2) {
    return Container(
      height: height * 0.85,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.05,
            ),
            Text(
              '저는 두 번째 사진이 마음에 들어요!',
              style: GoogleFonts.hiMelody(
                  textStyle: TextStyle(
                fontSize: width * 0.06,
                color: gender ? Colors.pink.withOpacity(0.3) : Colors.blueGrey,
              )),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Container(
              margin: EdgeInsets.all(width * 0.048),
              width: width * 0.48,
              height: width * 0.72,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color:
                        gender ? Colors.pink.withOpacity(0.3) : Colors.blueGrey,
                    width: width * 0.005,
                  )),
              child: Image.file(
                  File(
                    image2.path,
                  ),
                  fit: BoxFit.cover),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: height * 0.03, bottom: height * 0.04),
              width: width * 0.8,
              height: height * 0.005,
              decoration: BoxDecoration(
                color: gender ? Colors.pink.withOpacity(0.2) : Colors.blueGrey,
              ),
            ),
            Text(
              '정밀 분석',
              style: GoogleFonts.jua(
                  textStyle: TextStyle(
                fontSize: width * 0.096,
                color: gender ? Colors.pink.withOpacity(0.5) : Colors.blueGrey,
              )),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            new CircularPercentIndicator(
              radius: width * 0.4,
              lineWidth: width * 0.01,
              percent: ((outputResult2 / 9) /
                      ((outputResult1 / 9) + (outputResult2 / 9))) -
                  ((outputResult1 / 9) /
                      ((outputResult1 / 9) + (outputResult2 / 9))),
              center: new Text(
                '${(((outputResult2 / 9) / ((outputResult1 / 9) + (outputResult2 / 9)) * 100) - ((outputResult1 / 9) / ((outputResult1 / 9) + (outputResult2 / 9)) * 100)).toStringAsFixed(2)} %',
                style: GoogleFonts.jua(
                    textStyle: TextStyle(
                  fontSize: width * 0.046,
                  color:
                      gender ? Colors.pink.withOpacity(0.5) : Colors.blueGrey,
                )),
              ),
              progressColor: Colors.red,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Text(
              '차이값 : ${(((outputResult2 / 9) / ((outputResult1 / 9) + (outputResult2 / 9)) * 100) - ((outputResult1 / 9) / ((outputResult1 / 9) + (outputResult2 / 9)) * 100)).toStringAsFixed(2)} %',
              style: GoogleFonts.jua(
                  textStyle: TextStyle(
                fontSize: width * 0.046,
                color: gender ? Colors.pink.withOpacity(0.5) : Colors.blueGrey,
              )),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Text(
              '두 번째 사진이 첫 번째 사진보다',
              style: GoogleFonts.jua(
                  textStyle: TextStyle(
                fontSize: width * 0.046,
                color: gender ? Colors.pink.withOpacity(0.5) : Colors.blueGrey,
              )),
            ),
            Text(
              '${(((outputResult2 / 9) / ((outputResult1 / 9) + (outputResult2 / 9)) * 2) - ((outputResult1 / 9) / ((outputResult1 / 9) + (outputResult2 / 9)) * 2) + 1).toStringAsFixed(2)} 배 더 마음에 드네요!',
              style: GoogleFonts.jua(
                  textStyle: TextStyle(
                fontSize: width * 0.046,
                color: gender ? Colors.pink.withOpacity(0.5) : Colors.blueGrey,
              )),
            ),
            Container(
              padding: EdgeInsets.all(width * 0.096),
              child: Column(
                children: [
                  Container(
                    height: height * 0.08,
                    child: Text(
                      '1번째 사진',
                      style: GoogleFonts.jua(
                          color:
                              gender ? Colors.pink[200] : Colors.blueGrey[300],
                          fontSize: width * 0.06),
                    ),
                  ),
                  Container(
                    height: height * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: gender
                                ? Colors.pink[200]
                                : Colors.blueGrey[300],
                            width: width * 0.005)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              width: width * 0.27,
                              height: width * 0.36,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: gender
                                        ? Colors.pink.withOpacity(0.3)
                                        : Colors.blueGrey,
                                    width: width * 0.005,
                                  )),
                              child: Image.file(
                                  File(
                                    image1.path,
                                  ),
                                  fit: BoxFit.cover),
                            ),
                            new CircularPercentIndicator(
                              radius: width * 0.25,
                              lineWidth: width * 0.01,
                              percent: ((outputResult1 / 9) /
                                  ((outputResult1 / 9) + (outputResult2 / 9))),
                              center: new Text(
                                  '${((outputResult1 / 9) / ((outputResult1 / 9) + (outputResult2 / 9)) * 100).toStringAsFixed(2)} %'),
                              progressColor: Colors.red,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: width * 0.03,
                        ),
                        outputResult1 / 9 >= 80.0
                            ? Text(
                                '화보 아니에요?\n 아주 잘나왔어요',
                                style: GoogleFonts.jua(
                                    color: gender
                                        ? Colors.pink[200]
                                        : Colors.blueGrey[300],
                                    fontSize: width * 0.036),
                              )
                            : outputResult1 / 9 >= 60
                                ? Text(
                                    '너무 잘나왔어요.',
                                    style: GoogleFonts.jua(
                                        color: gender
                                            ? Colors.pink[200]
                                            : Colors.blueGrey[300],
                                        fontSize: width * 0.048),
                                  )
                                : outputResult1 / 9 >= 40
                                    ? Text(
                                        '평범한 사진이에요.',
                                        style: GoogleFonts.jua(
                                            color: gender
                                                ? Colors.pink[200]
                                                : Colors.blueGrey[300],
                                            fontSize: width * 0.048),
                                      )
                                    : outputResult1 / 9 >= 20
                                        ? Text(
                                            '약간 아쉬운데요?',
                                            style: GoogleFonts.jua(
                                                color: gender
                                                    ? Colors.pink[200]
                                                    : Colors.blueGrey[300],
                                                fontSize: width * 0.048),
                                          )
                                        : outputResult1 / 9 >= 10
                                            ? Text(
                                                '다른 사진 어떠세요?',
                                                style: GoogleFonts.jua(
                                                    color: gender
                                                        ? Colors.pink[200]
                                                        : Colors.blueGrey[300],
                                                    fontSize: width * 0.048),
                                              )
                                            : outputResult1 / 9 < 10
                                                ? Text(
                                                    '다시 찍어보세요.',
                                                    style: GoogleFonts.jua(
                                                        color: gender
                                                            ? Colors.pink[200]
                                                            : Colors
                                                                .blueGrey[300],
                                                        fontSize:
                                                            width * 0.048),
                                                  )
                                                : CircularProgressIndicator(),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: width * 0.14),
                    height: height * 0.08,
                    child: Text(
                      '2번째 사진',
                      style: GoogleFonts.jua(
                          color:
                              gender ? Colors.pink[200] : Colors.blueGrey[300],
                          fontSize: width * 0.06),
                    ),
                  ),
                  Container(
                    height: height * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: gender
                                ? Colors.pink[200]
                                : Colors.blueGrey[300],
                            width: width * 0.005)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              width: width * 0.27,
                              height: width * 0.36,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: gender
                                        ? Colors.pink.withOpacity(0.3)
                                        : Colors.blueGrey,
                                    width: width * 0.005,
                                  )),
                              child: Image.file(
                                  File(
                                    image2.path,
                                  ),
                                  fit: BoxFit.cover),
                            ),
                            new CircularPercentIndicator(
                              radius: width * 0.25,
                              lineWidth: width * 0.01,
                              percent: ((outputResult2 / 9) /
                                  ((outputResult1 / 9) + (outputResult2 / 9))),
                              center: new Text(
                                  '${((outputResult2 / 9) / ((outputResult1 / 9) + (outputResult2 / 9)) * 100).toStringAsFixed(2)} %'),
                              progressColor: Colors.red,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: width * 0.03,
                        ),
                        outputResult2 / 9 >= 80.0
                            ? Text(
                                '화보 아니에요?\n 아주 잘나왔어요',
                                style: GoogleFonts.jua(
                                    color: gender
                                        ? Colors.pink[200]
                                        : Colors.blueGrey[300],
                                    fontSize: width * 0.036),
                              )
                            : outputResult2 / 9 >= 60
                                ? Text(
                                    '너무 잘나왔어요.',
                                    style: GoogleFonts.jua(
                                        color: gender
                                            ? Colors.pink[200]
                                            : Colors.blueGrey[300],
                                        fontSize: width * 0.048),
                                  )
                                : outputResult2 / 9 >= 40
                                    ? Text(
                                        '평범한 사진이에요.',
                                        style: GoogleFonts.jua(
                                            color: gender
                                                ? Colors.pink[200]
                                                : Colors.blueGrey[300],
                                            fontSize: width * 0.048),
                                      )
                                    : outputResult2 / 9 >= 20
                                        ? Text(
                                            '약간 아쉬운데요?',
                                            style: GoogleFonts.jua(
                                                color: gender
                                                    ? Colors.pink[200]
                                                    : Colors.blueGrey[300],
                                                fontSize: width * 0.048),
                                          )
                                        : outputResult2 / 9 >= 10
                                            ? Text(
                                                '다른 사진 어떠세요?.',
                                                style: GoogleFonts.jua(
                                                    color: gender
                                                        ? Colors.pink[200]
                                                        : Colors.blueGrey[300],
                                                    fontSize: width * 0.048),
                                              )
                                            : outputResult2 / 9 < 10
                                                ? Text(
                                                    '다시 찍어보세요.',
                                                    style: GoogleFonts.jua(
                                                        color: gender
                                                            ? Colors.pink[200]
                                                            : Colors
                                                                .blueGrey[300],
                                                        fontSize:
                                                            width * 0.048),
                                                  )
                                                : CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  } else
    return Column(
      children: [
        Text(
          '비교하기 어려워요',
          style: GoogleFonts.hiMelody(
              textStyle: TextStyle(
            fontSize: width * 0.06,
            color: gender ? Colors.pink.withOpacity(0.3) : Colors.blueGrey,
          )),
        ),
        Container(
          margin: EdgeInsets.only(bottom: height * 0.2, top: height * 0.08),
          color: Colors.transparent,
          width: width * 1,
          height: height * 0.4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: width * 0.48,
                height: width * 0.72,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: gender
                          ? Colors.pink.withOpacity(0.3)
                          : Colors.blueGrey,
                      width: width * 0.005,
                    )),
                child: Image.file(
                    File(
                      image1.path,
                    ),
                    fit: BoxFit.cover),
              ),
              Container(
                width: width * 0.48,
                height: width * 0.72,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                        color: gender
                            ? Colors.pink.withOpacity(0.3)
                            : Colors.blueGrey,
                        width: width * 0.005)),
                child: Image.file(
                    File(
                      image2.path,
                    ),
                    fit: BoxFit.cover),
              ),
            ],
          ),
        ),
      ],
    );
}
