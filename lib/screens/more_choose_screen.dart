import 'dart:io';
import 'package:primi/admob/admob_manager.dart';
import 'package:primi/screens/more_loading_screen.dart';
import 'package:primi/tflite/photo_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:tflite/tflite.dart';

class MoreChooseScreen extends StatefulWidget {
  final bool gender;
  MoreChooseScreen({this.gender});
  @override
  _MoreChooseScreenState createState() => _MoreChooseScreenState();
}

class _MoreChooseScreenState extends State<MoreChooseScreen> {
  List<File> fileImageArray = [];
  List<String> f = List();
  List<Asset> resultList = List<Asset>();
  List<Asset> images = List<Asset>();
  String error;
  bool reset = true;
  //tflite
  // List outputs;
  bool _loading = false;
  bool _classifyLoading = false;
  // List outputs;

  List<List> outputsList = [];
  AdmobManager adMob = AdmobManager();

  Future<void> loadAssets() async {
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 12,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          statusBarColor: widget.gender ? "#ffc4d7" : "#97b7bf",
          actionBarColor: widget.gender ? "#ffc4d7" : "#97b7bf",
          actionBarTitle: "사진 선택",
          allViewTitle: "모든 사진",
          useDetailsView: false,
          selectCircleStrokeColor: "#ffffff",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    for (int i = 0; i < resultList.length; i++) {
      var path =
          await FlutterAbsolutePath.getAbsolutePath(resultList[i].identifier);
      print(path);
      fileImageArray.add(File(path));
    }

    setState(() {
      images = resultList;
    });
    for (int i = 0; i < fileImageArray.length; i++) {
      await classifyImage(fileImageArray[i], i);
    }
    return fileImageArray;
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 4,
      children: List.generate(fileImageArray.length, (index) {
        File asset = fileImageArray[index];
        return Image.file(
            File(
              asset.path,
            ),
            fit: BoxFit.cover);
      }),
    );
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
    adMob.init();
    adMob.showBannerAd();
  }

  @override
  void dispose() {
    TFLiteHelper.disposeModel();
    adMob?.disposeBannerAd();
    super.dispose();
  }

  classifyImage(File image, int i) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
      numResults: 7,
    );
    setState(() {
      outputsList.insert(i, output);
      // outputsList[0].clear();
      _classifyLoading = true;
    });
    return outputsList;
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return new Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          '여러 사진 선택',
          style: GoogleFonts.hiMelody(
            textStyle: TextStyle(
              fontSize: width * 0.06,
              color: widget.gender
                  ? Colors.pink.withOpacity(0.4)
                  : Colors.blueGrey.withOpacity(0.7),
            ),
          ),
        ),
        backgroundColor: widget.gender
            ? Colors.pink.withOpacity(0.1)
            : Colors.blueGrey.withOpacity(0.2),
        shadowColor: widget.gender
            ? Colors.pink.withOpacity(0.1)
            : Colors.blueGrey.withOpacity(0.2),
        iconTheme: IconThemeData(
          color: widget.gender
              ? Colors.pink.withOpacity(0.4)
              : Colors.blueGrey.withOpacity(0.7),
        ),
      ),
      body: Container(
        width: width,
        color: widget.gender
            ? Colors.pink.withOpacity(0.1)
            : Colors.blueGrey.withOpacity(0.2),
        child: _loading
            ? reset
                ? Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: height * 0.07),
                        child: Text(
                          '사진을 골라주세요',
                          style: GoogleFonts.jua(
                            textStyle: TextStyle(
                              fontSize: width * 0.07,
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
                          '여백, 기타 버튼 등이 나오면 부정확합니다.',
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
                      FlatButton(
                        minWidth: width * 0.25,
                        height: width * 0.6,
                        onPressed: () {
                          loadAssets();

                          setState(() {
                            reset = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(),
                          width: width * 0.2,
                          height: width * 0.4,
                          child: Column(
                            children: [
                              Icon(
                                CupertinoIcons.photo,
                                color: widget.gender
                                    ? Colors.pink[200]
                                    : Colors.blueGrey,
                                size: width * 0.15,
                              ),
                              SizedBox(
                                height: height * 0.015,
                              ),
                              Text(
                                '갤러리',
                                style: GoogleFonts.hiMelody(
                                  textStyle: TextStyle(
                                    fontSize: width * 0.06,
                                    color: widget.gender
                                        ? Colors.pink[200]
                                        : Colors.blueGrey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(
                            top: height * 0.05, bottom: height * 0.05),
                        child: Text(
                          '사진 ${fileImageArray.length}장을 선택하셨습니다.',
                          style: GoogleFonts.hiMelody(
                              textStyle: TextStyle(
                            fontSize: width * 0.06,
                            color: widget.gender
                                ? Colors.pink.withOpacity(0.4)
                                : Colors.blueGrey.withOpacity(0.7),
                          )),
                        ),
                      ),
                      fileImageArray == null
                          ? Container()
                          : Expanded(
                              child: buildGridView(),
                            ),
                      Container(
                        margin: EdgeInsets.only(
                            top: height * 0.075, bottom: height * 0.075),
                        child: Text(
                          '결과보기 버튼을 눌러주세요.',
                          style: GoogleFonts.hiMelody(
                              textStyle: TextStyle(
                            fontSize: width * 0.06,
                            color: widget.gender
                                ? Colors.pink.withOpacity(0.4)
                                : Colors.blueGrey.withOpacity(0.7),
                          )),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: width * 0.4,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: FlatButton(
                              child: Text(
                                '재선택',
                                style: GoogleFonts.jua(
                                  fontSize: width * 0.05,
                                  color: widget.gender
                                      ? Colors.pink.withOpacity(0.4)
                                      : Colors.blueGrey.withOpacity(0.7),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  fileImageArray.clear();
                                  images.clear();
                                  resultList.clear();
                                  outputsList.clear();
                                  reset = true;
                                });
                              },
                            ),
                          ),
                          _classifyLoading
                              ? Container(
                                  width: width * 0.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: FlatButton(
                                    child: Text(
                                      "결과보기 >",
                                      style: GoogleFonts.jua(
                                        fontSize: width * 0.05,
                                        color: widget.gender
                                            ? Colors.pink.withOpacity(0.4)
                                            : Colors.blueGrey.withOpacity(0.7),
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              MoreLoadingScreen(
                                            fileImageArray: fileImageArray,
                                            outputsList: outputsList,
                                            gender: widget.gender,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : Container(
                                  width: 30,
                                  height: 30,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.1,
                      )
                    ],
                  )
            : Container(
                width: 20,
                height: 20,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      ),
    );
  }
}
