import 'package:primi/admob/admob_manager.dart';
import 'package:primi/main.dart';
import 'package:primi/model/classify_model.dart';
import 'package:primi/model/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';

class MoreResultScreen extends StatefulWidget {
  final List<File> fileImageArray;
  final List<List> outputsList;
  final bool gender;
  final AdmobManager adMob;

  MoreResultScreen(
      {this.fileImageArray, this.outputsList, this.gender, this.adMob});
  @override
  _MoreResultScreenState createState() => _MoreResultScreenState();
}

class _MoreResultScreenState extends State<MoreResultScreen> {
  double resultValue;
  List confidenceList = [];
  List<dynamic> resultValueList;

  void calculate() {
    for (int i = 0; i < widget.fileImageArray.length; i++) {
      if (widget.outputsList[i].length == 1) {
        var a = widget.outputsList[i][0]['confidence'] * 100;

        var ai = widget.outputsList[i][0]['index'];
        var sum1 = a;
        var sumAveragea = a + a / sum1 * (100 - sum1);
        var result1 = sumAveragea * (9 - ai);
        resultValueList = [result1];
      }
      if (widget.outputsList[i].length == 2) {
        var a = widget.outputsList[i][0]['confidence'] * 100;
        var b = widget.outputsList[i][1]['confidence'] * 100;

        var ai = widget.outputsList[i][0]['index'];
        var bi = widget.outputsList[i][1]['index'];
        var sum1 = a + b;
        var sumAveragea = a + a / sum1 * (100 - sum1);
        var sumAverageb = b + b / sum1 * (100 - sum1);
        var result1 = sumAveragea * (9 - ai) + sumAverageb * (9 - bi);
        resultValueList = [result1];
      }
      if (widget.outputsList[i].length == 3) {
        var a = widget.outputsList[i][0]['confidence'] * 100;
        var b = widget.outputsList[i][1]['confidence'] * 100;
        var c = widget.outputsList[i][2]['confidence'] * 100;

        var ai = widget.outputsList[i][0]['index'];
        var bi = widget.outputsList[i][1]['index'];
        var ci = widget.outputsList[i][2]['index'];

        var sum1 = a + b + c;
        var sumAveragea = a + a / sum1 * (100 - sum1);
        var sumAverageb = b + b / sum1 * (100 - sum1);
        var sumAveragec = c + c / sum1 * (100 - sum1);

        var result1 = sumAveragea * (9 - ai) +
            sumAverageb * (9 - bi) +
            sumAveragec * (9 - ci);
        resultValueList = [result1];
      }
      if (widget.outputsList[i].length == 4) {
        var a = widget.outputsList[i][0]['confidence'] * 100;
        var b = widget.outputsList[i][1]['confidence'] * 100;
        var c = widget.outputsList[i][2]['confidence'] * 100;
        var d = widget.outputsList[i][3]['confidence'] * 100;

        var ai = widget.outputsList[i][0]['index'];
        var bi = widget.outputsList[i][1]['index'];
        var ci = widget.outputsList[i][2]['index'];
        var di = widget.outputsList[i][3]['index'];

        var sum1 = a + b + c + d;
        var sumAveragea = a + a / sum1 * (100 - sum1);
        var sumAverageb = b + b / sum1 * (100 - sum1);
        var sumAveragec = c + c / sum1 * (100 - sum1);
        var sumAveraged = d + d / sum1 * (100 - sum1);

        var result1 = sumAveragea * (9 - ai) +
            sumAverageb * (9 - bi) +
            sumAveragec * (9 - ci) +
            sumAveraged * (9 - di);

        resultValueList = [result1];
      }
      if (widget.outputsList[i].length == 5) {
        var a = widget.outputsList[i][0]['confidence'] * 100;
        var b = widget.outputsList[i][1]['confidence'] * 100;
        var c = widget.outputsList[i][2]['confidence'] * 100;
        var d = widget.outputsList[i][3]['confidence'] * 100;
        var e = widget.outputsList[i][4]['confidence'] * 100;

        var ai = widget.outputsList[i][0]['index'];
        var bi = widget.outputsList[i][1]['index'];
        var ci = widget.outputsList[i][2]['index'];
        var di = widget.outputsList[i][3]['index'];
        var ei = widget.outputsList[i][4]['index'];

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

        resultValueList = [result1];
      }
      if (widget.outputsList[i].length == 6) {
        var a = widget.outputsList[i][0]['confidence'] * 100;
        var b = widget.outputsList[i][1]['confidence'] * 100;
        var c = widget.outputsList[i][2]['confidence'] * 100;
        var d = widget.outputsList[i][3]['confidence'] * 100;
        var e = widget.outputsList[i][4]['confidence'] * 100;
        var f = widget.outputsList[i][5]['confidence'] * 100;

        var ai = widget.outputsList[i][0]['index'];
        var bi = widget.outputsList[i][1]['index'];
        var ci = widget.outputsList[i][2]['index'];
        var di = widget.outputsList[i][3]['index'];
        var ei = widget.outputsList[i][4]['index'];
        var fi = widget.outputsList[i][5]['index'];

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

        resultValueList = [result1];
      }
      if (widget.outputsList[i].length == 7) {
        var a = widget.outputsList[i][0]['confidence'] * 100;
        var b = widget.outputsList[i][1]['confidence'] * 100;
        var c = widget.outputsList[i][2]['confidence'] * 100;
        var d = widget.outputsList[i][3]['confidence'] * 100;
        var e = widget.outputsList[i][4]['confidence'] * 100;
        var f = widget.outputsList[i][5]['confidence'] * 100;
        var g = widget.outputsList[i][6]['confidence'] * 100;

        var ai = widget.outputsList[i][0]['index'];
        var bi = widget.outputsList[i][1]['index'];
        var ci = widget.outputsList[i][2]['index'];
        var di = widget.outputsList[i][3]['index'];
        var ei = widget.outputsList[i][4]['index'];
        var fi = widget.outputsList[i][5]['index'];
        var gi = widget.outputsList[i][6]['index'];

        var sum1 = a + b + c + d + e + f + g;
        var sumAveragea = a + a / sum1 * (100 - sum1);
        var sumAverageb = b + b / sum1 * (100 - sum1);
        var sumAveragec = c + c / sum1 * (100 - sum1);
        var sumAveraged = d + d / sum1 * (100 - sum1);
        var sumAveragee = e + e / sum1 * (100 - sum1);
        var sumAveragef = f + f / sum1 * (100 - sum1);
        var sumAverageg = g + g / sum1 * (100 - sum1);

        var result1 = sumAveragea * (9 - ai) +
            sumAverageb * (9 - bi) +
            sumAveragec * (9 - ci) +
            sumAveraged * (9 - di) +
            sumAveragee * (9 - ei) +
            sumAveragef * (9 - fi) +
            sumAverageg * (9 - gi);

        resultValueList = result1;
      }
      if (widget.outputsList[i].length == 8) {
        var a = widget.outputsList[i][0]['confidence'] * 100;
        var b = widget.outputsList[i][1]['confidence'] * 100;
        var c = widget.outputsList[i][2]['confidence'] * 100;
        var d = widget.outputsList[i][3]['confidence'] * 100;
        var e = widget.outputsList[i][4]['confidence'] * 100;
        var f = widget.outputsList[i][5]['confidence'] * 100;
        var g = widget.outputsList[i][6]['confidence'] * 100;
        var h = widget.outputsList[i][7]['confidence'] * 100;

        var ai = widget.outputsList[i][0]['index'];
        var bi = widget.outputsList[i][1]['index'];
        var ci = widget.outputsList[i][2]['index'];
        var di = widget.outputsList[i][3]['index'];
        var ei = widget.outputsList[i][4]['index'];
        var fi = widget.outputsList[i][5]['index'];
        var gi = widget.outputsList[i][6]['index'];
        var hi = widget.outputsList[i][7]['index'];

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

        resultValueList = result1;
      }
      if (widget.outputsList[i].length == 9) {
        var a = widget.outputsList[i][0]['confidence'] * 100;
        var b = widget.outputsList[i][1]['confidence'] * 100;
        var c = widget.outputsList[i][2]['confidence'] * 100;
        var d = widget.outputsList[i][3]['confidence'] * 100;
        var e = widget.outputsList[i][4]['confidence'] * 100;
        var f = widget.outputsList[i][5]['confidence'] * 100;
        var g = widget.outputsList[i][6]['confidence'] * 100;
        var h = widget.outputsList[i][7]['confidence'] * 100;
        var j = widget.outputsList[i][8]['confidence'] * 100;

        var ai = widget.outputsList[i][0]['index'];
        var bi = widget.outputsList[i][1]['index'];
        var ci = widget.outputsList[i][2]['index'];
        var di = widget.outputsList[i][3]['index'];
        var ei = widget.outputsList[i][4]['index'];
        var fi = widget.outputsList[i][5]['index'];
        var gi = widget.outputsList[i][6]['index'];
        var hi = widget.outputsList[i][7]['index'];
        var ji = widget.outputsList[i][8]['index'];

        var sum1 = a + b + c + d + e + f + g + h + j;
        var sumAveragea = a + a / sum1 * (100 - sum1);
        var sumAverageb = b + b / sum1 * (100 - sum1);
        var sumAveragec = c + c / sum1 * (100 - sum1);
        var sumAveraged = d + d / sum1 * (100 - sum1);
        var sumAveragee = e + e / sum1 * (100 - sum1);
        var sumAveragef = f + f / sum1 * (100 - sum1);
        var sumAverageg = g + g / sum1 * (100 - sum1);
        var sumAverageh = h + h / sum1 * (100 - sum1);
        var sumAveragej = j + j / sum1 * (100 - sum1);

        var result1 = sumAveragea * (9 - ai) +
            sumAverageb * (9 - bi) +
            sumAveragec * (9 - ci) +
            sumAveraged * (9 - di) +
            sumAveragee * (9 - ei) +
            sumAveragef * (9 - fi) +
            sumAverageg * (9 - gi) +
            sumAverageh * (9 - hi) +
            sumAveragej * (9 - ji);

        resultValueList = result1;
      }

      confidenceList.add(resultValueList[0]);
      ClassifyModel classifyModel = ClassifyModel(
          image: widget.fileImageArray[i].path, confidence: confidenceList[i]);
      DBHelper().createData(classifyModel);

      // classifyModelList = [
      //   ClassifyModel.fromMap(
      //       {'image': fileImageArray[i], 'confidence': valueValue[i]})
      // ];
    }
  }

