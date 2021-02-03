import 'package:primi/screens/more_choose_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class MorePhotoScreen extends StatefulWidget {
  final bool gender;
  MorePhotoScreen({this.gender});
  @override
  _MorePhotoScreenState createState() => _MorePhotoScreenState();
}

class _MorePhotoScreenState extends State<MorePhotoScreen> {
  _launchURL() async {
    const url = 'https://www.youtube.com/channel/UCQNE2JmbasNYbjGAcuBiRRg';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
              color: widget.gender
                  ? Colors.pink.withOpacity(0.1)
                  : Colors.blueGrey.withOpacity(0.1)),
          child: Center(
              child: Column(
            children: <Widget>[
              widget.gender
                  ? Container(
                      child: RaisedButton(
                      elevation: 0.0,
                      color: Color(0xfffde8ef),
                      onPressed: _launchURL,
                      child: Image.asset('assets/jocoding_female.png'),
                    ))
                  : Container(
                      child: RaisedButton(
                      elevation: 0.0,
                      color: Color(0xffeef2f3),
                      onPressed: _launchURL,
                      child: Image.asset('assets/jocoding_male.png'),
                    )),
              SizedBox(
                height: height * 0.03,
              ),
              Text(
                '여러 장 비교하기',
                style: GoogleFonts.jua(
                    textStyle: TextStyle(
                        color: widget.gender
                            ? Colors.pink.withOpacity(0.3)
                            : Colors.blueGrey.withOpacity(0.7),
                        fontSize: width * 0.096,
                        fontWeight: FontWeight.w100)),
              ),
              Text(
                '여러 사진을 빠르게 분석합니다.',
                style: GoogleFonts.gothicA1(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.036,
                        fontWeight: FontWeight.w100)),
              ),
              Container(
                margin: EdgeInsets.only(top: height * 0.05),
                width: width * 0.5,
                height: width * 0.5,
                child: widget.gender
                    ? Image.asset('assets/morewoman.png')
                    : Image.asset('assets/moreman.png'),
              ),
              Text(
                '<Notice>',
                style: GoogleFonts.gothicA1(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.018,
                        fontWeight: FontWeight.w300)),
              ),
              Text(
                '',
                style: GoogleFonts.gothicA1(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.018,
                        fontWeight: FontWeight.w300)),
              ),
              Text(
                '*본인의 사진을 선택해주시고, 재미로만 해주세요!',
                style: GoogleFonts.gothicA1(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.018,
                        fontWeight: FontWeight.w300)),
              ),
              Text(
                '*멀리 있는 사진이더라도 얼굴이 정확하게 나와야 정밀합니다.',
                style: GoogleFonts.gothicA1(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.018,
                        fontWeight: FontWeight.w300)),
              ),
              Text(
                '해당 사진은 인식하지 않습니다.(얼굴 외 기타 동물,사물 등 / 일부러 찡그린 얼굴)',
                style: GoogleFonts.gothicA1(
                    textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: width * 0.018,
                        fontWeight: FontWeight.w300)),
              ),
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                height: height * 0.048,
                // margin: EdgeInsets.only(top: height * 0.1),
                child: RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MoreChooseScreen(
                          gender: widget.gender,
                        ),
                      ),
                    );
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: widget.gender
                              ? [Colors.pink[50], Colors.pinkAccent[100]]
                              : [Colors.blueGrey[100], Colors.blueGrey[200]],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(30.0)),
                    child: Container(
                      constraints: BoxConstraints(
                          maxWidth: width * 0.4, minHeight: 50.0),
                      alignment: Alignment.center,
                      child: Text(
                        "시작하기",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.gothicA1(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.036,
                                fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(),
            ],
          )),
        ),
      ),
    );
  }
}
