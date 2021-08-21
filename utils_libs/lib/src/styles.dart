import 'package:flutter/material.dart';
import 'package:utils_libs/utils_libs.dart';
class AppStyle {
  AppStyle._();
  //DEFAULT STYLE
  static const DEFAULT_VERY_SMALL = TextStyle(
      fontFamily: 'Roboto',
      fontSize: AppValue.FONT_SIZE_VERY_SMALL,
      color: COLORS.BLACK,
      height: 1.2);

  static const DEFAULT_SMALL = TextStyle(
      fontFamily: 'Roboto',fontSize: AppValue.FONT_SIZE_SMALL, color: COLORS.BLACK, height: 1.2);

  static const DEFAULT_SMALLs = TextStyle(
      fontFamily: 'Roboto',fontSize: AppValue.FONT_SIZE_SMALLS, color: COLORS.BLACK, height: 1.2);

  static const DEFAULT_MEDIUM = TextStyle(
      fontFamily: 'Roboto',fontSize: AppValue.FONT_SIZE_MEDIUM, color: COLORS.BLACK, height: 1.2);
  static const DEFAULT_MEDIUMS = TextStyle(
      fontFamily: 'Roboto',fontSize: AppValue.FONT_SIZE_MEDIUM, color: COLORS.BLUE, height: 1.2);

  static const DEFAULT_MEDIUM_LINK = TextStyle(
      fontFamily: 'Roboto',fontSize: AppValue.FONT_SIZE_MEDIUM, color: COLORS.BLUE, height: 1.2,decoration: TextDecoration.underline);

  static const DEFAULT_LARGE = TextStyle(
      fontFamily: 'Roboto',fontSize: AppValue.FONT_SIZE_LARGE, color: COLORS.BLACK, height: 1.2);

  static const DEFAULT_VERY_LARGE = TextStyle(
      fontFamily: 'Roboto', fontSize: AppValue.FONT_SIZE_VERY_LARGE,
      color: COLORS.BLACK,
      height: 1.2);

  static const APP_MEDIUM = TextStyle(
      fontSize: AppValue.FONT_SIZE_MEDIUM,
      color: COLORS.PRIMARY_COLOR,
      height: 1.2);

  //DEFAULT STYLE MIX
  // ignore: non_constant_identifier_names
  static final DEFAULT_SMALL_BOLD =
  DEFAULT_SMALL.copyWith(fontWeight: FontWeight.bold);
  // ignore: non_constant_identifier_names
  static final DEFAULT_SMALLs_BOLD =
  DEFAULT_SMALLs.copyWith(fontWeight: FontWeight.bold);
  // ignore: non_constant_identifier_names
  static final DEFAULT_MEDIUM_BOLD =
  DEFAULT_MEDIUM.copyWith(fontWeight: FontWeight.bold);
  // ignore: non_constant_identifier_names
  static final DEFAULT_LARGE_BOLD =
  DEFAULT_LARGE.copyWith(fontWeight: FontWeight.bold);
  // ignore: non_constant_identifier_names
  static final DEFAULT_VERY_LARGE_BOLD =
  DEFAULT_VERY_LARGE.copyWith(fontWeight: FontWeight.bold);
  // ignore: non_constant_identifier_names
  static final RED_HINT_SMALL = DEFAULT_SMALL.copyWith(color: Colors.red);
  // ignore: non_constant_identifier_names
  static final PRODUCT_PRICE = DEFAULT_VERY_SMALL.copyWith(
      height: 1.2,
      color: COLORS.GREY,
      decoration: TextDecoration.lineThrough);
  // ignore: non_constant_identifier_names
  static final PRODUCT_SALE_PRICE = DEFAULT_SMALL.copyWith(
    height: 1.2,
    color: Color(0xFF960909),
  );
  // ignore: non_constant_identifier_names
  static final PRODUCT_PRICE_DETAIL = DEFAULT_MEDIUM.copyWith(
      color: COLORS.GREY, decoration: TextDecoration.lineThrough);
  // ignore: non_constant_identifier_names
  static final PRODUCT_SALE_PRICE_DETAIL = DEFAULT_MEDIUM.copyWith(
    color: Color(0xFF960909),
  );
}

