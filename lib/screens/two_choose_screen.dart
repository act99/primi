import 'dart:async';
import 'dart:io';
import 'package:primi/admob/admob_manager.dart';
import 'package:primi/screens/two_loading_screen.dart';
import 'package:primi/tflite/photo_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class TwoChooseScreen extends StatefulWidget {
  final bool gender;
  TwoChooseScreen({this.gender});
  @override
  _TwoChooseScreenState createState() => _TwoChooseScreenState();
}

class _TwoChooseScreenState extends State<TwoChooseScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  // pageview
  PageController pageController = PageController(initialPage: 0);
  double pageScrollPosition = 1;
  int pageIndex = 0;
  AdmobManager adMob = AdmobManager();
  // pick image
  File _imageFile1;
  dynamic _pickImageError1;
  String _retrieveDataError1;
  File _imageFile2;
  dynamic _pickImageError2;
  String _retrieveDataError2;

  bool _loading = false;
  bool _loading1 = false;
  bool _loading2 = false;
  bool pageChange = true;

  ImagePicker _picker = ImagePicker();

  List outputs1;
  List outputs2;
// ------------- tflite tools & image picker tools

  void updatePageState() {
    setState(() {
      pageScrollPosition = pageController.position.pixels.abs();
    });
  }

  @override
  void initState() {
    super.initState();
    widget.gender
        ? TFLiteHelper.loadModelFemale().then((value) {
            setState(() {
              TFLiteHelper.modelLoaded = true;
              _loading = true;
            });
          })
        : TFLiteHelper.loadModelMale().then((value) {
            setState(() {
              TFLiteHelper.modelLoaded = true;
              _loading = true;
            });
          });
    pageController = PageController(keepPage: true);
    pageController.addListener(updatePageState);
    adMob.init();
    adMob.showBannerAd();
  }

  @override
  void dispose() {
    TFLiteHelper.disposeModel();
    pageController.dispose();
    adMob?.disposeBannerAd();
    super.dispose();
  }

  Widget _addPhoto1(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Container(
      width: width * 1,
      decoration: BoxDecoration(
        color: Colors.transparent,
        // widget.gender
        //     ? Colors.pink.withOpacity(0.1)
        //     : Colors.blueGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: height * 0.07),
            child: Text(
              '사진을 골라주세요',
              style: GoogleFonts.jua(
                textStyle: TextStyle(
                  fontSize: height * 0.03,
                  color: widget.gender
                      ? Colors.pink.withOpacity(0.3)
                      : Colors.blueGrey.withOpacity(0.7),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: height * 0.07),
            child: Text(
              '여백, 핸드폰 버튼 등이 나오면 부정확합니다.',
              style: GoogleFonts.jua(
                textStyle: TextStyle(
                  fontSize: height * 0.02,
                  color: widget.gender
                      ? Colors.pink.withOpacity(0.3)
                      : Colors.blueGrey.withOpacity(0.7),
                ),
              ),
            ),
          ),
          Container(
            child: Text(
              '이미지만 나온 "사진"을 골라주세요.',
              style: GoogleFonts.jua(
                textStyle: TextStyle(
                  fontSize: width * 0.036,
                  color: widget.gender
                      ? Colors.pink.withOpacity(0.3)
                      : Colors.blueGrey.withOpacity(0.7),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: height * 0.07),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    _onImageButtonPressed1(ImageSource.gallery,
                        context: context);
                  },
                  child: Container(
                    width: height * 0.15,
                    height: height * 0.15,
                    child: Column(
                      children: [
                        Icon(
                          CupertinoIcons.photo,
                          color: widget.gender
                              ? Colors.pink.withOpacity(0.3)
                              : Colors.blueGrey.withOpacity(0.7),
                          size: height * 0.07,
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Text(
                          '갤러리',
                          style: GoogleFonts.hiMelody(
                            textStyle: TextStyle(
                              fontSize: height * 0.03,
                              color: widget.gender
                                  ? Colors.pink.withOpacity(0.3)
                                  : Colors.blueGrey.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    _onImageButtonPressed1(ImageSource.camera,
                        context: context);
                  },
                  child: Container(
                    width: height * 0.15,
                    height: height * 0.15,
                    child: Column(
                      children: [
                        Icon(
                          CupertinoIcons.camera_fill,
                          color: widget.gender
                              ? Colors.pink.withOpacity(0.3)
                              : Colors.blueGrey.withOpacity(0.7),
                          size: height * 0.07,
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Text(
                          '카메라',
                          style: GoogleFonts.hiMelody(
                            textStyle: TextStyle(
                              fontSize: height * 0.03,
                              color: widget.gender
                                  ? Colors.pink.withOpacity(0.3)
                                  : Colors.blueGrey.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _addPhoto2(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Container(
      width: width * 1,
      decoration: BoxDecoration(
        color: Colors.transparent,
        // widget.gender
        //     ? Colors.pink.withOpacity(0.1)
        //     : Colors.blueGrey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: height * 0.07),
            child: Text(
              '사진을 골라주세요',
              style: GoogleFonts.jua(
                textStyle: TextStyle(
                  fontSize: height * 0.03,
                  color: widget.gender
                      ? Colors.pink.withOpacity(0.3)
                      : Colors.blueGrey.withOpacity(0.7),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: height * 0.07),
            child: Text(
              '여백, 핸드폰 버튼 등이 나오면 부정확합니다.',
              style: GoogleFonts.jua(
                textStyle: TextStyle(
                  fontSize: height * 0.02,
                  color: widget.gender
                      ? Colors.pink.withOpacity(0.3)
                      : Colors.blueGrey.withOpacity(0.7),
                ),
              ),
            ),
          ),
          Container(
            child: Text(
              '이미지만 나온 "사진"을 골라주세요.',
              style: GoogleFonts.jua(
                textStyle: TextStyle(
                  fontSize: width * 0.036,
                  color: widget.gender
                      ? Colors.pink.withOpacity(0.3)
                      : Colors.blueGrey.withOpacity(0.7),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: height * 0.07),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    _onImageButtonPressed2(ImageSource.gallery,
                        context: context);
                  },
                  child: Container(
                    width: height * 0.15,
                    height: height * 0.15,
                    child: Column(
                      children: [
                        Icon(
                          CupertinoIcons.photo,
                          color: widget.gender
                              ? Colors.pink.withOpacity(0.3)
                              : Colors.blueGrey.withOpacity(0.7),
                          size: height * 0.07,
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Text(
                          '갤러리',
                          style: GoogleFonts.hiMelody(
                            textStyle: TextStyle(
                              fontSize: height * 0.03,
                              color: widget.gender
                                  ? Colors.pink.withOpacity(0.3)
                                  : Colors.blueGrey.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    _onImageButtonPressed2(ImageSource.camera,
                        context: context);
                  },
                  child: Container(
                    width: height * 0.15,
                    height: height * 0.15,
                    child: Column(
                      children: [
                        Icon(
                          CupertinoIcons.camera_fill,
                          color: widget.gender
                              ? Colors.pink.withOpacity(0.3)
                              : Colors.blueGrey.withOpacity(0.7),
                          size: height * 0.07,
                        ),
                        SizedBox(
                          height: height * 0.015,
                        ),
                        Text(
                          '카메라',
                          style: GoogleFonts.hiMelody(
                            textStyle: TextStyle(
                              fontSize: height * 0.03,
                              color: widget.gender
                                  ? Colors.pink.withOpacity(0.3)
                                  : Colors.blueGrey.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _previewImage1(BoxFit option) {
    final Text retrieveError = _getRetrieveErrorWidget1();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile1 != null) {
      if (kIsWeb) {
        return Image.network(
          _imageFile1.path,
          fit: option,
        );
      } else {
        return Semantics(
            child: Image.file(
                File(
                  _imageFile1.path,
                ),
                fit: option),
            label: 'image_picker_example_picked_image');
      }
    } else if (_pickImageError1 != null) {
      return Text(
        'Pick image error: $_pickImageError1',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        '',
        textAlign: TextAlign.center,
      );
    }
  }

  Widget _previewImage2(BoxFit option) {
    final Text retrieveError = _getRetrieveErrorWidget2();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile2 != null) {
      if (kIsWeb) {
        return Image.network(
          _imageFile2.path,
          fit: option,
        );
      } else {
        return Semantics(
            child: Image.file(
                File(
                  _imageFile2.path,
                ),
                fit: option),
            label: 'image_picker_example_picked_image');
      }
    } else if (_pickImageError2 != null) {
      return Text(
        'Pick image error: $_pickImageError2',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        '',
        textAlign: TextAlign.center,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return _loading
        ? Scaffold(
            backgroundColor: Colors.white,
            key: _scaffoldkey,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: widget.gender
                  ? Colors.pink.withOpacity(0.1)
                  : Colors.blueGrey.withOpacity(0.1),
              shadowColor: widget.gender
                  ? Colors.pink.withOpacity(0.1)
                  : Colors.blueGrey.withOpacity(0.1),
              iconTheme: IconThemeData(
                color: widget.gender
                    ? Colors.pink.withOpacity(0.3)
                    : Colors.blueGrey.withOpacity(0.7), //change your color here
              ),
              elevation: 0.0,
              title: pageChange
                  ? Text(
                      '첫번째 사진',
                      style: GoogleFonts.hiMelody(
                          textStyle: TextStyle(
                        fontSize: width * 0.06,
                        color: widget.gender
                            ? Colors.pink.withOpacity(0.3)
                            : Colors.blueGrey.withOpacity(0.7),
                      )),
                    )
                  : Text(
                      '두번째 사진',
                      style: GoogleFonts.hiMelody(
                          textStyle: TextStyle(
                        fontSize: width * 0.06,
                        color: widget.gender
                            ? Colors.pink.withOpacity(0.2)
                            : Colors.blueGrey.withOpacity(0.7),
                      )),
                    ),
            ),
            body: SafeArea(
              child: Center(
                  child: !kIsWeb
                      // && defaultTargetPlatform == TargetPlatform.android
                      ? FutureBuilder<void>(
                          future: retrieveLostData1(),
                          builder: (BuildContext context,
                              AsyncSnapshot<void> snapshot) {
                            switch (snapshot.connectionState) {
                              case ConnectionState.none:
                              case ConnectionState.waiting:
                              // return const Text(
                              //   'You have not yet picked an image.',
                              //   textAlign: TextAlign.center,
                              // );
                              case ConnectionState.done:
                                return PageView(
                                  onPageChanged: (int index) {
                                    setState(() {
                                      pageIndex = index;
                                    });
                                  },
                                  controller: pageController,
                                  scrollDirection: Axis.vertical,
                                  physics: NeverScrollableScrollPhysics(),
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(30),
                                                  bottomLeft:
                                                      Radius.circular(30)),
                                              color: widget.gender
                                                  ? Colors.pink.withOpacity(0.1)
                                                  : Colors.blueGrey
                                                      .withOpacity(0.1)),
                                          width: width * 1,
                                          height: height * 0.7,
                                          child: Container(
                                            padding: EdgeInsets.all(30),
                                            width: height * 0.24,
                                            height: height * 0.32,
                                            child: _imageFile1 != null
                                                ? _previewImage1(BoxFit.cover)
                                                : _addPhoto1(context),
                                          ),
                                        ),
                                        _loading1
                                            ? Padding(
                                                padding: EdgeInsets.all(
                                                    width * 0.00),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: height * 0.007),
                                                      child: _imageFile1 != null
                                                          ? Container(
                                                              width:
                                                                  width * 0.4,
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            30),
                                                              ),
                                                              child: FlatButton(
                                                                onPressed: () {
                                                                  _imageFile1 =
                                                                      null;
                                                                  setState(() {
                                                                    _loading1 =
                                                                        false;
                                                                  });
                                                                },
                                                                child: Text(
                                                                  '재선택',
                                                                  style:
                                                                      GoogleFonts
                                                                          .jua(
                                                                    fontSize:
                                                                        width *
                                                                            0.05,
                                                                    color: widget
                                                                            .gender
                                                                        ? Colors
                                                                            .pink
                                                                            .withOpacity(
                                                                                0.3)
                                                                        : Colors
                                                                            .blueGrey
                                                                            .withOpacity(0.7),
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          : SizedBox(
                                                              width:
                                                                  width * 0.4,
                                                            ),
                                                    ),
                                                    Container(
                                                      width: width * 0.4,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: FlatButton(
                                                        onPressed: () {
                                                          pageController.nextPage(
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      1000),
                                                              curve:
                                                                  Curves.ease);
                                                          setState(() {
                                                            pageChange = false;
                                                          });
                                                        },
                                                        child: Text(
                                                          '다음 >',
                                                          style:
                                                              GoogleFonts.jua(
                                                            fontSize:
                                                                width * 0.05,
                                                            color: widget.gender
                                                                ? Colors.pink
                                                                    .withOpacity(
                                                                        0.3)
                                                                : Colors
                                                                    .blueGrey
                                                                    .withOpacity(
                                                                        0.7),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Container(),
                                        Container(
                                          height: 60,
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(30),
                                                  bottomLeft:
                                                      Radius.circular(30)),
                                              color: widget.gender
                                                  ? Colors.pink.withOpacity(0.1)
                                                  : Colors.blueGrey
                                                      .withOpacity(0.1)),
                                          width: width * 1,
                                          height: height * 0.7,
                                          child: Container(
                                            padding: EdgeInsets.all(30),
                                            width: height * 0.3,
                                            height: height * 0.4,
                                            child: _imageFile2 != null
                                                ? _previewImage2(BoxFit.cover)
                                                : _addPhoto2(context),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: width * 0.00),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: width * 0.3,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                ),
                                                child: FlatButton(
                                                  onPressed: () {
                                                    pageController.previousPage(
                                                        duration: Duration(
                                                            milliseconds: 1000),
                                                        curve: Curves.ease);
                                                    setState(() {
                                                      pageChange = true;
                                                    });
                                                  },
                                                  child: Text(
                                                    '< 이전으로',
                                                    style: GoogleFonts.jua(
                                                      fontSize: width * 0.05,
                                                      color: widget.gender
                                                          ? Colors.pink
                                                              .withOpacity(0.3)
                                                          : Colors.blueGrey
                                                              .withOpacity(0.7),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                child: _imageFile2 != null
                                                    ? Container(
                                                        width: width * 0.3,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                        ),
                                                        child: FlatButton(
                                                          onPressed: () {
                                                            _imageFile2 = null;
                                                            setState(() {
                                                              _loading2 = false;
                                                            });
                                                          },
                                                          child: Text(
                                                            '재선택',
                                                            style:
                                                                GoogleFonts.jua(
                                                              fontSize:
                                                                  width * 0.05,
                                                              color: widget
                                                                      .gender
                                                                  ? Colors.pink
                                                                      .withOpacity(
                                                                          0.3)
                                                                  : Colors
                                                                      .blueGrey
                                                                      .withOpacity(
                                                                          0.7),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox(
                                                        width: width * 0.3,
                                                      ),
                                              ),
                                              _loading1 && _loading2
                                                  ? Container(
                                                      width: width * 0.3,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30),
                                                      ),
                                                      child: FlatButton(
                                                        onPressed: () {
                                                          Navigator
                                                              .pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          TwoLoadingScreen(
                                                                            gender:
                                                                                widget.gender,
                                                                            imageFile1:
                                                                                _imageFile1,
                                                                            imageFile2:
                                                                                _imageFile2,
                                                                            output1:
                                                                                outputs1,
                                                                            output2:
                                                                                outputs2,
                                                                            loading1:
                                                                                _loading1,
                                                                            loading2:
                                                                                _loading2,
                                                                          )));
                                                        },
                                                        child: Text(
                                                          '결과보기!!',
                                                          style:
                                                              GoogleFonts.jua(
                                                            fontSize:
                                                                width * 0.05,
                                                            color: widget.gender
                                                                ? Colors.pink
                                                                    .withOpacity(
                                                                        0.3)
                                                                : Colors
                                                                    .blueGrey
                                                                    .withOpacity(
                                                                        0.7),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      width: width * 0.3,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(30),
                                                          color: Color(
                                                              0xfff8a0d3)),
                                                    ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 60,
                                        )
                                      ],
                                    ),
                                  ],
                                );

                              default:
                                if (snapshot.hasError) {
                                  return Text(
                                    'Pick image/video error: ${snapshot.error}}',
                                    textAlign: TextAlign.center,
                                  );
                                } else {
                                  return const Text(
                                    '',
                                    textAlign: TextAlign.center,
                                  );
                                }
                            }
                          },
                        )
                      : Container()),
            ),
          )
        : Center(
            child: Container(
              width: width * 0.1,
              height: width * 0.1,
              child: CircularProgressIndicator(
                backgroundColor: Colors.transparent,
              ),
            ),
          );
  }

  Future<void> retrieveLostData1() async {
    final LostData response1 = await _picker.getLostData();
    final LostData response2 = await _picker.getLostData();
    if (response1.isEmpty && response2.isEmpty) {
      return;
    }
    if (response1.file != null && response2.file != null) {
      setState(() {
        _imageFile1 = File(response1.file.path);
        _imageFile2 = File(response2.file.path);
      });
    } else {
      _retrieveDataError1 = response1.exception.code;
      _retrieveDataError2 = response2.exception.code;
    }
  }

  Text _getRetrieveErrorWidget1() {
    if (_retrieveDataError1 != null) {
      final Text result = Text(_retrieveDataError1);
      _retrieveDataError1 = null;
      return result;
    }
    return null;
  }

  Text _getRetrieveErrorWidget2() {
    if (_retrieveDataError2 != null) {
      final Text result = Text(_retrieveDataError1);
      _retrieveDataError2 = null;
      return result;
    }
    return null;
  }

  classifyImage1(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 7,
    );
    setState(() {
      outputs1 = output;
      _loading1 = true;
    });
  }

  classifyImage2(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 7,
    );
    setState(() {
      outputs2 = output;
      _loading2 = true;
    });
  }

  void _onImageButtonPressed1(ImageSource source,
      {BuildContext context}) async {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    try {
      final pickedFile = await _picker.getImage(
        source: source,
      );
      setState(() {
        _imageFile1 = File(pickedFile.path);
      });
      classifyImage1(File(pickedFile.path));
    } catch (e) {
      setState(() {
        _pickImageError1 = e;
      });
    }
  }

  void _onImageButtonPressed2(ImageSource source,
      {BuildContext context}) async {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    try {
      final pickedFile = await _picker.getImage(
        imageQuality: 50,
        source: source,
      );
      setState(() {
        _imageFile2 = File(pickedFile.path);
      });
      classifyImage2(File(pickedFile.path));
    } catch (e) {
      setState(() {
        _pickImageError2 = e;
      });
    }
  }
}
