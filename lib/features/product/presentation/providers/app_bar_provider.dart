import 'package:flutter/material.dart';

class AppBarProvider extends ChangeNotifier {
  // initial

  int _indexImage = 0;

  final List<String> _listImage = [
    "https://www.klopmart.com/uploads/article/5-cara-memilih-gerinda-yang-baik_MjAyMTAzMjYwODU4NDAx.jpg",
    "https://mesintrade.com/wp-content/uploads/2021/01/Mesin-2Bgerinda-2Bmodern-2Bm-3320.jpg",
    "https://www.klopmart.com/uploads/article/5-cara-memilih-gerinda-yang-baik_MjAyMTAzMjYwODU4NDAx.jpg",
    "https://www.bhinneka.com/_next/image?url=https%3A%2F%2Fstatic.bmdstatic.com%2Fpk%2Fproduct%2Fmedium%2F5d4a261eca1ad.jpg&w=1080&q=75",
    "https://mesintrade.com/wp-content/uploads/2021/01/Mesin-2Bgerinda-2Bmodern-2Bm-3320.jpg",
  ];

  List<String> get listImage => _listImage;
  int get indexImage => _indexImage;

  set setIndexImage(value) {
    _indexImage = value;
    notifyListeners();
  }

  setProductImage() {
    _indexImage = 0;
    notifyListeners();
  }

  String getIndex() {
    String element = _listImage.elementAt(_indexImage);
    return element;
  }

  // constructor
  AppBarProvider();
}
