import 'package:flutter/material.dart';
import 'package:utils_libs/src/models/index.dart';
import 'package:utils_libs/src/preferences_key.dart';
import '../utils_libs.dart';

class Handle<T>{
  Handle._();

  static String? getPath(Map<String, String> path) => path[PreferencesKey.BASE_URL];

  static findItemArrayObject(_elements) => _elements.firstWhere((element) => element['isAdmin'] == true, orElse: () => null);

  static findIndexArrayObject(elements) => elements.lastIndexWhere((item) => item['isAdmin'] == true);

  static isArraysObject(elements, isAdmin) {
    if(isAdmin){
      elements[5]['isAdmin'] = true;
    }else {
      elements[5]['isAdmin'] = false;
    }
    return elements;
  }

  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }


  static isEqualString(a, b) => identical(a, b);

  static isEqualempty(item) => item == null ? [] : item;



  // static T stringToEnum<T>(String str, Iterable<T> values) {
  //   return values.firstWhere(
  //         (value) => value.toString().split('.')[1] == str,
  //     orElse: () => [0],
  //   );
  // }
  // Size size = stringToEnum<Size>("medium", Size.values);

  static String handleIsnull(str) => str != null ? str.toString() : '0';

  static handleParseImage(Map<String, String> env, String avatar) => env[PreferencesKey.BASE_URL].toString() + avatar;

  static bool firstNonNull<T>(List<T> items) => items != null ? true : false;

  static bool firstNonNullString(String str) => str != null ? true : false;
}

enum Size {
  small,
  medium,
  large
}