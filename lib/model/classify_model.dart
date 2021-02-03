import 'dart:io';

class ClassifyModel {
  int id;
  String image;
  double confidence;
  ClassifyModel({this.image, this.id, this.confidence});

  ClassifyModel.fromMap(Map<String, dynamic> map)
      : image = map['image'],
        id = map['id'],
        confidence = map['confidence'];
}
