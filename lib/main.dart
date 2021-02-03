import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:primi/screens/more_photo_screen.dart';
import 'package:primi/screens/two_photo_screen.dart';
import 'package:primi/widget/rolling_switch.dart';

void main() async {
  runApp(MaterialApp(
    theme: ThemeData(
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    debugShowCheckedModeBanner: false,
    home: LoadingScreen(),
  ));
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  startTimer() async {
    var duration = Duration(milliseconds: 2500);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyApp()));
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Color(0xffd4a9ff)),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: height * 0.5,
                  height: height * 0.5,
                  child: Image.asset('assets/first.png'),
                ),
                Container(
                  width: height * 0.05,
                  height: height * 0.05,
                  child: Theme(
                    data: Theme.of(context).copyWith(accentColor: Colors.white),
                    child: new CircularProgressIndicator(),
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

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  // 남녀 프로세스

  bool gender;
  // 바텀내비게이션
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    gender = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    List<Widget> _widgetOptions = <Widget>[
      TwoPhotoScreen(
        gender: gender,
      ),
      MorePhotoScreen(
        gender: gender,
      ),
    ];

    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: _widgetOptions.elementAt(selectedIndex),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: width * 0.05),
            child: LiteRollingSwitch(
              value: true,
              textOn: Text(
                '  女',
                style: GoogleFonts.kosugiMaru(
                    color: Colors.white, fontSize: width * 0.06),
              ),
              textOff: Text(
                '  男',
                style: GoogleFonts.kosugiMaru(
                    color: Colors.white, fontSize: width * 0.06),
              ),
              colorOn: Colors.pink.withOpacity(0.3),
              colorOff: Colors.blueGrey.withOpacity(0.3),
              iconOn: ImageIcon(
                AssetImage('assets/female.png'),
                color: Colors.pink.withOpacity(0.3),
              ),
              iconOff: ImageIcon(
                AssetImage('assets/male.png'),
                color: Colors.blueGrey.withOpacity(0.3),
              ),
              onChanged: (gender) {
                print('Gender is ${(gender) ? 'Female' : 'Male'}');
              },
              onTap: () {
                setState(() {
                  gender == false ? gender = true : gender = false;
                });
                print(gender);
              },
              onSwipe: () {
                setState(() {
                  gender == false ? gender = true : gender = false;
                });
                print(gender);
              },
              onDoubleTap: () {
                setState(() {
                  gender == false ? gender = true : gender = false;
                });
                print(gender);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.15, vertical: height * 0.05),
            child: Container(
              child: GNav(
                  gap: 8,
                  color: gender ? Colors.pink[100] : Colors.blueGrey[200],
                  activeColor: gender ? Colors.pink[100] : Colors.blueGrey[100],
                  iconSize: 24,
                  tabBackgroundColor: gender
                      ? Colors.pink.withOpacity(0.1)
                      : Colors.blueGrey.withOpacity(0.1),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  duration: Duration(milliseconds: 1000),
                  tabs: [
                    GButton(
                      icon: LineIcons.hand_peace_o,
                      text: '두 장',
                    ),
                    GButton(
                      icon: LineIcons.hand_paper_o,
                      text: '여러 장',
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onTabChange: (index) {
                    print(index);
                    setState(() {
                      selectedIndex = index;
                    });
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