  @override
  void initState() {
    super.initState();
    calculate();
  }

  @override
  void dispose() {
    DBHelper().deleteAllData();
    widget.adMob?.disposeBannerAd();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            width: width,
            color: widget.gender
                ? Colors.pink.withOpacity(0.1)
                : Colors.blueGrey.withOpacity(0.2),
            child: Column(
              children: [
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
                                          : Colors.blueGrey.withOpacity(0.7),
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
                FutureBuilder(
                  future: DBHelper().readAllData(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<ClassifyModel>> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        height: height * 0.83,
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 3 / 6, crossAxisCount: 2),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            ClassifyModel item = snapshot.data[index];
                            return Container(
                              height: height * 0.7,

                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: height * 0.06,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        '${index + 1} 등 사진 !',
                                        style: GoogleFonts.jua(
                                          textStyle: TextStyle(
                                            fontSize: width * 0.048,
                                            color: widget.gender
                                                ? Colors.pink.withOpacity(0.3)
                                                : Colors.blueGrey
                                                    .withOpacity(0.7),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: height * 0.3,
                                    child: Card(
                                      clipBehavior: Clip.antiAlias,
                                      child: Image.file(
                                        File(
                                          item.image,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.03,
                                  ),
                                  Container(
                                    height: height * 0.09,
                                    child: widget.gender
                                        ? item.confidence == 900
                                            ? Text(
                                                '여신급 사진이네요!\n사진이 엄청 잘 나왔어요!',
                                                style: GoogleFonts.hiMelody(
                                                  textStyle: TextStyle(
                                                    fontSize: width * 0.048,
                                                    color: widget.gender
                                                        ? Colors.pink
                                                            .withOpacity(0.4)
                                                        : Colors.blueGrey
                                                            .withOpacity(0.7),
                                                  ),
                                                ),
                                              )
                                            : item.confidence >= 800
                                                ? Text(
                                                    '연예인 아니세요?\n사진이 화보같아요!',
                                                    style: GoogleFonts.hiMelody(
                                                      textStyle: TextStyle(
                                                        fontSize: width * 0.048,
                                                        color: widget.gender
                                                            ? Colors.pink
                                                                .withOpacity(
                                                                    0.4)
                                                            : Colors.blueGrey
                                                                .withOpacity(
                                                                    0.7),
                                                      ),
                                                    ),
                                                  )
                                                : item.confidence >= 700
                                                    ? Text(
                                                        '너무 이쁘게 나왔어요!\n바로 프사 고고!',
                                                        style: GoogleFonts
                                                            .hiMelody(
                                                          textStyle: TextStyle(
                                                            fontSize:
                                                                width * 0.048,
                                                            color: widget.gender
                                                                ? Colors.pink
                                                                    .withOpacity(
                                                                        0.4)
                                                                : Colors
                                                                    .blueGrey
                                                                    .withOpacity(
                                                                        0.7),
                                                          ),
                                                        ),
                                                      )
                                                    : item.confidence >= 600
                                                        ? Text(
                                                            '이쁘게 나왔어요.',
                                                            style: GoogleFonts
                                                                .hiMelody(
                                                              textStyle:
                                                                  TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.048,
                                                                color: widget
                                                                        .gender
                                                                    ? Colors
                                                                        .pink
                                                                        .withOpacity(
                                                                            0.4)
                                                                    : Colors
                                                                        .blueGrey
                                                                        .withOpacity(
                                                                            0.7),
                                                              ),
                                                            ),
                                                          )
                                                        : item.confidence >= 400
                                                            ? Text(
                                                                '프사하기 좋은 사진이네요.',
                                                                style: GoogleFonts
                                                                    .hiMelody(
                                                                  textStyle:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        width *
                                                                            0.048,
                                                                    color: widget
                                                                            .gender
                                                                        ? Colors
                                                                            .pink
                                                                            .withOpacity(
                                                                                0.4)
                                                                        : Colors
                                                                            .blueGrey
                                                                            .withOpacity(0.7),
                                                                  ),
                                                                ),
                                                              )
                                                            : item.confidence >=
                                                                    200
                                                                ? Text(
                                                                    '프사로 하기 아쉬운데요?\n다시 한번 찍어보세요',
                                                                    style: GoogleFonts
                                                                        .hiMelody(
                                                                      textStyle:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            width *
                                                                                0.048,
                                                                        color: widget.gender
                                                                            ? Colors.pink.withOpacity(0.4)
                                                                            : Colors.blueGrey.withOpacity(0.7),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : item.confidence >=
                                                                        100
                                                                    ? Text(
                                                                        '다른 사진이 더 나을 것 같아요.:)',
                                                                        style: GoogleFonts
                                                                            .hiMelody(
                                                                          textStyle:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                width * 0.036,
                                                                            color: widget.gender
                                                                                ? Colors.pink.withOpacity(0.4)
                                                                                : Colors.blueGrey.withOpacity(0.7),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Text(
                                                                        'ㅇ.ㅇ',
                                                                        style: GoogleFonts
                                                                            .hiMelody(
                                                                          textStyle:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                width * 0.048,
                                                                            color: widget.gender
                                                                                ? Colors.pink.withOpacity(0.4)
                                                                                : Colors.blueGrey.withOpacity(0.7),
                                                                          ),
                                                                        ),
                                                                      )
                                        : item.confidence == 900
                                            ? Text(
                                                '조각상을 보는 것 같아요!\n사진이 엄청 잘 나왔어요!',
                                                style: GoogleFonts.hiMelody(
                                                  textStyle: TextStyle(
                                                    fontSize: width * 0.048,
                                                    color: widget.gender
                                                        ? Colors.pink
                                                            .withOpacity(0.4)
                                                        : Colors.blueGrey
                                                            .withOpacity(0.7),
                                                  ),
                                                ),
                                              )
                                            : item.confidence >= 800
                                                ? Text(
                                                    '연예인 아니세요?\n사진이 화보같아요!',
                                                    style: GoogleFonts.hiMelody(
                                                      textStyle: TextStyle(
                                                        fontSize: width * 0.048,
                                                        color: widget.gender
                                                            ? Colors.pink
                                                                .withOpacity(
                                                                    0.4)
                                                            : Colors.blueGrey
                                                                .withOpacity(
                                                                    0.7),
                                                      ),
                                                    ),
                                                  )
                                                : item.confidence >= 700
                                                    ? Text(
                                                        '너무 잘생기게 나왔어요!\n바로 프사 고고!',
                                                        style: GoogleFonts
                                                            .hiMelody(
                                                          textStyle: TextStyle(
                                                            fontSize:
                                                                width * 0.048,
                                                            color: widget.gender
                                                                ? Colors.pink
                                                                    .withOpacity(
                                                                        0.4)
                                                                : Colors
                                                                    .blueGrey
                                                                    .withOpacity(
                                                                        0.7),
                                                          ),
                                                        ),
                                                      )
                                                    : item.confidence >= 600
                                                        ? Text(
                                                            '평범하게 나왔어요',
                                                            style: GoogleFonts
                                                                .hiMelody(
                                                              textStyle:
                                                                  TextStyle(
                                                                fontSize:
                                                                    width *
                                                                        0.048,
                                                                color: widget
                                                                        .gender
                                                                    ? Colors
                                                                        .pink
                                                                        .withOpacity(
                                                                            0.4)
                                                                    : Colors
                                                                        .blueGrey
                                                                        .withOpacity(
                                                                            0.7),
                                                              ),
                                                            ),
                                                          )
                                                        : item.confidence >= 400
                                                            ? Text(
                                                                '아쉬운데요?',
                                                                style: GoogleFonts
                                                                    .hiMelody(
                                                                  textStyle:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        width *
                                                                            0.04,
                                                                    color: widget
                                                                            .gender
                                                                        ? Colors
                                                                            .pink
                                                                            .withOpacity(
                                                                                0.4)
                                                                        : Colors
                                                                            .blueGrey
                                                                            .withOpacity(0.7),
                                                                  ),
                                                                ),
                                                              )
                                                            : item.confidence >=
                                                                    200
                                                                ? Text(
                                                                    '다른 사진이 나을 것 같아요..:)',
                                                                    style: GoogleFonts
                                                                        .hiMelody(
                                                                      textStyle:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            width *
                                                                                0.048,
                                                                        color: widget.gender
                                                                            ? Colors.pink.withOpacity(0.4)
                                                                            : Colors.blueGrey.withOpacity(0.7),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : item.confidence >=
                                                                        100
                                                                    ? Text(
                                                                        '다시 한번 찍어보세요.',
                                                                        style: GoogleFonts
                                                                            .hiMelody(
                                                                          textStyle:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                width * 0.036,
                                                                            color: widget.gender
                                                                                ? Colors.pink.withOpacity(0.4)
                                                                                : Colors.blueGrey.withOpacity(0.7),
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : Text(
                                                                        'ㅇ.ㅇ',
                                                                        style: GoogleFonts
                                                                            .hiMelody(
                                                                          textStyle:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                width * 0.048,
                                                                            color: widget.gender
                                                                                ? Colors.pink.withOpacity(0.4)
                                                                                : Colors.blueGrey.withOpacity(0.7),
                                                                          ),
                                                                        ),
                                                                      ),
                                  )
                                ],
                              ),
                              // border: Border(
                              //   right: BorderSide(color: Colors.white),
                              // )),
                              // child: Column(
                              //   children: [
                              //     Expanded(
                              //       child: Padding(
                              //         padding: EdgeInsets.all(width * 0.005),
                              //         child: Column(
                              //           children: <Widget>[
                              //             Text('$index'),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     Container(
                              //       height: height * 0.3,
                              //       child: Card(
                              //         semanticContainer: true,
                              //         clipBehavior: Clip.antiAliasWithSaveLayer,
                              //         child: Column(
                              //           children: <Widget>[
                              //             Image.file(
                              //               File(item.image),
                              //               fit: BoxFit.fill,
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                        child: Container(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
